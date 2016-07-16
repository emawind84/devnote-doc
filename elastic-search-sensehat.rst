.. _elastic-search-sensehat:

=========================================================================
Raspberry Pi + SenseHAT + ElasticSearch + Python + Node-RED = Awesomeness
=========================================================================

So at first there was a **Raspberry Pi** a **SenseHAT** and a **Python** script 
working together gathering information about temperature, pressure, humidity, gravity, motion 
and other cool data all inside a **CSV file**.
Then **Node-RED** joined the group together with **HTML** to help make the study of this data more easier.
But as the data gathered became more and more **Node-RED** starting to feel sick and could not handle
the search of these data anymore (too much stress, too much of them), the **CSV file** didn't want to collaborate.
So he asked help to **ElasticSearch**, a search engine with the only purpose to help searching data, 
tons of them, in a flash.

So this is the story in brief and If you keep reading you will know how it happened.

What you need:

* A Raspberry Pi (The Boss)
* A Sense HAT (The Retriever)
* Python (The Script Professor)
* Node-RED (The IOT God)
* ElasticSearch (The Data Keeper)
* A good code editor

.. seealso::
    | You can see the final result on http://raspi.emawind.com/senselog
    | UI Source: https://github.com/emawind84/sensehat-datalog/tree/data_pagined
    | Senselogger script: https://github.com/emawind84/sensehat-discotest/blob/master/senselogger.py
    | Senselog Import script: https://github.com/emawind84/sensehat-discotest/blob/master/senselog_esimport.py


1. Python - The Logger Script
-----------------------------------------------

We need something in order to save the information gathered from the SenseHAT and persist them.
The following Python script is the PyLog the object that will persist these data in a CSV format.

::

    #!/usr/bin/env python

    from __future__ import print_function, division
    from datetime import datetime
    import atexit, os.path, sys, shutil, logging

    _ori_stdout = sys.__stdout__
    _log = None

    def _init_log():
        global _log
        if not _log:
            _log = PyLog()

    def set_header(header):
        _init_log()
        _log.set_header(header)

    def write_on_file():
        _init_log()
        _log.write_on_file()
            
    def log_data(data):
        _init_log()
        _log.log_data(data)

    def log(msg):
        _init_log()
        _log.log(msg)

    class PyLog:
        # for manual stream redirection
        # sys.stdout = PyLog()
        
        def __init__(self, filename='log.log', create_new=False):
            logging.basicConfig(format='%(asctime)s - %(levelname)s: %(message)s', level=logging.INFO)
            self._logger = logging.getLogger(__name__)
            self._logger.setLevel(logging.INFO)

            self.FILE_NAME = filename
            self.WRITE_FREQ = 10

            self.batch_data = []
            
            # write on file if the application is killed
            atexit.register(self.write_on_file)
            
            if create_new and os.path.isfile(self._get_filename()):
                self._move_log_file()
                
            
        def _move_log_file(self):
            dt = datetime.now()
            datestr = dt.strftime('%Y%m%d_%H%M%S')
            try:
                shutil.copy2(self._get_filename(), self._get_filename() + '.' + datestr)
            except shutil.Error:
                self._logger.error('Failed to copy the log file.')

        def _get_filename(self):
            return self.FILE_NAME
        
        def set_header(self, header):
            """Set the header of the log file"""
            #print('Setting header...', file=ori_stdout)
            if os.path.isfile(self._get_filename()):
                #raise Exception('Logging file already exists!')
                pass
            else:
                with open(self._get_filename(), 'w') as f:
                    f.write(','.join(str(value) for value in header) + '\n')
        
        def write_on_file(self):
            """Write the logged data on the file"""
            self.batch_data
            with open(self._get_filename(), 'a') as f:
                #print("Writing log to file...", file=ori_stdout)
                for line in self.batch_data:
                    #print('line: %s' % line, file=ori_stdout)
                    f.write(line + '\n')
                self.batch_data = []
        
        def log_data(self, data):
            """Log a list of data with comma as divisor"""
            out = ','.join(str(value) for value in data)
            self.batch_data.append(out)
            if len(self.batch_data) >= self.WRITE_FREQ:
                self.write_on_file()

        def log(self, msg):
            """Log a plain text message"""
            dt = datetime.now()
            datestr = dt.strftime('%Y-%m-%d %H:%M:%S')
            self.batch_data.append('[%s] %s' % (datestr, msg))
            if len(self.batch_data) >= self.WRITE_FREQ:
                self.write_on_file()
        
        def write(self, msg):
            """Log a plain text message"""
            self.log(msg)
            
        def flush(self):
            """It should flush the log. The write_on_file will be invoked."""
            write_on_file()

    def main():
        log('This is a test message! Ciao!')
            
    if __name__=='__main__':
        main()

You can try it and see how it works just run it 
and a file log.log will be created in the same folder of the script with the log inside.
We will use it in the next script to save the Sense HAT data.

.. note:: This logger will not persist data immediately, 
    but it use a buffer that wait until 10 rows are generated to save them on the file.


2. Python - Persist Sense HAT Data
-----------------------------------------------

The next script read sensors data from the Sense HAT and ask to PyLog to persist them.

::

    #!/usr/bin/env python

    from sense_hat import SenseHat
    from datetime import datetime
    from threading import Thread, Event
    from pylog import PyLog
    import time, sys, json, atexit

    DELAY = 300

    sense = SenseHat()
    sense_data = []
    header = ['temp_h', 'temp_p', 'humidity', 'pressure',
            'pitch', 'roll', 'yaw',
            'mag_x', 'mag_y', 'mag_z',
            'acc_x', 'acc_y', 'acc_z',
            'gyro_x', 'gyro_y', 'gyro_z',
            'timestamp']

    pylog = PyLog()
    pylog.FILE_NAME = 'senselog.csv'
    #pylog.WRITE_FREQ = 1

    timed_log_stop = Event()

    def quit():
        timed_log_stop.set()
        sys.exit()

    def get_sense_data():
        sense_data = []
        
        sense_data.append(sense.get_temperature_from_humidity())
        sense_data.append(sense.get_temperature_from_pressure())
        sense_data.append(sense.get_humidity())
        sense_data.append(sense.get_pressure())
        
        o = sense.get_orientation()
        yaw = o['yaw']
        pitch = o['pitch']
        roll = o['roll']
        
        sense_data.extend([pitch, roll, yaw])
        
        mag = sense.get_compass_raw()
        sense_data.extend([mag['x'], mag['y'], mag['z']])
        
        acc = sense.get_accelerometer_raw()
        sense_data.extend([acc['x'], acc['y'], acc['z']])
        
        gyro = sense.get_gyroscope_raw()
        sense_data.extend([gyro['x'], gyro['y'], gyro['z']])
        
        sense_data.append(str(datetime.now()))
        
        return sense_data


    def timed_log(stop_event):
        global sense_data
        
        while not stop_event.is_set():
            pylog.log_data(sense_data)
            
            # wait for the delay but check every 0.2s if the thread has been stopped
            for i in range(int(DELAY//0.2)):
                time.sleep(0.2)
                if stop_event.is_set():
                    break

    def main():
        global sense_data
        
        try:
            pylog.set_header(header)
            
            sense_data = get_sense_data()
            t = Thread(target=timed_log, args=(timed_log_stop,))
            t.start()
            
            while True:
                time.sleep(1)
                sense_data = get_sense_data()
                
        except (KeyboardInterrupt, SystemExit):
            quit()

    if __name__ == '__main__':

        if len(sys.argv) > 1:
            pylog.FILE_NAME = sys.argv[1]
            
        main()

If you want to test it, change the DELAY to 10 seconds and run it,
after 30 seconds just kill it and you should have a new file, senselog.csv, in the same folder with the data
of the SenseHAT taken every 10 seconds.

.. note:: By default it will log data every 5 minutes


3. HTML - A Pretty UI
-----------------------------------------------

Now we have lots of number inside a file CSV that you will never read.
Lets make these data a little more readable with a web interface.

.. note:: I am not going to put all the files here 
    so you have to download all the required files from GitHub in order to make it works
    https://github.com/emawind84/sensehat-datalog/releases/latest

The following is the HTML layout, and you will notice that we are going to use 
AngularJS for the logic and Bootstrap to make a pretty UI

.. code-block:: html

    <!DOCTYPE html>
    <html ng-app="senseui">

    <head>
        <title>Sense HAT - Sensor Data Monitoring</title>
        
        <!-- Latest compiled and minified CSS -->
        <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" integrity="sha512-dTfge/zgoMYpP7QbHy4gWMEGsbsdZeCXz7irItjcC3sPUFtf0kuFbDz/ixG7ArTxmDjLXDmezHubeNikyKGVyQ==" crossorigin="anonymous">
        
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        
        <script type="text/javascript" src="//code.jquery.com/jquery-1.11.3.min.js"></script>
        <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/angularjs/1.4.5/angular.min.js"></script>
        <script type="text/javascript" src="date.format.js"></script>
        <script type="text/javascript" src="paging/dirPagination.js"></script>
        
        <script type="text/javascript" src="main.js" ></script>
        
    </head>

    <body>
        
        <div class="container">
            <div class="page-header">
                <h3>Sense HAT - Sensor Data Monitoring</h3>
            </div>
            <div ng-controller="SenseDataController as ctrl">
                <dir-pagination-controls></dir-pagination-controls>
                
                <div class="dropdown">
                    
                </div>
                
                <nav class="navbar navbar-default">
                    <div class="container-fluid">
                        <!-- Collect the nav links, forms, and other content for toggling -->
                        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                            <form name="searchform" class="navbar-form navbar-left" role="search" novalidate 
                            ng-submit="loadData(criteria)">
                                <div class="form-group">
                                    <label>From</label>
                                    <input ng-model="criteria.fromdate" type="date" class="form-control" placeholder="yyyy-MM-dd">
                                    <label>To</label>
                                    <input ng-model="criteria.todate" type="date" class="form-control" placeholder="yyyy-MM-dd">
                                </div>
                                <button type="submit" class="btn btn-default">Submit</button>
                            </form>
                        </div>
                    </div>
                </nav>
                
                <hr>
                
                <table id="pretty-table" class="table table-condensed">
                    <thead>
                        <tr>
                            <th rowspan='2'>No.</th>
                            <th colspan="2">Temperature (C)</th>
                            
                            <th rowspan='2'>Humidity (%)</th>
                            <th rowspan='2'>Pressure (mbar)</th>
                            <th rowspan='2'>Pitch (deg)</th>
                            <th rowspan='2'>Roll (deg)</th>
                            <th rowspan='2'>Yaw (deg)</th>
                            <th colspan="3">Magnetometer (µT)</th>
                            <th colspan="3">Accelerometer (Gs)</th>
                            <th colspan="3">Gyroscope (rad/s)</th>
                            
                            <th rowspan='2'>Timestamp</th>
                        </tr>
                        <tr>
                            <th>from Humidity</th>
                            <th>from Pressure</th>
                            
                            <th>X</th>
                            <th>Y</th>
                            <th>Z</th>
                            
                            <th>X</th>
                            <th>Y</th>
                            <th>Z</th>
                            
                            <th>X</th>
                            <th>Y</th>
                            <th>Z</th>
                        </tr>
                    </thead>
                    <tr dir-paginate="reg in ctrl.data | itemsPerPage: 50">
                        <td>{{$index + 1}}</td>
                        <td>{{reg.temp_h | number : 2 }}</td>
                        <td>{{reg.temp_p | number : 2 }}</td>
                        <td>{{reg.humidity | number : 2 }}</td>
                        <td>{{reg.pressure | number : 2 }}</td>
                        <td>{{reg.pitch | number : 2 }}</td>
                        <td>{{reg.roll | number : 2 }}</td>
                        <td>{{reg.yaw | number : 2 }}</td>
                        <td>{{reg.mag_x | number : 2 }}</td>
                        <td>{{reg.mag_y | number : 2 }}</td>
                        <td>{{reg.mag_z | number : 2 }}</td>
                        <td>{{reg.acc_x | number : 4 }}</td>
                        <td>{{reg.acc_y | number : 4 }}</td>
                        <td>{{reg.acc_z | number : 4 }}</td>
                        <td>{{reg.gyro_x | number : 4 }}</td>
                        <td>{{reg.gyro_y | number : 4 }}</td>
                        <td>{{reg.gyro_z | number : 4 }}</td>
                        <td>{{reg.timestamp | date : 'yyyy-MM-dd HH:mm:ss'}}</td>
                    </tr>
                </table>
                <dir-pagination-controls></dir-pagination-controls>
                <!-- pre>{{ctrl.data | json}}</pre -->
            </div>
        </div>
    </body>

    </html>

and the scipt below

.. code-block:: javascript

    (function ($){
        "use strict";
        
        angular.module('senseui', ['angularUtils.directives.dirPagination'])
        .factory('sensedata', ['$http', '$log', 'dateFilter', function ($http, $log, dateFilter){
            return {
                load: function(d){
                    $log.debug('Loading data with criteria: ', d);
                    return $http({
                        url: "sensedata/",
                        method: "GET",
                        params: {
                            "fromdate": dateFilter(d.fromdate, 'yyyy-MM-dd'),
                            "todate": dateFilter(d.todate, 'yyyy-MM-dd')
                        },
                        responseType: "json"
                    });
                }
            };
        }])
        .controller('SenseDataController', ['sensedata', '$log', '$scope', function(sensedata, $log, $scope){
            var self = this;
            self.data = [];
            
            // default date criteria
            //var _d = new Date(); _d.setHours(0, 0, 0, 0);
            var _d = null;
            
            $scope.sensedata = sensedata;
            $scope.criteria = {
                "fromdate": _d,
                "todate": _d
            };
            
            function loadData(data) {
                sensedata.load(data).then(function(res){
                    $log.debug(res);
                    self.data = res.data;
                }, function(err){
                    $log.debug(err);
                });
            }
            $scope.loadData = loadData;
            
            loadData($scope.criteria);
            
        }]);
        
        
        
    })(jQuery);


4. Node-RED - The Slow Web Service
-----------------------------------

I am not going to tell you how to install and run Node-RED,
what you have here is the flow that you can use to retrieve the CSV data in a JSON format,
ready to be used inside your UI page.

::

    [{"id":"24c118cc.602aa8","type":"csv","z":"138c36fb.d19c81","name":"Sense Data Log","sep":",","hdrin":true,"hdrout":"","multi":"mult","ret":"\\n","temp":"temp_h, temp_p, humidity, pressure, pitch, roll, yaw, mag_x, mag_y, mag_z, acc_x, acc_y, acc_z, gyro_x, gyro_y, gyro_z, timestamp" "x":436.2499694824219,"y":126.25,"wires":[["70f578b6.6b8bf"]]},{"id":"90fc7ff1.596628","type":"file in","z":"138c36fb.d19c81","name":"sense data log","filename":"/home/pi/sensehat/log/senselog.csv","format":"utf8","x":300.2499694824219,"y":181.25,"wires":[["24c118cc.602aa8"]]},{"id":"ef25f378.49425","type":"debug","z":"138c36fb.d19c81","name":"","active":false,"console":"false","complete":"false","x":827.25,"y":161.25,"wires":[]},{"id":"ff990bad.0fb278","type":"http in","z":"138c36fb.d19c81","name":"","url":"/sensedata","method":"get","swaggerDoc":"","x":123.24996948242188,"y":140.25,"wires":[["90fc7ff1.596628","7e16bca.9a430c4"]]},{"id":"b14c527d.bf7b9","type":"inject","z":"138c36fb.d19c81","name":"","topic":"","payload":"","payloadType":"date","repeat":"","crontab":"","once":false,"x":139.24996948242188,"y":201.25,"wires":[["90fc7ff1.596628"]]},{"id":"306becb4.e25a6c","type":"http response","z":"138c36fb.d19c81","name":"","x":838.2499694824219,"y":123.25,"wires":[]},{"id":"d342b14c.c02c38","type":"json","z":"138c36fb.d19c81","name":"","x":645.2499694824219,"y":127.25,"wires":[["ef25f378.49425","44dd40cb.1cf07"]]},{"id":"44dd40cb.1cf07","type":"switch","z":"138c36fb.d19c81","name":"","property":"res","rules":[{"t":"nnull"}],"checkall":"false","outputs":1,"x":740.2499694824219,"y":72.25,"wires":[["306becb4.e25a6c"]]},{"id":"7e16bca.9a430c4","type":"debug","z":"138c36fb.d19c81","name":"","active":false,"console":"false","complete":"req.query","x":319.2499694824219,"y":86.25,"wires":[]},{"id":"70f578b6.6b8bf","type":"function","z":"138c36fb.d19c81","name":"senselog_reader","func":"var drgx = /^([0-9]{4})-([0-9]{2})-([0-9]{2})[\\s|T]([0-9]{2}):([0-9]{2}):([0-9]{2}).[0-9]*Z?/;\nvar today = new Date();\n//today.setTime( today.getTime() - 86400000 );\n\n// search criteria\nvar fromdate = msg.req && msg.req.query.fromdate;\nvar todate = msg.req && msg.req.query.todate;\n\n// convert string to date\nfromdate = fromdate && new Date( fromdate.replace(/-/g, '/') );\ntodate = todate && new Date( todate.replace(/-/g, '/') );\n\n// default value for search criteria\nfromdate = fromdate || today;\n\n// remove time from dates\ntodate && todate.setHours(0,0,0,0);\nfromdate && fromdate.setHours(0,0,0,0);\n\n//node.log('Search criteria: from = ' + fromdate + ' to = ' + todate);\n//node.log('total data length: ' + msg.payload.length);\nvar i = msg.payload.length - 1;\nfor(; i >= 0; i--)\n{\n    var args = drgx.exec(msg.payload[i].timestamp);\n    var _date = new Date(args[1], args[2] - 1, args[3]);\n    if( fromdate && _date < fromdate )\n    {\n        msg.payload.splice(i, 1);\n        continue;\n    }\n    else if( todate && _date > todate )\n    {\n        msg.payload.splice(i, 1);\n        continue;\n    }\n    \n    //msg.payload[i].timestamp = new Date(args[1], args[2] - 1, args[3], args[4], args[5], args[6]).getTime();\n}\n//node.log('filtered data length: ' + msg.payload.length);\nreturn msg;","outputs":1,"noerr":0,"x":558,"y":182,"wires":[["d342b14c.c02c38"]]},{"id":"15f6405e.f11558","type":"comment","z":"138c36fb.d19c81","name":"CSV File Path Here!","info":"","x":310.00001525878906,"y":215.00001621246338,"wires":[]}]

After you imported this flow inside Node-RED, you need to change the location of the CSV file
that the process need to read, just double click on the node above the comment that say 'CSV File Path Here'.

Test it on a browser or on a terminal and change the ip and port with your actual Node-RED server

http://192.168.0.10:1880/sensedata

You should see lots of data in a JSON format.
We are going to use the output in the UI page we already made.


5. Nginx - Server Settings
----------------------

As you can see and you should know now we have a web service on the Raspberry Pi
listening on the port ``1880`` and path ``/sensedata``, 
make sure you are able to use this web service on the page we made, you can see that from the code I put here
I can use the web service just using ``/sensedata`` because on my nginx server I already set a **Proxy Pass**.

You can see my **nginx** server settings below::

    server {
        listen 8086;
        server_name 192.168.0.10 127.0.0.1;
        root /home/pi/sensehat-datalog;
        index index.html;

        location /sensedata {
            proxy_set_header Host $host;
            proxy_pass http://127.0.0.1:1880/sensedata;
        }
    }


So make sure you have all this set up and then you will have a ready to run web interface 
with all your Sense HAT data searchable by date.


5. ElasticSearch - Let's Index All 
--------------------------------------

It's easy to start with ElasticSearch.
Download the source on GitHub https://github.com/elastic/elasticsearch/releases

Extract the archive and inside you will have two important folders, ``config`` and ``bin``.

Before run the service, go to the config folder and replace the content 
of ``elasticsearch.yml`` with the following:

.. code-block:: yaml

    cluster.name: elasticsearch
    node.name: raspi-node-1

    network.bind_host: [192.168.0.10, _local_]
    
    http.port: 9200
    transport.tcp.port: 9300

    discovery.zen.ping.unicast.hosts: ["127.0.0.1", "[::1]"]

    bootstrap.mlockall: true

This will create a cluster named ``elasticsearch`` with one node named ``raspi-node-1``, 
listening on port ``9200``, this is where the Restful API listen for requests.
The port ``9300`` is used internally by ElasticSearch to comunicate between nodes within the cluster.

You can run the engine from the bin folder with the following command::

    $ sh elasticsearch

I made a bash script that you can use to start the service below:

.. code-block:: bash

    #!/usr/bin/env bash

    SCRIPT_BASE_PATH=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
    SCRIPT_NAME="${0##*/}"

    export PATH=/home/pi/python_example/ipython/bin:$PATH

    set -e

    export ES_JAVA_OPTS="-Xmx128m -Xms128m"
    export ES_HEAP_SIZE="128m"

    sh $SCRIPT_BASE_PATH/elasticsearch

It is important to set the variable ``ES_HEAP_SIZE`` and change the default heap memory
to a more suitable one for our Raspberry Pi, 128m should be fine.

You can try ElasticSearch and see if is working going to http://127.0.0.1:9200 with a browser
or on the linux server inside the terminal with::

    curl -XGET http://127.0.0.1:9200?pretty
    {
    "name" : "raspi-node-1",
    "cluster_name" : "elasticsearch",
    "version" : {
        "number" : "2.3.4",
        "build_hash" : "e455fd0c13dceca8dbbdbb1665d068ae55dabe3f",
        "build_timestamp" : "2016-06-30T11:24:31Z",
        "build_snapshot" : false,
        "lucene_version" : "5.5.0"
    },
    "tagline" : "You Know, for Search"
    }


6. Import Data Into ElasticSearch
------------------------------------

Now that ElasticSearch is working we need to index all the data in the CSV file that we gathered so far.
We will use a python script that read the CSV file and index every row inside the search engine.

::

    #!/usr/bin/env python3

    import json, csv, requests, logging
    import dateutil.parser

    CSV_MAP = ['temp_h','temp_p','humidity','pressure',
            'pitch','roll','yaw',
            'mag_x','mag_y','mag_z',
            'acc_x','acc_y','acc_z',
            'gyro_x','gyro_y','gyro_z',
            'timestamp']

    # ElasticSearch parameters
    ES_HOST = '203.239.21.69'
    ES_PORT = '9200'
    ES_INDEX = 'sense'
    ES_TYPE = 'stats'

    CSV_FILE_PATH = 'log/senselog.csv'

    # Lets make some logs!
    logging.basicConfig(format='%(asctime)s - %(levelname)s: %(message)s')
    _logger = logging.getLogger(__name__)
    _logger.setLevel(logging.DEBUG)

    def main():
        s = requests.Session()
        
        r = s.delete( "http://%s:%s/%s/" % (ES_HOST, ES_PORT, ES_INDEX) )
        _logger.debug(r.text)
        
        with open(CSV_FILE_PATH, 'rt') as csvfile:
            reader = csv.reader(csvfile, delimiter=',')
            
            # skip the first line is has header
            next(reader)
            
            for row in reader:
                data =  dict(zip(CSV_MAP, row))
                
                # added time zone because data on the csv file have offset
                timestamp = dateutil.parser.parse( data['timestamp'] + '+0900' )
                # format the date with the offset in order to index the correct date
                data['timestamp'] = timestamp.strftime('%Y-%m-%dT%H:%M:%S.%f%z')
                
                r = s.put( "http://%s:%s/%s/%s/%s" % 
                        (ES_HOST, ES_PORT, ES_INDEX, ES_TYPE, data['timestamp']), 
                        data=json.dumps(data))
                _logger.debug(r.text)
            
    if __name__ == '__main__':
        main()


In the script you need to change some parameters like ``ES_HOST``, ``ES_PORT`` and ``CSV_FILE_PATH``.
If you execute the script, it will output the response of every request of every line inside the CSV file,
so you can check if data is being indexed or not.

.. note:: When you index data inside ElasticSearch you always need an ``index`` and a ``type``, 
    in my case they are 'sense' and 'stats', you can leave these values or change them if you want.

.. note:: If you change the index and type to use in ElasticSearch 
    make sure you modify the web services inside Node-RED in the next step.

Now go to http://127.0.0.1:9200/sense/stats/_search?pretty
and you should see some data coming out.


6. Node-RED - The Game Change
------------------------------

We have all the data we gathered so far inside the search engine, and we are ready to read them.
We need to change the web service we made in Node-RED in order to read from ElasticSearch
and not anymore from the CSV file.

::

    [{"id":"d1d5f84c.f57458","type":"http request","z":"138c36fb.d19c81","name":"","method":"POST","ret":"obj","url":"http://127.0.0.1:9200/sense/stats/_search","x":463,"y":837.5,"wires":[["f9b6805e.5b4c4"]]},{"id":"46adf09b.b23028","type":"http in","z":"138c36fb.d19c81","name":"","url":"/el/sensedata","method":"get","swaggerDoc":"","x":126,"y":788,"wires":[["5bdc3c40.3fe87c","d85c178c.29e57"]]},{"id":"5bdc3c40.3fe87c","type":"function","z":"138c36fb.d19c81","name":"Read Criteria","func":"var fromdate = msg.req && msg.req.query.fromdate;\nvar todate = msg.req && msg.req.query.todate;\nfromdate = fromdate || 'now-1d/d';\ntodate = todate || 'now/d';\n\nmsg.payload = {\n    \"query\": {\n        \"range\" : {\n            \"timestamp\" : {\n                \"gte\" : fromdate,\n                \"lte\" :  todate,\n                \"format\": \"yyyy-MM-dd\",\n                \"time_zone\": \"+09:00\"\n            }\n        }\n    },\n    \"size\": 1000,\n    \"sort\": [\n        {\"timestamp\" : {\"order\" : \"asc\"}}\n    ]\n};\nreturn msg;","outputs":1,"noerr":0,"x":326,"y":784.5,"wires":[["d1d5f84c.f57458"]]},{"id":"dec36da7.203aa","type":"debug","z":"138c36fb.d19c81","name":"","active":false,"console":"false","complete":"false","x":758,"y":856,"wires":[]},{"id":"bb97d84a.77202","type":"inject","z":"138c36fb.d19c81","name":"","topic":"","payload":"","payloadType":"date","repeat":"","crontab":"","once":false,"x":151,"y":830.5,"wires":[["5bdc3c40.3fe87c"]]},{"id":"8a624324.7512c","type":"json","z":"138c36fb.d19c81","name":"","x":731,"y":791,"wires":[["cba225c4.b87b8"]]},{"id":"f9b6805e.5b4c4","type":"function","z":"138c36fb.d19c81","name":"","func":"var drgx = /^([0-9]{4})-([0-9]{2})-([0-9]{2})[\\s|T]([0-9]{2}):([0-9]{2}):([0-9]{2}).[0-9]*(Z?)/;\nvar eresult = msg.payload.hits.hits;\nvar result = [];\nfor(var i=0; i<eresult.length; i++){\n    result.push(eresult[i]._source)\n    var args = drgx.exec(result[i].timestamp);\n    if(args[7] === 'Z') {\n        //result[i].timestamp = Date.UTC(args[1], args[2] - 1, args[3], args[4], args[5], args[6]);\n    } else {\n        //result[i].timestamp = new Date(args[1], args[2] - 1, args[3], args[4], args[5], args[6]).getTime();\n    }\n}\nmsg.payload = result;\nreturn msg;","outputs":1,"noerr":0,"x":597,"y":792.5,"wires":[["dec36da7.203aa","8a624324.7512c"]]},{"id":"d85c178c.29e57","type":"debug","z":"138c36fb.d19c81","name":"","active":false,"console":"false","complete":"req.query","x":320,"y":878,"wires":[]},{"id":"7a057e4e.a44b88","type":"comment","z":"138c36fb.d19c81","name":"Search with ElasticSearch","info":"","x":142,"y":748.5,"wires":[]},{"id":"cba225c4.b87b8","type":"switch","z":"138c36fb.d19c81","name":"","property":"res","rules":[{"t":"nnull"}],"checkall":"false","outputs":1,"x":849,"y":793,"wires":[["4997e08.c37d2a"]]},{"id":"4997e08.c37d2a","type":"http response","z":"138c36fb.d19c81","name":"","x":971,"y":793,"wires":[]}]

Then you can see I changed the name of the service in /el/sensedata so we need to change
the proxy pass we made on nginx server (or apache) with::

    server {
        listen 8086;
        server_name 192.168.0.10 127.0.0.1;
        root /home/pi/sensehat-datalog;
        index index.html;

        location /sensedata {
            proxy_set_header Host $host;
            proxy_pass http://127.0.0.1:1880/el/sensedata;
        }
    }

Nothing else change, your web interface will work as usual but just lots faster!


7. Node-RED - Let's Index New Data
-----------------------------------

Until here you are able to read all the data you indexed on ElasticSearch,
but if you want to update the search engine with new data, 
you need to execute the import script that will update your index with new data from the CSV file.

There is a better solution, we make a service on Node-RED that monitor the file CSV, so when it change,
it will index automatically the new data in ElasticSearch 
and we don't have to worry about importing again all the CSV File.
Just copy the flow below inside Node-RED

::

    [{"id":"1a32ae6c.158442","type":"http request","z":"138c36fb.d19c81","name":"Save Data","method":"PUT","ret":"obj","url":"http://127.0.0.1:9200/sense/stats/{{{id}}}","x":734,"y":614.5,"wires":[["6a0c1ec2.5c72a8"]]},{"id":"9cccfc5b.fe3218","type":"tail","z":"138c36fb.d19c81","name":"Monitor CSV","filetype":"text","split":true,"filename":"/home/pi/sensehat/log/senselog.csv","x":94,"y":615.5,"wires":[["897f3dd7.826e58"]]},{"id":"4bc6826d.6e6864","type":"function","z":"138c36fb.d19c81","name":"","func":"var drgx = /^([0-9]{4})-([0-9]{2})-([0-9]{2})\\s([0-9]{2}):([0-9]{2}):([0-9]{2}).[0-9]*/;\nfor(var i = 0; i < msg.payload.length; i++){\n    var args = drgx.exec(msg.payload[i].timestamp);\n    msg.payload[i].timestamp = new Date(args[1], args[2] - 1, args[3], args[4], args[5], args[6]).toISOString();\n}\n\n// we have to pass only one row\nmsg.payload = msg.payload[0];\nmsg.id = msg.payload.timestamp;\n\nreturn msg;","outputs":1,"noerr":0,"x":443,"y":614.5,"wires":[["2a66377b.0e6e78","46db7649.0ca9a"]]},{"id":"89b5cc09.94cba8","type":"comment","z":"138c36fb.d19c81","name":"Add Sense Data to ElasticSearch","info":"","x":151,"y":576.5,"wires":[]},{"id":"897f3dd7.826e58","type":"csv","z":"138c36fb.d19c81","name":"Sense Data Log","sep":",","hdrin":false,"hdrout":"","multi":"mult","ret":"\\n","temp":"temp_h, temp_p, humidity, pressure, pitch, roll, yaw, mag_x, mag_y, mag_z, acc_x, acc_y, acc_z, gyro_x, gyro_y, gyro_z, timestamp","x":280,"y":615,"wires":[["4bc6826d.6e6864"]]},{"id":"2a66377b.0e6e78","type":"json","z":"138c36fb.d19c81","name":"","x":580,"y":615,"wires":[["1a32ae6c.158442","6a0c1ec2.5c72a8"]]},{"id":"46db7649.0ca9a","type":"debug","z":"138c36fb.d19c81","name":"","active":false,"console":"false","complete":"false","x":596,"y":662,"wires":[]},{"id":"6a0c1ec2.5c72a8","type":"debug","z":"138c36fb.d19c81","name":"","active":false,"console":"false","complete":"false","x":829,"y":663,"wires":[]}]