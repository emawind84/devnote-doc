.. highlight:: console

.. _oracle-install-centos:

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
	
Install the pre-install package.

For Centos 6.x::

	# yum install oracle-rdbms-server-11gR2-preinstall
	
For Centos 5.x::

	# yum install oracle-validated
	
	
	
2. Setting Hostname
----------------------

Open the ``/etc/sysconfig/network`` file and modify the ``HOSTNAME`` to match your FQDN (Fully Qualified Domain Name) host name::
	
	# vi /etc/sysconfig/network
	
Check that ``HOSTNAME`` has a set value:

	# HOSTNAME=pmis.sangah.com
	

Open ``/etc/hosts`` file and add fully qualified hostname for the server::

	# vi /etc/hosts
	
You need to put the external ip if not present::

	192.168.246.128             pmis.sangah.com
	
Now you need to restart networking on the server to make sure that changes will be persistent on reboot::

	# /etc/init.d/network restart
	
3. Oracle User Settings
----------------------------------

First lets add the user and group if they don't exist::

	# useradd oracle
	# group add oinstall
	# usermod -a -G oinstall oracle

Set the password for the “oracle” user::

	# passwd oracle

Add the entry to file ``/etc/security/limits.d/90-nproc.conf`` as described below::

	# vi /etc/security/limits.d/90-nproc.conf

::
	
	# Default limit for number of user's processes to prevent
	# accidental fork bombs.
	# See rhbz #432903 for reasoning.
	
	*          soft    nproc     1024
	# To this
	* - nproc 16384

Set SELinux to ``permissive`` mode by editing the file ``/etc/selinux/config``::

	# vi /etc/selinux/config
	
::

	SELINUX=permissive

The server should be restarted to reflect the new changes::

	# reboot

Login as user ``oracle`` and edit the file ``.bash_profile``::

	# vi .bash_profile
	
::
	
	# Oracle Settings
	TMP=/tmp; export TMP
	TMPDIR=$TMP; export TMPDIR
	
	ORACLE_HOSTNAME=oracle.tecmint.com; export ORACLE_HOSTNAME
	ORACLE_UNQNAME=DB11G; export ORACLE_UNQNAME
	ORACLE_BASE=/u01/app/oracle; export ORACLE_BASE
	ORACLE_HOME=$ORACLE_BASE/product/11.2.0/dbhome_1; export ORACLE_HOME
	ORACLE_SID=DB11G; export ORACLE_SID
	PATH=/usr/sbin:$PATH; export PATH
	PATH=$ORACLE_HOME/bin:$PATH; export PATH
	
	LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib; export LD_LIBRARY_PATH
	CLASSPATH=$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib; export CLASSPATH export PATH
	
.. seealso:: http://www.joshstaiger.org/archives/2005/07/bash_profile_vs.html


4. Download & Prepare Oracle for Installation
--------------------------------------------------

Create the directories and set the appropriate permissions in which the Oracle software will be installed::
		
	# mkdir -p /u01/app/oracle/product/11.2.0/dbhome_1
	# chown -R oracle:oinstall /u01
	# chmod -R 775 /u01
	
The Oracle package contains 2 zip files which you must first accept the license 
agreement before downloading.

For Linux x86 Systems::

	http://download.oracle.com/otn/linux/oracle11g/R2/linux_11gR2_database_1of2.zip
	http://download.oracle.com/otn/linux/oracle11g/R2/linux_11gR2_database_2of2.zip

For Linux x86-64 Systems::

	http://download.oracle.com/otn/linux/oracle11g/R2/linux.x64_11gR2_database_1of2.zip
	http://download.oracle.com/otn/linux/oracle11g/R2/linux.x64_11gR2_database_2of2.zip

Extract compressed Oracle database source files to the same directory ``/home/oracle/``::

	$ unzip linux_11gR2_database_1of2.zip
	$ unzip linux_11gR2_database_2of2.zip
	
5. Oracle Installation
--------------------------------

Go remote to the server using VNC (`vnc guide`_).
Switch to ``root`` user and issue the following command to allow Oracle user to access X Server::

	# xhost +
	
.. seealso:: `Remote Desktop using VNC with SSH Tunnel (Windows)`__
	
Switch back to ``oracle`` user and now we are ready to install Oracle::
	
	$ cd database
	$ export LC_ALL=en_US.utf8
	$ ./runInstaller

.. important::	
	Follow the rest of the guide `here <http://www.evernote.com/shard/s14/sh/9ccddf5a-aeba-493b-b9d6-73122df708fc/486596b5962fe2eaa69c6f14c222f9f2>`_

*More to come...*

.. __:
.. _vnc guide: http://www.evernote.com/shard/s14/sh/5986af8f-4046-4330-83d8-533919c03835/ed74a0f8a6aff99b92f5920769e1c6d8