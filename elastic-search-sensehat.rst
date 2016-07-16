.. _elastic-search-sensehat:

=========================================================================
Raspberry Pi + SenseHAT + ElasticSearch + Python + Node-RED = Awesomeness
=========================================================================

So at first there was a Raspberry Pi a SenseHAT and a Python script 
working together gathering information about
temperature, pressure, humidity, gravity, motion and other cool data all inside a CSV file,
then Node-RED joined the group together with HTML to help make the study of this data more easier.
But as the data gathered became more and more Node-RED starting to feel sick and could not handle
the search of these data anymore (too much stress, too much of them), the CSV file didn't want to collaborate, 
so he asked help to ElasticSearch, a search engine with the only purpose to help searching data, tons of them, in a flash.

So this is the story in brief and If you keep reading you will know how it happened.

What you need:

#. A Raspberry Pi (The Boss)
#. A Sense HAT (The Retriever)
#. Python (The Script Professor)
#. Node-RED (The IOT God)
#. ElasticSearch (The Data Keeper)
#. A good code editor


1. The Logger Script

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

2. Persist Sense HAT Data

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


3. A Pretty UI

Now we have lots of number inside a file CSV that you will never read.
Lets make these data a little more readable with a web interface.

.. note:: I am not going to put all the files here 
    so you have to download all the required files from GitHub in order to make it works
    https://github.com/emawind84/sensehat-datalog/releases/latest

The following is the HTML layout, and you will notice that we are going to use 
AngularJS for the logic and Bootstrap to make a pretty UI::

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

and the scipt below::

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


4. Node-RED - The Web Service **/sensedata**

I am not going to tell you how to install and run Node-RED,
what you have here is the flow that you can use to retrieve the CSV data in a JSON format,
ready to be used inside your UI page.

::

    [{"id":"24c118cc.602aa8","type":"csv","z":"138c36fb.d19c81","name":"Sense Data Log","sep":",","hdrin":true,"hdrout":"","multi":"mult","ret":"\\n","temp":"temp_h, temp_p, humidity, pressure, pitch, roll, yaw, mag_x, mag_y, mag_z, acc_x, acc_y, acc_z, gyro_x, gyro_y, gyro_z, timestamp","x":436.2499694824219,"y":126.25,"wires":[["70f578b6.6b8bf"]]},{"id":"90fc7ff1.596628","type":"file in","z":"138c36fb.d19c81","name":"sense data log","filename":"/home/pi/sensehat/log/senselog.csv","format":"utf8","x":300.2499694824219,"y":181.25,"wires":[["24c118cc.602aa8"]]},{"id":"ef25f378.49425","type":"debug","z":"138c36fb.d19c81","name":"","active":false,"console":"false","complete":"false","x":827.25,"y":161.25,"wires":[]},{"id":"ff990bad.0fb278","type":"http in","z":"138c36fb.d19c81","name":"","url":"/sensedata","method":"get","swaggerDoc":"","x":123.24996948242188,"y":140.25,"wires":[["90fc7ff1.596628","7e16bca.9a430c4"]]},{"id":"b14c527d.bf7b9","type":"inject","z":"138c36fb.d19c81","name":"","topic":"","payload":"","payloadType":"date","repeat":"","crontab":"","once":false,"x":139.24996948242188,"y":201.25,"wires":[["90fc7ff1.596628"]]},{"id":"306becb4.e25a6c","type":"http response","z":"138c36fb.d19c81","name":"","x":838.2499694824219,"y":123.25,"wires":[]},{"id":"d342b14c.c02c38","type":"json","z":"138c36fb.d19c81","name":"","x":645.2499694824219,"y":127.25,"wires":[["ef25f378.49425","44dd40cb.1cf07"]]},{"id":"44dd40cb.1cf07","type":"switch","z":"138c36fb.d19c81","name":"","property":"res","rules":[{"t":"nnull"}],"checkall":"false","outputs":1,"x":740.2499694824219,"y":72.25,"wires":[["306becb4.e25a6c"]]},{"id":"7e16bca.9a430c4","type":"debug","z":"138c36fb.d19c81","name":"","active":false,"console":"false","complete":"req.query","x":319.2499694824219,"y":86.25,"wires":[]},{"id":"70f578b6.6b8bf","type":"function","z":"138c36fb.d19c81","name":"senselog_reader","func":"var drgx = /^([0-9]{4})-([0-9]{2})-([0-9]{2})[\\s|T]([0-9]{2}):([0-9]{2}):([0-9]{2}).[0-9]*Z?/;\nvar today = new Date();\n//today.setTime( today.getTime() - 86400000 );\n\n// search criteria\nvar fromdate = msg.req && msg.req.query.fromdate;\nvar todate = msg.req && msg.req.query.todate;\n\n// convert string to date\nfromdate = fromdate && new Date( fromdate.replace(/-/g, '/') );\ntodate = todate && new Date( todate.replace(/-/g, '/') );\n\n// default value for search criteria\nfromdate = fromdate || today;\n\n// remove time from dates\ntodate && todate.setHours(0,0,0,0);\nfromdate && fromdate.setHours(0,0,0,0);\n\n//node.log('Search criteria: from = ' + fromdate + ' to = ' + todate);\n//node.log('total data length: ' + msg.payload.length);\nvar i = msg.payload.length - 1;\nfor(; i >= 0; i--)\n{\n    var args = drgx.exec(msg.payload[i].timestamp);\n    var _date = new Date(args[1], args[2] - 1, args[3]);\n    if( fromdate && _date < fromdate )\n    {\n        msg.payload.splice(i, 1);\n        continue;\n    }\n    else if( todate && _date > todate )\n    {\n        msg.payload.splice(i, 1);\n        continue;\n    }\n    \n    //msg.payload[i].timestamp = new Date(args[1], args[2] - 1, args[3], args[4], args[5], args[6]).getTime();\n}\n//node.log('filtered data length: ' + msg.payload.length);\nreturn msg;","outputs":1,"noerr":0,"x":558,"y":182,"wires":[["d342b14c.c02c38"]]}]


5. ElasticSearch - Let's Index All 


6. Node-RED - We need to change some stuff