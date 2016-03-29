.. highlight:: bash

.. _tomcat-apache-new-server-settings:

.. sectionauthor:: Emanuele Disco <emanuele.disco@sangah.com>

=================================================
Linux Server Configuration Apache HTTP - Tomcat
=================================================

#. Update System
-----------------------

::

	# for Centos
	yum update
	
	# for Ubuntu
	apt-get update && apt-get upgrade

1. Create User sangah and folder SAPP
-----------------------------------------

::

	useradd sangah

	mkdir /home/sangah/SAPP


2. Install PDF Conversion Tool (wkhtmltopdf)
----------------------------------------------

Checkout on your local computer the folder ``STND_PMIS_util/htmltopdf`` from the SVN.

URL: **http://125.141.221.126/repo/STND_PMIS_util/htmltopdf**

Copy the right version on the server and install it with::

	# for Centos
	rpm -i wkhtmltox-0.12.2.1_linux-centos6-amd64.rpm
	
	# for Ubuntu
	dpkg --install wkhtmltox-0.12.2.1_linux-wheezy-amd64.deb

Find the location of the executable for later use with::

	which wkhtmltopdf
	/usr/local/bin/wkhtmltopdf
	


3. Install Chinese/Japanese/Korean Support Packages
-----------------------------------------------------

First check the locale on the server and make sure is set as ``UTF-8``::

	locale charmap
	UTF-8

	echo $LANG
	ko_KR.UTF-8

Install some language packages

**For Centos**

::

	yum groupinstall "Chinese Support"
	yum groupinstall "Japanese Support"
	yum groupinstall "Korean Support"
	yum groupinstall "Kannada Support"
	yum groupinstall "Hindi Support"

**For Ubuntu**

::

	apt-get install language-pack-zh \
	msttcorefonts \
	xfonts-intl-chinese \
	xfonts-intl-chinese-big \
	fonts-arphic-uming \
	ttf-unifont



4. Install MS Fonts and Pmis Fonts for PDF Conversion
-------------------------------------------------------

Checkout the folder ``STND_PMIS_util/etc/fonts`` on your computer.

URL: **http://125.141.221.126/repo/STND_PMIS_util/etc/fonts**

Make a new directory on the server where we will put the fonts::

	mkdir /usr/share/fonts/pmisfonts

Place all the \*tff files in the new directory using WinSCP. 

Then execute the following command to update the font cache::

	fc-cache -f -v



5. Download & Install Apache Tomcat
----------------------------------------

We are going to take Apache Tomcat 7 
from the official website https://tomcat.apache.org/download-70.cgi.

Make an ``util`` folder inside the ``sangah`` home if you didn't already::

	mkdir /home/sangah/util
	cd /home/sangah/util

Download Tomcat and extract the archive::

	wget http://mirror.apache-kr.org/tomcat/tomcat-7/v7.0.68/bin/apache-tomcat-7.0.68.tar.gz
	tar -xvf apache-tomcat-7.0.68.tar.gz
	
We will place the tomcat folder in ``/usr/local`` leaving a copy of the directory for future use::

	sudo cp -r apache-tomcat-7.0.68 /usr/local/
	
Rename the folder that we moved to ``/usr/local`` to reflect the project name ( ex. ``tomcat7-LGSP`` )::

	cd /usr/local
	sudo mv apache-tomcat-7.0.68 tomcat7-PROJECT_CODE

We need to add the file ``setenv.sh`` inside the ``bin`` folder of the new Tomcat to set some memory settings::

	cd tomcat7-PROJECT_CODE/bin
	touch setenv.sh
	nano setenv.sh
	
Put this line inside the file and edit it accordingly::

	export JAVA_OPTS="-Dfile.encoding=UTF-8 -Xms128m -Xmx2G -XX:PermSize=64m -XX:MaxPermSize=512m -Djava.awt.headless=true -Xloggc:$CATALINA_BASE/logs/gc.log -XX:+PrintGCDetails -XX:+PrintGCDateStamps -XX:+PrintGCTimeStamps"

Edit ``-Xmx`` parameter in case you need to change the **Max Heap Size** memory and leave the rest unchanged.



6. Tomcat ``server.xml`` settings
------------------------------------

We need to configure the ``server.xml`` inside ``conf`` directory. 
Replace all the content of the file with the following and modify it accordingly

::
	
	<?xml version="1.0" encoding="UTF-8"?>
	<Server port="8005" shutdown="SHUTDOWN">

		<!--APR library loader. Documentation at /docs/apr.html -->
		<Listener SSLEngine="on" className="org.apache.catalina.core.AprLifecycleListener"/>
		<!--Initialize Jasper prior to webapps are loaded. Documentation at /docs/jasper-howto.html -->
		<Listener className="org.apache.catalina.core.JasperListener"/>
		<!-- Prevent memory leaks due to use of particular java/javax APIs-->
		<Listener className="org.apache.catalina.core.JreMemoryLeakPreventionListener"/>
		<Listener className="org.apache.catalina.mbeans.GlobalResourcesLifecycleListener"/>
		<Listener className="org.apache.catalina.core.ThreadLocalLeakPreventionListener"/>

		<GlobalNamingResources>
			<Resource auth="Container" description="User database that can be updated and saved" 
			factory="org.apache.catalina.users.MemoryUserDatabaseFactory" 
			name="UserDatabase" pathname="conf/tomcat-users.xml" type="org.apache.catalina.UserDatabase"/>
		</GlobalNamingResources>

		<Service name="STND">
			
			<!-- you don't need this if you use AJP with Apache HTTP
			<Connector URIEncoding="UTF-8" 
				acceptCount="100" 
				connectionTimeout="20000" 
				disableUploadTimeout="true" 
				enableLookups="false" 
				maxPostSize="-1" 
				maxThreads="150" 
				port="8003" 
				redirectPort="443"/>
			-->
				
			<Connector URIEncoding="UTF-8" enableLookups="false" port="9007" protocol="AJP/1.3" redirectPort="443"/>

			<Engine defaultHost="localhost" jvmRoute="ajp13" name="STND">
				<Realm className="org.apache.catalina.realm.UserDatabaseRealm" resourceName="UserDatabase"/>
				<Host appBase="C:\Users\Disco\workspace_4.5\STND_PMIS_comm_branch" 
				autoDeploy="false" deployOnStartup="false" name="localhost" 
				unpackWARs="false" xmlNamespaceAware="false" xmlValidation="false">
					
					<Context docBase="web" path="" reloadable="false"  />
				</Host>
			</Engine>
		</Service>

	</Server>



7. Create Project folder
-----------------------------

Create the project folder under ``/home/sangah/SAPP``::

	mkdir /home/sangah/SAPP
	cd /home/sangah/SAPP
	mkdir PROJECT_FOLDER
	cd PROJECT_FOLDER
	mkdir web



8. Deploy the web folder under the new project folder
-------------------------------------------------------

Use WinSCP to upload all the files (jsp, class, ecc...) 
inside the new ``web`` under the project directory



9. Create ``log``, ``thumb``, ``temp`` and ``edms`` folder under project folder
---------------------------------------------------------------------------------

Create some folders under the project directory required for the execution::

	cd /home/sangah/SAPP/PROJECT_FOLDER
	mkdir log
	mkdir thumb
	mkdir temp
	mkdir edms
	
Create a symbolic link to edms folder under the web/data folder::

	cd /home/sangah/SAPP/PROJECT_FOLDER
	cd web/data
	ln -s /home/sangah/SAPP/PROJECT_FOLDER/edms .

10. Create ``/home/sangah/SAPP/util/pdf`` and create a symbolic link for wkhtmltopdf
-----------------------------------------------------------------------------------------------------

Make sure the executable exists::

	ls -l /usr/local/bin/wkhtmltopdf

This is not required but for convenience make a symbolic link to the wkhtmltopdf executable
inside our SAPP folder::

	cd /home/sangah/SAPP
	mkdir util
	cd util
	mkdir pdf
	cd pdf
	ln -s /usr/local/bin/wkhtmltopdf .

.. note:: Remember to set the property ``coverter.htmltopdf`` later in with the correct path.



11. Upload struts.properties, log4j.properties and system_config_ko.properties to ~/WEB-INF/classes
-----------------------------------------------------------------------------------------------------

Using WinSCP upload the following files inside the project ``classes`` folder:

- struts.properties
	Struts configuration file
	
- log4j.properties
	Log4j Logging configuration file

- system_config_ko.properties
	System configuration file



12. Configure system_config_ko.properties
---------------------------------------------

Good time for editing ``system_config_ko.properties``

- fix all the path to the web folder
- fix all the url & domain
- fix the temporary folder
- fix the thumbnail folder
- fix the path to the pdf converter
- fix db instance
- fix login page
- fix email service
- ecc...



13. Download mod_jk (Tomcat Connector for Apache HTTP)
--------------------------------------------------------

Before starting you should know the location of the apache configuration folder. 
Usually it should be ``/etc/httpd`` for Centos or ``/etc/apache2`` for Ubuntu server.

Check if the server has already mod_jk installed::

	# for Ubuntu
	ls /usr/lib/apache2/modules/mod_jk.so
	
	# for Centos
	ls /usr/lib64/httpd/modules/mod_jk.so
	
If the module is already present just skip to the configuration;
you do NOT need to install the connector again if is already present.

Install dependencies for compiling the connector, 
we need the Apache Development libraries and gcc*::

	# for Centos
	yum install httpd-devel
	yum install gcc*

	# for Ubuntu
	apt-get install apache2-dev gcc*
	
Download the tomcat connector from here http://archive.apache.org/dist/tomcat/tomcat-connectors/jk/

::

	wget http://archive.apache.org/dist/tomcat/tomcat-connectors/jk/tomcat-connectors-1.2.41-src.tar.gz
	tar -xvf tomcat-connectors-1.2.41-src.tar.gz	



14. Compile and install mod_jk
----------------------------------

Make sure you have apxs with::

	ls /usr/bin/apxs
	
Compile and install::

	cd tomcat-connectors-1.2.41-src
	cd native
	./configure --with-apxs=/usr/bin/apxs
	make
	sudo make install


Check that the module has been placed in the modules folder of apache.

::
	
	# for Ubuntu
	ls /usr/lib/apache2/modules/mod_jk.so
	
	# for Centos
	ls /usr/lib64/httpd/modules/mod_jk.so
	
	

15. Load module mod_jk for Apache HTTP
---------------------------------------

We need to tell apache about the new module or he will not load it.

In a Centos server do the following::

	cd /etc/httpd/cond.d
	touch jk.conf
	nano jk.conf
	
Place the following content inside the file jk.conf::

	LoadModule jk_module modules/mod_jk.so
	<IfModule jk_module>
		JkWorkersFile    conf/workers.properties
		JkLogFile        logs/mod_jk.log
		JkLogLevel       info
	</IfModule>

Create a file ``workers.properties`` inside the conf directory where you will need to put the 
AJP configuration::

	worker.list=worker1
	
	worker.worker1.port=8010
	worker.worker1.host=localhost
	worker.worker1.type=ajp13


16. Create a conf file for the project under the folder conf.d of Apache
---------------------------------------------------------------------------

From the apache folder create a new configuration file for the project inside the ``conf.d`` folder::

	cd conf.d
	touch project.conf
	
Place into the file the VirtualHost settings similar to the following:

:ref:`apache-pmis-conf-example`

.. important::
 To make all of this working inside the ``httpd.conf`` there should be a line like this::

	Include conf.d/*.conf


17. Change permission of /home/sangah to 755
----------------------------------------------

Make sure every users can access the web directory or you will get an access denied.

Change the permissions to 755 for the folders until the ``web`` if necessary.


--------------------


18. [Centos] Change Enforcement on SAPP folder
--------------------------------------------------

**This step is only for Centos server!**

SELinux Enforcement is a problem for web application 
and to prevent a Permission Denied error we need to fix it.

::

	# install dependencies
	yum install policycoreutils-python
	
	# disable enforcement for SAPP folder
	semanage fcontext -a -t public_content_t '/home/sangah/SAPP(/.*)?'
	
	# update permissions
	restorecon -R /home/sangah/SAPP
	
We just told to Centos that the ``SAPP`` folder is a directory that contains web content
and so the enforcement will be disabled for this directory and all the subdirectories.


-----------------------


[Extra] Install Nginx File Upload Server
-----------------------------------------------

:ref:`nginx-file-upload-handler`



[Extra] Install Apache Tomcat Load Balancer
---------------------------------------------------

:ref:`load_balancer_howto`



[Extra] Install HTML builder & loader (PhantomJS)
---------------------------------------------------

*TODO*


.. seealso:: Other resources:

	- :ref:`apache-pmis-conf-example`
	- :ref:`system-properties`
	- :ref:`howto-oracledb-user-import&export`
	- :ref:`oracle-tablespace-schema-howto`
	- :ref:`oracle-install-centos`