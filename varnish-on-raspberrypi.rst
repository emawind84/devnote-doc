.. _varnish-on-raspberrypi:

Install Varnish on a Raspberry Pi
=========================================

.. seealso::
    | Reference:
    | https://www.varnish-cache.org/docs/trunk/reference/vcl.html#reference-vcl-probes
    | http://www.weedpi.com/how-to/install-varnish-in-raspberry-pi
    | compile and install: https://www.devolve.net/blog/2013/12/29/probable-compiler-bug-on-raspberry-pi/

    **Built in subroutines** - https://www.varnish-cache.org/docs/trunk/users-guide/vcl-built-in-subs.html


1. First install ``checkinstall``

::

    $ sudo apt-get install checkinstall

2. Take the Varnish software from GitHub

::

    $ sudo git clone https://github.com/varnish/Varnish-Cache.git
    $ cd Varnish-Cache/

3. Get some pre-requisites. Don’t worry if you have some of them they wont be reinstalled 
   but if you missed them things may not work as expected.
   
::

    $ sudo apt-get install autotools-dev autoconf libpcre3-dev libedit-dev libncurses5-dev automake libtool groff-base python-docutils pkg-config
    
4. Start the build process – you may not need to run some of these as 
   sudo but its not harmfull to so. This will take about 15 mins
   
::

    $ sudo sh autogen.sh    
    $ sudo sh configure CFLAGS="-O1 -pipe"
    $ sudo make 
    $ sudo checkinstall  
    
5. To make sure your system has an up-to-date linker to point to your correct modules run the following.

::

    $ sudo ldconfig

or::

    $ sudo ldconfig -n /usr/local/lib/

6. We need to create dedicated user for varnishd 
rather than using the default “nobody” user is used for other services

::

    $ sudo useradd varnishd

7. Create a startup script

::

    sudo nano start-varnish.sh
    
8. Copy the following script

.. code-block:: bash
    
    #!/bin/sh
    
    ulimit -n 10240
    ulimit -l 16384
    
    /usr/local/sbin/varnishd \
    -s malloc,256m \
    -a 127.0.0.1:8000 \
    -f /usr/local/etc/varnish/default.vcl \
    -T localhost:6082 \
    -u varnishd \
    -g varnishd \
    -l 8m,1m,+


Health checks
-----------------------

Lets set up a director with two backends and health checks. 
First let us define the backends (edit the file ``default.vcl``)::

    backend server1 {
        .host = "server1.example.com";
        .probe = {
            .url = "/";
            .timeout = 1s;
            .interval = 5s;
            .window = 5;
            .threshold = 3;
        }
    }

What is new here is the probe. 
In this example Varnish will check the health of each backend every 5 seconds, 
timing out after 1 second. Each poll will send a GET request to /. 
If 3 out of the last 5 polls succeeded the backend is considered healthy, otherwise it will be marked as sick.

Test the health status with:: 

    varnishadm debug.health

File example ``default.vcl``
--------------------------------

::
    
    #
    # This is an example VCL file for Varnish.
    #
    # It does not do anything by default, delegating control to the
    # builtin VCL. The builtin VCL is called when there is no explicit
    # return statement.
    #
    # See the VCL chapters in the Users Guide at https://www.varnish-cache.org/docs/
    # and http://varnish-cache.org/trac/wiki/VCLExamples for more examples.
    
    # Marker to tell the VCL compiler that this VCL has been adapted to the
    # new 4.0 format.
    vcl 4.0;
    
    # Default backend definition. Set this to point to your content server.
    backend default {
        .host = "emawind.com";
        .port = "80";
        .connect_timeout = 2s; # Wait a maximum of 1s for backend connection (Apache, Nginx, etc...)
        .first_byte_timeout = 60s; # Wait a maximum of 5s for the first byte to come from your backend
        .between_bytes_timeout = 60s; # Wait a maximum of 2s between each bytes sent
        .probe = {
            .url = "/";
            .timeout = 1s;
            .interval = 5s;
            .window = 5;
            .threshold = 3;
        }
    }
    
    sub vcl_recv {
        unset req.http.cookie;
    
        if (req.method == "GET" && req.url == "/varnish-status") {      
            return(synth(200, "OK"));
        }
    
        # Try a cache-lookup
        return (hash);
    }
    
    sub vcl_backend_response {
        # Below will cache the page for one week.(1s = 1 sec, 1d = 1 day)
        set beresp.ttl = 1w;
    }
    
    sub vcl_backend_error {
        return (retry);
    }

