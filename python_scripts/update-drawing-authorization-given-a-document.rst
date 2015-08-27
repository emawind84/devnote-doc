.. _update-drawing-authorization-given-a-document:

==============================================
Update drawing authorization given a document 
==============================================



.. note::

    .. include:: ../python-example-header.txt

    
filename => ``ex39.py``

::

	
	coreDao = Beans.coreDao
	docService = Beans.documentService
	registerService = Beans.registerService
	
	docs = sql('''
	select * from document where doc_seq = 151627;
	''')
	
	for doc in docs:
	    print doc
	    doc = docService.loadDocument(doc['DOC_SEQ'], doc['OWNER_ID'])
	    params = HashMap()
	    params.put("document_seq", doc['DOC_SEQ'] )
	    trndocs = coreDao.getList("core.sql.transmittalDocList", params);		
	    for reg in trndocs:
			registerService.addUserAuth( reg.get("hist_seq"), doc.get("owner_id") )
			#registerService.addEntprsAuth( reg.get("hist_seq"), doc.get("owner_entprs_cd") )	
	        
	print('Script complete')