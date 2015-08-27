.. _kill-inactive-sessions:

=======================
Kill Inactive Sessions 
=======================



.. note::

    .. include:: ../python-example-header.txt

    
filename => ``ex34.py``

::

	
	list = sql('''
	SELECT S.machine,
	        TO_CHAR (S.LOGON_TIME, 'YYYY/MM/DD HH24:MI:SS') LOGON_TIME,
	        S.sid,
	        S.serial#,
	        P.PID ORACLE_PID,
	        P.SPID OS_PID,
	        S.STATUS,
	        S.USERNAME ORACLE_USER,
	        S.OSUSER OS_USER,
	        S.TERMINAL,
	        S.PROGRAM
	   FROM V$PROCESS P LEFT OUTER JOIN V$SESSION S ON P.ADDR = S.PADDR
	  WHERE P.BACKGROUND IS NULL AND P.PID > 1
	  and S.SERIAL# not in  ( select SERIAL# from V$SESSION where AUDSID = userenv('SESSIONID')  )
	  ORDER BY S.machine, TO_CHAR (S.LOGON_TIME, 'YYYY/MM/DD HH24:MI:SS');
	''')
	
	for s in list:
		print 'Killing ' + str(s['SID']) + '...'
		sqlexec("alter system kill session '" + str(s['SID']) + "," + str(s['SERIAL#']) + "';")