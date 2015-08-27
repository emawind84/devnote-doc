.. _coredao-with-map:

=================
CoreDao with Map 
=================



.. note::

    .. include:: ../python-example-header.txt

    
filename => ``ex01.py``

::

	
	from java.util import *
	from java.lang import *
	from pmis.common.util import *
	
	#login = SessionUtil.getSession()
	#print login.user_no
	
	coreDao = ApplicationContext.get('coreDao')
	print coreDao
	print '-----------------------------'
	param = HashMap()
	
	param.put('pjt_cd', 'STND_PMIS')
	param.put('user_no', 'masterpmis')
	
	user = coreDao.getView('sangah.system.sql.getUserSelect', param)
	print '-----------USER INFO-----------'
	for info in user:
	    val = user.get(info)
	    if val is not None : 
	        print (info + ' >> ' + val).encode('utf-8')