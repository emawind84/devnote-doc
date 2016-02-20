.. highlight:: bash

==================================================
Nginx File Upload Handler Install & Configuration
==================================================

About Nginx
    https://www.nginx.com/resources/wiki/start/topics/tutorials/gettingstarted/

1. Download nginx

    Go `here <http://nginx.org/en/download.html>`_ for the latest version or...

    Version 1.8 -> http://nginx.org/download/nginx-1.8.1.tar.gz

2. Extract the folder where you want with::

    $ tar -xvf nginx-1.8.1.tar.gz

3.  Install the required libraries

    For Centos::

        $ sudo yum install -y httpd-devel pcre perl pcre-devel zlib zlib-devel openssl-devel
        
    For Ubuntu::

        $ sudo apt-get install libpcre3-dev zlib1g-dev libssl-dev

4. Execute the following commands in sequence inside the nginx folder::

    $ ./configure \
    --user=nginx                          \
    --group=nginx                         \
    --prefix=/etc/nginx                   \
    --sbin-path=/usr/sbin/nginx           \
    --conf-path=/etc/nginx/nginx.conf     \
    --pid-path=/var/run/nginx.pid         \
    --lock-path=/var/run/nginx.lock       \
    --error-log-path=/var/log/nginx/error.log \
    --http-log-path=/var/log/nginx/access.log \
    --with-http_gzip_static_module        \
    --with-http_stub_status_module        \
    --with-http_ssl_module                \
    --with-pcre                           \
    --with-file-aio                       \
    --with-http_realip_module

    $ make
    $ sudo make install

5.  Nginx is installed. Now go to /etc/nginx and we need to change some files. 
    From this `repository <https://github.com/emawind84/nginx-upload-handler-conf.git>`_
    take the following file::

        $ sudo wget https://raw.githubusercontent.com/emawind84/nginx-upload-handler-conf/master/nginx_configure.sh \
        -O /etc/nginx/configure.sh
        
        $ sudo chmod +x configure.sh
        $ sudo ./configure

    This script should grab several files from the repository, test the configuration for errors
    and test a file upload on the server. If everything is ok you should see some instructions
    for starting, stopping and reloading nginx.::

        ...
        nginx: [warn] duplicate MIME type "text/html" in /etc/nginx/nginx.conf:40
        nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
        nginx: configuration file /etc/nginx/nginx.conf test is successful
        Starting nginx server...
        nginx: [warn] duplicate MIME type "text/html" in /etc/nginx/nginx.conf:40
        https://www.nginx.com/resources/wiki/start/topics/tutorials/commandline/
        Start nginx using: nginx
        Reload nginx using: nginx -s reload
        Stop nginx using: nginx -s stop
		
6. Add the following Proxy configuration to the Apache VirtualHost::

    <VirtualHost *:9080>
	    ServerAdmin webmaster@dummy-host.example.com
	    ...
	
	    ProxyPass "/upload" "http://127.0.0.1:8180/upload"
	    ProxyPassReverse "/upload" "http://127.0.0.1:8180/upload"