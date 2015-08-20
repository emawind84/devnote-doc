.. highlight:: sql
.. _oracle-tablespace-schema-howto:

=====================================
How to Oracle DB Tablespace & Schema
=====================================

.. note:: The original article http://www.rastertek.com/oratut04.html.


Now that we have a database we can create schemas inside the database. 
A schema is defined as a user that owns data such as tables, views, indexes, and so forth. 
If a user has no data of their own and just connects and queries 
for information then they are not considered a schema. 
This is the difference between a schema and a user. 
Also you may be familiar with other database systems and will notice that what Oracle calls 
a schema the other systems call a database.
The Oracle database can have numerous schemas and each schema 
in the database can query other schemas in the same database. 
Also schemas can communicate over database links to schemas in other remote databases. 
The communication between schemas is only limited by the permissions you put in place. 
Generally most applications will sit inside just a single schema.

Creating the Tablespace
-----------------------------

Before creating a schema you will need to create a file (or more than one file) for the schema to place its data into. This file (or set of files) where the schema writes its data is called a tablespace. Note that you can create more than one tablespace for a schema and then have it write tables to one tablespace and indexes into the other and so forth. However we are going to keep this tutorial simple and just create a single tablespace that is made up of a single 1GB file.
First connect to the database from the command line as the sys user:
$ sqlplus /nolog

::

	SQL> connect / as sysdba

Now that you are connected you can create a tablespace. The definition that I use below creates a tablespace called CRAIG_DATA which is sized 1GB and uses the data file /ora/fs2000/u04/CRAIG/craig_data_01.dbf. You can change this to whatever you want to call the tablespace and data file.

::

	SQL> create tablespace CRAIG_DATA
		datafile '/ora/fs2000/u04/CRAIG/craig_data_01.dbf' size 1000M
		extent management local autoallocate segment space management auto;


Another example:

::

	create tablespace SYC datafile '/u02/oradata/AL32UTF8/syc_data_01.dbf' size 1000M 
	extent management local autoallocate segment space management auto;


Creating the User
--------------------

With the tablespace created we can now create the user. 
The reasoan we had to create the tablespace first was that the tablespace name is used in the definition of the user.
 
To create a user we use the following string which creates a user named craig 
with password craig and uses the tablespace CRAIG_DATA. 
Of course change the name, password, and tablespace to your own:

::

	SQL> create user craig identified by "craig" default tablespace CRAIG_DATA;

Now that the user is created we will give them some basic permissions so they can start working. 

The first permission they will need is called CONNECT. 
This will allow them to connect to the database. The second permission they will need is quota 
on their tablespace so they can write to it. 
And finally we will give them one more permission called CREATE TABLE which will allow them to create tables. 
You will notice that Oracle has a fine control over everything users are allowed to do. 
Here is the syntax for the three permissions (change the names to your own):

::

	SQL> grant connect to craig;
	SQL> alter user craig quota unlimited on CRAIG_DATA;
	SQL> grant create table to craig;


Drop a Tablespace
------------------------

::

	DROP TABLESPACE SRH
		INCLUDING CONTENTS 
		and datafiles
			CASCADE CONSTRAINTS; 


Listing Tablespaces and Default Storage Parameters
-----------------------------------------------------

::

	SELECT TABLESPACE_NAME "TABLESPACE",
	INITIAL_EXTENT "INITIAL_EXT",
	NEXT_EXTENT "NEXT_EXT",
	MIN_EXTENTS "MIN_EXT",
	MAX_EXTENTS "MAX_EXT",
	PCT_INCREASE
	FROM DBA_TABLESPACES;

Listing the Datafiles and Associated Tablespaces of a Database
-----------------------------------------------------------------

::
	
	SELECT  FILE_NAME, BLOCKS, TABLESPACE_NAME
	FROM DBA_DATA_FILES;

Alter a Tablespace
--------------------

::

	ALTER TABLE <TABLE NAME to be moved> MOVE TABLESPACE <destination TABLESPACE NAME>
