.. _load-menu-detail:

=================
Load menu detail 
=================


``ex09.py``

::

	
	from java.util import *
	from java.lang import *
	from pmis.common.util import *
	
	coreDao = ApplicationContext.get('coreDao')
	print coreDao
	print '-----------------------------'
	param = HashMap()
	
	param.put('pjt_cd', 'STND_PMIS')
	param.put('user_no', 'masterpmis')
	param.put('menu_cd', 'DOC0000')
	
	menu = coreDao.getView('sangah.main.sql.getUserLeftMenuDetail', param)
	
	for info in menu:
	    val = menu.get(info)
	    if val is not None:
	    	print (info + " > " + val).encode('utf-8')