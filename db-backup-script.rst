.. _db-backup-script:

=============================
Oracle DB Backup Shell Script
=============================

This backup script is only valid for Linux server.

File dbdump.sh

.. code-block:: bash
	
	#!/bin/sh
	
	export ORACLE_HOME=/u01/app/oracle/product/11.2.0/dbhome_1
	export ORACLE_SCHEMA=$2
	export ORACLE_SID=$1
	
	EXPORT_FOLDER=/home/sangah/dbdump
	ORACLE_USER=<USER>
	ORACLE_PASSWORD=<PASSWORD>
	DATE=$(date +"%Y%m%d_%H%M")
	
	$ORACLE_HOME/bin/expdp $ORACLE_USER/$ORACLE_PASSWORD \
	directory=SANGAH_DUMP_DIR schemas=${ORACLE_SCHEMA} \
	dumpfile=$DATE-${ORACLE_SCHEMA}_export.dmp \
	logfile=$DATE-${ORACLE_SCHEMA}_export.log rows=y consistent=y feedback=1000
	
	cd $EXPORT_FOLDER
	tar cjf $DATE-${ORACLE_SCHEMA}_export.tar.bz2 \
	$DATE-${ORACLE_SCHEMA}_export.dmp \
	$DATE-${ORACLE_SCHEMA}_export.log
	
	rm $EXPORT_FOLDER/$DATE-${ORACLE_SCHEMA}_export.dmp $EXPORT_FOLDER/$DATE-${ORACLE_SCHEMA}_export.log
	
	find $EXPORT_FOLDER/*${ORACLE_SCHEMA}_export.tar.bz2 -mtime +15 -delete

File dbbackup.sh

	Append to this file all the users that you want to backup.

.. code-block:: bash
	
	#!/bin/sh
	
	# Add the following line to crontab ( to edit crontab use the command: crontab -e )
	# 05 12 * * * sh /home/sangah/script/dbbackup.sh
	
	echo Starting DB backup...
	sh /home/sangah/script/dbdump.sh AL32UTF8 YRP
	sh /home/sangah/script/dbdump.sh AL32UTF8 LCT
	sh /home/sangah/script/dbdump.sh AL32UTF8 DSP
	...
	

Put these files in a folder on the server, then type

::
	
	> crontab -e


Add the following schedule to the crontab and save

::

	05 12 * * * sh /home/sangah/script/dbbackup.sh 
	
	
.. note:: Replace the folder */home/sangah/script/* with your folder.
	