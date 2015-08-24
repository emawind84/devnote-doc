.. _how-to-issue-a-single-sql-execute:

==================================
How to issue a single SQL execute 
==================================


``ex05.py``

::

	#print sqlexec( """INSERT INTO PMIS_USER (...) VALUES (...);""" )
	
	
	#How to execute a query for a result list, given static SQL.
	#print sql("""select user_no from pmis_user; """)
	
	# the id() function returns an integer representing its identity (currently implemented as its address)
	# How to use Beans object for accessing application components.
	# How to load an object from the ApplicationContext
	# method1
	print "############ method1"
	coreDao = Beans['coreDao']
	print coreDao.toString() + '  >>>> ' + str( id( coreDao ) )
	# method2
	print "############ method2"
	coreDao = Beans.coreDao
	print coreDao.toString() + '  >>>> ' + str( id( coreDao ) )
	
	
	# Information about Spring ApplicationContext
	print ApplicationContext.container.id
	print ApplicationContext.container.displayName
	print Date(ApplicationContext.container.startupDate)
	
	print type(ApplicationContext)
	print dir(ApplicationContext)
	
	# The type() function returns an object’s type (which is an object itself)
	print type(Beans.coreDao)
	print type(Beans.documentAction)