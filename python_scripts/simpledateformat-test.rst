.. _simpledateformat-test:

======================
SimpleDateFormat Test 
======================


``ex13.py``

::

	
	from java.text import *
	
	sdf = SimpleDateFormat("yyyyMMddHHmmss")
	
	df = DateFormat.getDateTimeInstance(DateFormat.MEDIUM, DateFormat.MEDIUM, Locale('en','US'))
	print df.format( sdf.parse( '20130101102020' ) ).encode('UTF-8')