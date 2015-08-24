.. _db-version-info:

================
DB Version Info 
================


``ex22.py``

::

	
	from pmis.common.xml import Xml
	res = sql("select major,minor,type,to_char(applied,'YYYYMMDD HH24MISS')applied from(select * from db_version order by applied desc) where rownum=1;")
	print '{"major":"' + str(res[0]['MAJOR']) + '","minor":"' + str(res[0]['MINOR']) + '","applied":"' + str(res[0]['APPLIED']) + '"}'