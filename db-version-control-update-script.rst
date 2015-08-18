.. _db-version-control-update-script:

================================
DB Version Control Update Script
================================

This code prevent the query to be executed multiple times.

.. note:: If the version is already present the query block will be skipped.

.. code-block:: sql

	-- check if version already exists
	declare v_tmp number;v_major number := <VERSION>; begin
	select nvl((select major from DB_VERSION where MAJOR = v_major), 0) into v_tmp from dual;if v_tmp = 0 then
	INSERT INTO DB_VERSION VALUES( v_major, 0, sysdate, 'sql' );
	-- if doesn't exist execute queries
	
		-- put your query here
	
	-- end procedure here
	end if;end;
	-- ADD NEW CODE AFTER THIS LINE >>>>

.. note:: Replace *<VERSION>* with your svn commit revision