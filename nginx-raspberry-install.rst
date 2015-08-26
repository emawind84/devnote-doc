.. _nginx-raspberry-install:

Compile & Install Nginx for Raspberry Pi 2
============================================

Download nginx stable version, ``1.8.0`` at the time of writing, from the official website:

.. code-block:: bash

	$ wget http://nginx.org/download/nginx-1.8.0.tar.gz


Compile Nginx with the following configuration:
	
.. code-block:: bash

	$ sudo apt-get install libpcre3-dev zlib1g-dev libssl-dev
	
	
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
	$ sudo checkinstall

After executing checkinstall you will find a deb file, ``nginx_1.8.0-1_armhf.deb``, 
ready to be reinstalled whenever you want.

The configuration files will be located in ``/etc/nginx``.


If it doens't exist create a script in ``/etc/init.d`` folder to manage the nginx daemon:

.. code-block:: bash
	
	#!/bin/sh
	
	### BEGIN INIT INFO
	# Provides:          nginx
	# Required-Start:    $local_fs $remote_fs $network $syslog
	# Required-Stop:     $local_fs $remote_fs $network $syslog
	# Default-Start:     2 3 4 5
	# Default-Stop:      0 1 6
	# Short-Description: starts the nginx web server
	# Description:       starts nginx using start-stop-daemon
	### END INIT INFO
	
	PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
	DAEMON=/usr/sbin/nginx
	NAME=nginx
	DESC=nginx
	
	# Include nginx defaults if available
	if [ -f /etc/default/nginx ]; then
		. /etc/default/nginx
	fi
	
	test -x $DAEMON || exit 0
	
	set -e
	
	. /lib/lsb/init-functions
	
	test_nginx_config() {
		if $DAEMON -t $DAEMON_OPTS >/dev/null 2>&1; then
			return 0
		else
			$DAEMON -t $DAEMON_OPTS
			return $?
		fi
	}
	
	case "$1" in
		start)
			echo -n "Starting $DESC: "
			test_nginx_config
			# Check if the ULIMIT is set in /etc/default/nginx
			if [ -n "$ULIMIT" ]; then
				# Set the ulimits
				ulimit $ULIMIT
			fi
			start-stop-daemon --start --quiet --pidfile /var/run/$NAME.pid \
				--exec $DAEMON -- $DAEMON_OPTS || true
			echo "$NAME."
			;;
	
		stop)
			echo -n "Stopping $DESC: "
			start-stop-daemon --stop --quiet --pidfile /var/run/$NAME.pid \
				--exec $DAEMON || true
			echo "$NAME."
			;;
	
		restart|force-reload)
			echo -n "Restarting $DESC: "
			start-stop-daemon --stop --quiet --pidfile \
				/var/run/$NAME.pid --exec $DAEMON || true
			sleep 1
			test_nginx_config
			# Check if the ULIMIT is set in /etc/default/nginx
			if [ -n "$ULIMIT" ]; then
				# Set the ulimits
				ulimit $ULIMIT
			fi
			start-stop-daemon --start --quiet --pidfile \
				/var/run/$NAME.pid --exec $DAEMON -- $DAEMON_OPTS || true
			echo "$NAME."
			;;
	
		reload)
			echo -n "Reloading $DESC configuration: "
			test_nginx_config
			start-stop-daemon --stop --signal HUP --quiet --pidfile /var/run/$NAME.pid \
				--exec $DAEMON || true
			echo "$NAME."
			;;
	
		configtest|testconfig)
			echo -n "Testing $DESC configuration: "
			if test_nginx_config; then
				echo "$NAME."
			else
				exit $?
			fi
			;;
	
		status)
			status_of_proc -p /var/run/$NAME.pid "$DAEMON" nginx && exit 0 || exit $?
			;;
		*)
			echo "Usage: $NAME {start|stop|restart|reload|force-reload|status|configtest}" >&2
			exit 1
			;;
	esac
	
	exit 0



.. seealso::

	- `Flask+uwsgi+nginx`_
	- `proxy_set_header`_
	- `Nginx Reverse Proxy`_
	- `Understanding Nginx HTTP Proxying, Load Balancing, Buffering, and Caching`_
	
.. _Understanding Nginx HTTP Proxying, Load Balancing, Buffering, and Caching: 
	https://www.digitalocean.com/community/tutorials/understanding-nginx-http-proxying-load-balancing-buffering-and-caching
.. _Flask+uwsgi+nginx: 
	https://www.digitalocean.com/community/tutorials/how-to-serve-flask-applications-with-uwsgi-and-nginx-on-ubuntu-14-04	
.. _proxy_set_header: 
	http://nginx.org/en/docs/http/ngx_http_proxy_module.html#proxy_set_header
.. _Nginx Reverse Proxy: https://www.nginx.com/resources/admin-guide/reverse-proxy/