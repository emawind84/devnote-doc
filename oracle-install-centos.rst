.. _oracle-install-centos:
.. highlight:: console

========================================================
Oracle 11g r2 Installation on RHEL/CentOS 6.x/5.x/4.x
========================================================

1. Installing Dependencies
-----------------------------

We need to install a pre-install package

.. important:: 
	| For Centos 6.x the package name is ``oracle-rdbms-server-11gR2-preinstall``
	| For Centos 5.x/4.x the package name is ``oracle-validated``
	
Update the system first!::

	yum update
	
Add oracle repository:

For Centos 6.x::

	# cd /etc/yum.repos.d
	# wget http://public-yum.oracle.com/public-yum-ol6.repo
	
For Centos 5.x::

	# cd /etc/yum.repos.d
	# wget https://public-yum.oracle.com/public-yum-el5.repo
	
You might need to add the GPG key:

For Centos 6.x::

	# wget https://public-yum.oracle.com/RPM-GPG-KEY-oracle-ol6 -O /etc/pki/rpm-gpg/RPM-GPG-KEY-oracle
	
For Centos 5.x::

	# wget https://public-yum.oracle.com/RPM-GPG-KEY-oracle-el5 -O /etc/pki/rpm-gpg/RPM-GPG-KEY-oracle
	
2. Setting Hostname
----------------------

Open the ``/etc/sysconfig/network`` file and modify the ``HOSTNAME`` to match your FQDN (Fully Qualified Domain Name) host name.::
	
	# vi /etc/sysconfig/network
	
Check that ``HOSTNAME`` has a set value:

	# HOSTNAME=pmis.sangah.com
	

Open ``/etc/hosts`` file and add fully qualified hostname for the server.::

	# vi /etc/hosts
	
You need to put the external ip if not present.::

	192.168.246.128             pmis.sangah.com
	
Now you need to restart networking on the server to make sure that changes will be persistent on reboot.::

	# /etc/init.d/network restart
	
	
*More to come...*