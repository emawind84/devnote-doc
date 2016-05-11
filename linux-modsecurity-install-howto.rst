.. _linux-modsecurity-install-howto:

==============================================
Linux - How to Install ModSecurity for Apache
==============================================

1. Enable ``mod_unique_id`` module
-------------------------------------

Make sure you have the ``mod_unique_id`` module installed. The module is packaged with Apache Http.

Check if mod_unique_id is enabled with::

	$ sudo apachectl -M | grep unique_id
	Syntax OK
	 unique_id_module (shared)
	 
if the command doesn't return the mod name we need to enable it with::

	$ cd /etc/apache2/mods-enabled
	$ sudo ln -s ../mods-available/unique_id.load .

The commands will be little different if you use Centos or Windows.

Test configuration with::

	$ apachectl -t
	Syntax OK

Restart the server::

	# for Ubuntu
	$ sudo service apache2 reload

	# for Centos
	$ sudo service httpd reload

Now try again the command::

	$ sudo apachectl -M | grep unique_id
	Syntax OK
	 unique_id_module (shared)


Now the module is enabled and you can go to step 2.



2. Take the source files
------------------------------------

Take the source files from http://www.modsecurity.org/download.html.
Or just execute the command below::

	$ wget https://www.modsecurity.org/tarball/2.9.1/modsecurity-2.9.1.tar.gz
	


3. Install Dependencies Libraries
-----------------------------------

Before keep going we need to install some dependencies.

For Ubuntu::

	# apt-get install apache2-dev
	# apt-get install liblua5.1-0-dev
	# apt-get install libxml2-dev

For Centos::

	# yum install httpd-devel
	# yum install libxml2-devel
	# yum install lua-static

For compiling the module apxs is required.

.. note:: APXS: https://httpd.apache.org/docs/current/programs/apxs.html

Find apxs location we need to use it later::

	$ which apxs
	/usr/sbin/apxs



4. Extract and Install
----------------------------

Extract the archive with you have already downloaded::

	$ tar -xvf modsecurity-2.9.1.tar.gz
	$ cd modsecurity-2.9.1
	
Configure and change the path of apxs with the correct one::

	$ ./configure --with-apxs=/usr/sbin/apxs
	
Make and install::

	$ make
	$ sudo make install
	

After the installation the module file should be in one of these locations:

- ``/usr/local/modsecurity/lib/mod_security2.so``
- ``/usr/lib/apache2/modules/mod_security2.so``
- ``/usr/local/apache2/modules/mod_security2.so``

Check if the file ``mod_security2.so`` is present inside the Apache ``modules`` folder,
if not, copy the file inside the folder.

Edit the main Apache httpd config file (usually ``httpd.conf`` or ``apache2.conf``)

On UNIX you must load ``libxml2`` and ``lua5.1`` before enabling ModSecurity with something like this:

::

	#The libraries can be in different locations

	#For Ubuntu:
	LoadFile /usr/lib/x86_64-linux-gnu/libxml2.so
	LoadFile /usr/lib/x86_64-linux-gnu/liblua5.1.so

	#For Centos:
	LoadFile /usr/lib64/libxml2.so
	LoadFile /usr/lib64/liblua-5.1.so

Load the ModSecurity module adding the following directive to ``httpd.conf`` or ``apache2.conf``

::

	LoadModule security2_module modules/mod_security2.so

	

5. Configuration
-------------------------------

We need to copy the default configuration file for the module inside apache conf folder.

.. important:: Change the apache folder accordingly

Go to the extracted source folder (in my case ``modsecurity-2.9.1``)
and follow these commands.

For Ubuntu::

	$ cd modsecurity-2.9.1
	$ cp modsecurity.conf-recommended /etc/apache2/conf-available/modsecurity.conf
	$ cp unicode.mapping /etc/apache2/conf-enabled/
	$ cd /etc/apache2/conf-enabled
	$ ln -s /etc/apache2/conf-available/modsecurity.conf .

For Centos::

	$ cd modsecurity-2.9.1
	$ cp modsecurity.conf-recommended /etc/httpd/conf.d/modsecurity.conf
	$ cp unicode.mapping /etc/httpd/conf.d/

In this case inside ``apache2.conf`` or ``httpd.conf`` there will be a directive like

::

	# For Ubuntu:
	IncludeOptional conf-enabled/*.conf

	# For Centos:
	Include conf.d/*.conf


Test the configuration with::

	$ apachectl -t
	Syntax OK

6. CRS Configuration
--------------------------

.. note:: 

	OWASP ModSecurity Core Rule Set Project - OWASP -> (https://www.modsecurity.org/CRS/Documentation/quickstart.html)

Get the archive with all the rules from here:
https://github.com/SpiderLabs/owasp-modsecurity-crs/releases

For this tutorial I will use the version 2.2.9 taken from here:
https://github.com/SpiderLabs/owasp-modsecurity-crs/releases/tag/2.2.9

::

	$ cd /usr/local/modsecurity/
	$ wget https://github.com/SpiderLabs/owasp-modsecurity-crs/archive/2.2.9.tar.gz
	$ tar -xvf 2.2.9.tar.gz

Rename the folder because too long...::

	$ mv owasp-modsecurity-crs-2.2.9 crs
	$ cd crs
	$ mv modsecurity_crs_10_setup.conf.example modsecurity_crs_10_setup.conf

Copy inside the folder ``activated_rules`` all the rules that you find here:

http://125.141.221.126/repo/STND_PMIS_util/mod-security/pmis_rules

Create a file ``modsecurity_crs_99_whitelist.conf`` inside the ``activated_rules`` folder
and add the following whitelist directives at the end of the file:

Whitelisted rules -> http://125.141.221.126/repo/STND_PMIS_util/mod-security/pmis_rules.conf


Add the following directives to the main apache conf file and change the location with the right one:

::


	# Apache 2.4
	IncludeOptional /usr/local/modsecurity/crs/*.conf
	IncludeOptional /usr/local/modsecurity/crs/activated_rules/*.conf

	# Apache 2.2
	Include /usr/local/modsecurity/crs/*.conf
	Include /usr/local/modsecurity/crs/activated_rules/*.conf



8. Activate ModSecurity
---------------------------

ModSecurity by default is ``DetectionOnly`` in order to stop bad things happening 
we need to change the ``SecRuleEngine`` directive and turn it ``On``!

::

	$ cd /etc/httpd/conf.d
	$ sudo sed -i "s/SecRuleEngine DetectionOnly/SecRuleEngine On/" modsecurity.conf


Restart the apache server and we have done!



9. Read the log!
----------------------

ModSecurity will write his log into the file defined from the following directive::

	SecAuditLog logs/modsec_audit.log
	
Check it and see if it block bad things!

.. note::

	Reference Manual
		https://github.com/SpiderLabs/ModSecurity/wiki/Reference-Manual