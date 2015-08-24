.. _delete-edms-file-with-doc_cd:

=============================
Delete EDMS file with doc_cd 
=============================


``ex12.py``

::

	# ==== DANGEROUS SCRIPT ====
	
	from java.util import *
	from java.lang import *
	from java.io import File
	from pmis.common.util import *
	
	#login = SessionUtil.getSession()
	#print login.user_no
	
	coreDao = ApplicationContext.get('coreDao')
	print coreDao
	print '-----------------------------'
	param = HashMap()
	
	param.put('pjt_cd', 'STND_PMIS')
	param.put('doc_cd', '505')
	
	list = coreDao.getList('doc.transfer.getFileList', param)
	print '-----------USER INFO-----------'
	print PmisConfig.get("edms.PathRoot")
	for file in list:
	    coreDao.delete("common.file.deleteRevid", file)
	    coreDao.delete("common.file.deleteEdms", file)
	    
	    filepath = PmisConfig.get("edms.PathRoot") + str(file["FILEPATH"]);
	    print filepath
	    f = File( filepath )
	    if f.exists():
	    	f.delete()