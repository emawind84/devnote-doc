Import Schema from an Oracle DB Into AWS RDS Instance
===========================================================

Grant the right stuff to do the job to the source db user
-------------------------------------------------------------------------

.. note:: To do on the source DB

::

    grant execute on dbms_datapump to yrp;
    grant execute on dbms_file_transfer to yrp;     

Create the db link to connect the source with the destination db
-------------------------------------------------------------------------

.. note:: To do on the source DB

::

    create database link to_rds2 connect to root identified by Admin123
    using '(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=pmis-test1.ccdekrumjwcq.ap-northeast-2.rds.amazonaws.com)(PORT=1521))(CONNECT_DATA=(SID=ORCL)))';

Transfer the dump file to the amazing AWS DB instance
-------------------------------------------------------------------------

.. note:: To do on the source DB

::

    BEGIN
    DBMS_FILE_TRANSFER.PUT_FILE(
    source_directory_object       => 'DATA_PUMP_DIR',
    source_file_name              => '20171128_0300-YRP_export.dmp',
    destination_directory_object  => 'DATA_PUMP_DIR',
    destination_file_name         => 'pmis_test.dmp',
    destination_database          => 'to_rds2'
    );
    END;
    /

Create a beautiful tablespace with start size of 2G and autoresize
-------------------------------------------------------------------------

.. note:: To do on the destination DB

::

    create tablespace pmis1 datafile size 2G
    autoextend on next 10M extent management local
    segment space management auto;


Create an awesome user with default tablespace and grant some cool authorities
-------------------------------------------------------------------------

.. note:: To do on the destination DB

::

    create user pmis1 identified by pmis1 default tablespace pmis1;
    grant connect to pmis1;
    grant create table to pmis1;
    alter user pmis1 quota unlimited on pmis1;

Start the Dump Import
-------------------------------------------------------------------------

.. note:: To do on the destination DB

::

    DECLARE
    hdnl NUMBER;
    BEGIN
    hdnl := DBMS_DATAPUMP.OPEN( operation => 'IMPORT', job_mode => 'SCHEMA', job_name=>null);
    DBMS_DATAPUMP.ADD_FILE( handle => hdnl, filename => 'pmis_test.dmp', directory => 'DATA_PUMP_DIR', filetype => dbms_datapump.ku$_file_type_dump_file);
    DBMS_DATAPUMP.METADATA_REMAP(hdnl,'REMAP_SCHEMA','YRP','PMIS1');
    DBMS_DATAPUMP.METADATA_REMAP(hdnl,'REMAP_TABLESPACE','YRP','PMIS1');
    DBMS_DATAPUMP.START_JOB(hdnl);
    END;
    /    

Check the Job Status
-------------------------------------------------------------------------

.. note:: To do on the destination DB

::

    select * from ALL_SCHEDULER_JOB_RUN_DETAILS;

Delete the dump file from RDS instance
-------------------------------------------------------------------------

.. note:: To do on the destination DB

Check the dump files present on the server with::

    select * from table(RDSADMIN.RDS_FILE_UTIL.LISTDIR('DATA_PUMP_DIR')) order by mtime;

Then delete the file with the following procedure::

    exec utl_file.fremove('DATA_PUMP_DIR','<file name>');


Create a dump file
---------------------------

Replace the filename ``<<DUMP FILENAME>>`` and the schema name ``<<SCHEMA NAME>>`` with the right values.

::

    DECLARE
        handle NUMBER;
    BEGIN
        handle := DBMS_DATAPUMP.open (operation => 'EXPORT', job_mode => 'SCHEMA', job_name    => null, version => 'LATEST');
        DBMS_DATAPUMP.ADD_FILE (handle => handle, filename => 'export.log', directory => 'DATA_PUMP_DIR', filetype => DBMS_DATAPUMP.KU$_FILE_TYPE_LOG_FILE);
        DBMS_DATAPUMP.ADD_FILE (handle => handle,filename => '<<DUMP FILENAME>>',directory => 'DATA_PUMP_DIR',filetype => DBMS_DATAPUMP.KU$_FILE_TYPE_DUMP_FILE);
        DBMS_DATAPUMP.METADATA_FILTER (handle => handle,name => 'SCHEMA_EXPR',VALUE => 'IN (''<<SCHEMA NAME>>'')');
        DBMS_DATAPUMP.START_JOB (handle);
        DBMS_DATAPUMP.DETACH (handle);
    END;
    /


Kill sessions
-------------------------

https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Appendix.Oracle.CommonDBATasks.System.html#Appendix.Oracle.CommonDBATasks.DisconnectingSession
