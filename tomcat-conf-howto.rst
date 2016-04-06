.. _tomcat-conf-howto:

Apache Tomcat Service Install How-To
=======================================

.. seealso:: https://tomcat.apache.org/tomcat-7.0-doc/windows-service-howto.html


[Windows Tomcat as a Service]
-----------------------------------

Reference: http://tomcat.apache.org/tomcat-6.0-doc/windows-service-howto.html

Install Tomcat Service::
     
     bin> service.bat install tomcat6.1

Remove Tomcat Service::

     bin> service.bat remove
    
Execute Tomcat Monitor::

     Option1 -> bin> tomcat6.1w.exe //MS//
     Option2 -> bin> tomcat6w.exe //MS//Tomcat6.1
    
Update Servive Display Name::

     bin> tomcat6.exe //US//tomcat6.1 --DisplayName="Apache Tomcat 6.1"
    

Make sure to add this java options::

    -Dfile.encoding=UTF-8
    -Xms128m
    -Xmx1024m
    -XX:PermSize=64m
    -XX:MaxPermSize=512m
    -Djava.awt.headless=true


.. note:: 64-bit Tomcat Environment

    1. Install Java 64bit for Windows
    2. Install 64bit Apache Tomcat 7.X/8.X `link <http://apache.mirror.cdnetworks.com/tomcat/tomcat-7/v7.0.64/bin/apache-tomcat-7.0.64-windows-x64.zip>`_
    3. Set the correct java version inside the Tomcat Monitor
       
       .. image:: _images/win_tomcat_set.png


[Windows Tomcat as runnable application]
------------------------------------------------

Create a file setenv.bat and put this file into the bin folder

Put the following content inside this file::

    set "JAVA_OPTS=-Dfile.encoding=UTF-8 -Xms128m -Xmx1024m -XX:PermSize=64m -XX:MaxPermSize=512m -Djava.awt.headless=true"
    exit /b 0




[Linux]
-----------------------------------

Create a file setenv.sh and put this file into the bin folder

Put this content inside this file::

    export JAVA_OPTS="-Dfile.encoding=UTF-8 -Xms128m -Xmx1024m -XX:PermSize=64m -XX:MaxPermSize=512m -Djava.awt.headless=true"

.. note:: 64-bit Tomcat Environment

    1. Make sure the java version is 64bit
    2. Change setenv.sh with the desired HeapSize (``-Xmx``) as the following (leave PermSize as it is)::
    
        export JAVA_OPTS="-Dfile.encoding=UTF-8 -d64 -Xms128m -Xmx2g -XX:PermSize=64m -XX:MaxPermSize=512m -Djava.awt.headless=true"
      

[Extra options]
-----------------------------------

For logging java garbage collector add this java options (CATALINA_BASE have to be set!)::

    -Xloggc:$CATALINA_BASE/logs/gc.log -XX:+PrintGCDetails -XX:+PrintGCDateStamps -XX:+PrintGCTimeStamps

----------------------------


[Linux] Apache Tomcat Logging Settings
---------------------------------------

Set logging.properties
^^^^^^^^^^^^^^^^^^^^^^^^^

By default with the default settings in ``logging.properties``, Tomcat will rotate the logs and it will logs lots of stuff
and it will write same log on catalina.out and catalina.log and we do not want this in production.

Replace the ``logging.properties`` file inside the ``conf`` folder of tomcat with this::
	
	handlers = 1catalina.org.apache.juli.FileHandler

	.handlers = 1catalina.org.apache.juli.FileHandler

	############################################################
	# Handler specific properties.
	# Describes specific configuration info for Handlers.
	############################################################

	1catalina.org.apache.juli.FileHandler.level = FINE
	1catalina.org.apache.juli.FileHandler.directory = ${catalina.base}/logs
	1catalina.org.apache.juli.FileHandler.prefix = catalina
	1catalina.org.apache.juli.FileHandler.rotatable = false

	############################################################
	# Facility specific properties.
	# Provides extra control for each logger.
	############################################################

Configure a log rotate
^^^^^^^^^^^^^^^^^^^^^^^^

Create a file into /etc/logrotate.d folder:

.. code-block:: bash

	# touch /etc/logrotate.d/tomcat
	
Put this content inside the file::

	/var/log/tomcat/*.log {
		copytruncate
		daily
		rotate 7
		compress
		missingok
		size 5M
	}

Then create a symbolic link to the ``catalina.log``
(replace the path to the tomcat and change the name catalina.log if you need to):

.. code-block:: bash

	ln -s /usr/local/tomcat/logs/catalina.log catalina.log
	
Reload the logrotate deamon:

.. code-block:: bash

	# /usr/sbin/logrotate /etc/logrotate.conf

More on logrorate:

.. code-block:: bash

	# man logrotate
	
-----------------------------------

.. _apache-pmis-conf-example:

Apache Configuration
---------------------------

The following configuration should be added to the Apache file
``httpd-vhosts.conf`` or whatever the configuration file is.

**Adapt the configuration to your project settings**, 
replace ``<PROJECT PATH>`` and ``<PROJECT DOMAIN>``.

.. code-block:: apacheconf

	# Add this for Apache 2.2
	NameVirtualHost *:80

	SetEnvIf Request_URI "^/ext/" dontlog
	SetEnvIf Request_URI "/maintenance.html" no-jk

	<VirtualHost *:80>
		ServerAdmin webmaster@dummy-host.example.com
		DocumentRoot "<PROJECT PATH>/web"
		ServerName <PROJECT DOMAIN>
		ErrorLog "logs/garam-error_log"
		CustomLog "logs/garam-access.log" common env=!dontlog

		DirectoryIndex index.jsp

		<Directory "<PROJECT PATH>/web">
		Options FollowSymLinks
		Order allow,deny
		Allow from all
		</Directory>

		# DENY ACCESS TO WEB-INF
		<Location "/WEB-INF/">
		Deny from all
		</Location>

		#jkMount /*                 balance1
		jkMount /*.jsp              balance1
		jkMount /*.action           balance1
		jkMount /*/edms/*           balance1
		jkMount /logout             balance1
		jkMount /Thumb              balance1
		jkMount /ws/*               balance1
		jkMount /FileDownServlet    balance1

		ErrorDocument 503 /maintenance.html
		<Location /maintenance.html>
		Order allow,deny
		Allow from all
		</Location>

		<IfModule mod_rewrite.c>
		RewriteEngine On
		RewriteCond %{DOCUMENT_ROOT}/maintenance.html -f
		RewriteCond %{DOCUMENT_ROOT}/maintenance.enable -f
		RewriteCond %{SCRIPT_FILENAME} !maintenance.html
		RewriteRule ^.*$ /maintenance.html [R=503,L]
		</IfModule>

		# JK MANAGER
		<Location /jkmanager/>
		JkMount jkstatus
		Order deny,allow
		Deny from all
		Allow from 127.0.0.1
		Allow from 203.239.21.0/24
		</Location>

	</VirtualHost>


... and read this https://httpd.apache.org/docs/2.4/upgrading.html if using **Apache 2.4**.

-------------


SSL Apache Configuration
^^^^^^^^^^^^^^^^^^^^^^^^^^

1. Upload files necessary for using SSL protocol into the server. 

Locate the folder ``/etc/pki/tls`` create folder ``kspmis`` and put the following files:

	_wildcard_kspmis_com.crt
		Server certificate data file
		
	rsa-dv.chain-bundle.pem
		Server CA Certificates
		
	_wildcard_kspmis_com_SHA256WITHRSA.key
		Server private key file
		

2. In order to use SSL verify that ``mod_ssl`` module is enabled.

- ``mod_ssl.so`` should be present in modules folder

- The following directives should be present somewhere. 
	Check files inside extra folder (ex. httpd-ssl.conf)
	and ``httpd.conf``.::
	
		LoadModule ssl_module modules/mod_ssl.so
		Listen 443
			
If the module is not present install it with::

	# for Centos
	yum install mod_ssl
		
			
3. Create a VirtualHost listening on port 80 that will redirect requests from ``*.kspmis.com`` to 443::

	<VirtualHost *:80>
		ServerAlias *.kspmis.com
		#ServerName kamcoybd.kspmis.com
		#ServerAlias www.kamcoybd.kspmis.com
		RewriteEngine on
		ReWriteCond %{SERVER_PORT} !^443$
		RewriteRule ^/(.*) https://%{HTTP_HOST}/$1 [NE,R,L]
	</VirtualHost>

4. Modify the VirtualHost listening on port 80 as follow::

	<VirtualHost *:443>
	...

	# ============ SSL CERTIFICATE HERE =============
	SSLEngine On
	SSLCertificateFile    /etc/pki/tls/kspmis/_wildcard_kspmis_com.crt
	SSLCertificateKeyFile /etc/pki/tls/kspmis/_wildcard_kspmis_com_SHA256WITHRSA.key
	SSLCertificateChainFile /etc/pki/tls/kspmis/rsa-dv.chain-bundle.pem
	# ================================================

5. Test the apache configuration::

	# apachectl -t

	[Thu Feb 25 16:04:11 2016] [warn] _default_ VirtualHost overlap on port 443, the first has precedence
	Syntax OK
		
.. note:: 
	The warning is due to the file ``ssl.conf`` inside the ``conf.d`` folder; 
	the VirtualHost inside that file should be deleted.
		
-------------



.. _load_balancer_howto:

Load Balancer How-To
--------------------------

.. note:: **Reference:** `LoadBalancer HowTo`_

	A load balancer is a worker that does not directly communicate with Tomcat. 
	Instead it is responsible for the management of several "real" workers, 
	called members or sub workers of the load balancer.

	This management includes:

		Instantiating the workers in the web server.
		Using the worker's load-balancing factor, perform weighted load balancing 
		(distributing load according to defined strengths of the targets).
		Keeping requests belonging to the same session executing 
		on the same Tomcat (session stickyness).
		Identifying failed Tomcat workers, suspending requests to them 
		and instead falling-back on other workers managed by the load balancer.
		Providing status and load metrics for the load balancer itself 
		and all members via the status worker interface.
		Allowing to dynamically reconfigure load-balancing via the status worker interface.

	Workers managed by the same load balancer worker are load-balanced 
	(based on their configured balancing factors and current request or session load) 
	and also secured against failure by providing failover to other members of the same load balancer. 
	So a single Tomcat process death will not "kill" the entire site.

	Some of the features provided by a load balancer are even interesting, 
	when only working with a single member worker (where load balancing is not possible).

.. code-block:: properties

	# The load balancer worker balance1 will distribute
	# load to the members worker1 and worker2
	worker.balance1.type=lb
	worker.balance1.balance_workers=worker1, worker2
	worker.list=balance1

	worker.worker1.type=ajp13
	worker.worker1.host=myhost1
	worker.worker1.port=8009

	worker.worker2.type=ajp13
	worker.worker2.host=myhost2
	worker.worker2.port=8010
	
	
.. important:: The name of the Tomcat needs to be equal to the name of the 
	corresponding load balancer member. In the above example, 
	Tomcat on host ``myhost1`` needs ``jvmRoute="worker1"``, 
	Tomcat on host ``myhost2`` needs ``jvmRoute="worker2"``. 

**tomcat1 server.xml**
	
.. code-block:: xml

	<Engine defaultHost="cicciopanza" jvmRoute="worker1" name="default">

**tomcat2 server.xml**
	
.. code-block:: xml

	<Engine defaultHost="cicciopanza" jvmRoute="worker2" name="default">
	
---------------	

.. status_worker_manager:

Status Worker Manager
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Add the following code to the ``workers.properties``.

.. code-block:: properties

	# Add the status worker to the worker list
	worker.list=jkstatus
	# Define a 'jkstatus' worker using status
	worker.jkstatus.type=status
	
Add the following code to the directive VirtualHost inside the host configuration file.

**Apache 2.2**

.. code-block:: apacheconf

	# JK MANAGER
	<Location /jkmanager/>
	JkMount jkstatus
	Order deny,allow
	Deny from all
	Allow from 127.0.0.1
	</Location>


**Apache 2.4**

.. code-block:: apacheconf

	# JK MANAGER
	<Location /jkmanager/>
	JkMount jkstatus
	#Require all denied
	Require ip 127.0.0.1
	</Location>

.. note:: The Status Manager will be available at the URI ``<schema>://127.0.0.1/jkmanager/``.
	If you want to enable other host to access the status manager just add more ``Allow from`` directives.
	
.. code-block:: apacheconf

	# JK MANAGER 2.2
	<Location /jkmanager/>
	JkMount jkstatus
	Order deny,allow
	Deny from all
	Allow from 127.0.0.1
	Allow from 200.300.20.0/24
	Allow from 192.168.0.10
	</Location>
	
	# JK MANAGER 2.4
	<Location /jkmanager/>
	JkMount jkstatus
	
	Require ip 127.0.0.1
	Require ip 200.300.20.0/24
	Require ip 192.168.0.10
	</Location>
	
.. _`LoadBalancer HowTo`: https://tomcat.apache.org/connectors-doc/common_howto/loadbalancers.html