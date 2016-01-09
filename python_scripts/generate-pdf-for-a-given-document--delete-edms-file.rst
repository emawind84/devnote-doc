.. _generate-pdf-for-a-given-document--delete-edms-file:

=====================================================
Generate pdf for a given document & delete edms file 
=====================================================



.. note::

    .. include:: ../python-example-header.txt

    
filename => ``ex10.py``

::

	# ============ DEPRECATED ============ 
	
	
	
	from java.util import *
	from java.lang import *
	from pmis.common.util import *
	
	param = HashMap()
	
	param.put('revid', '1401299521412798')
	param.put('owner_id', 'intpass')
	param.put('file_seq', '298541')
	param.put('doc_id', 'PB-LETTER-2014-0016')
	param.put('pjt_cd', 'LCT2014')
	
	serv = Beans.documentService
	
	#serv.generatePdf( param )
	
	dao = Beans.coreDao
	
	param2 = HashMap()
	param2.put('revid', '1401299521457906')
	list = dao.getList('core.sql.commAttchFileDetail', param2 )
	
	#dao.delete("common.file.deleteRevid", list[0]);
	#dao.delete("common.file.deleteEdms", list[0]);