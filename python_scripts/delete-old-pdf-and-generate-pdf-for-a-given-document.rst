.. _delete-old-pdf-and-generate-pdf-for-a-given-document:

=====================================================
Delete old pdf and generate pdf for a given document 
=====================================================


``ex32.py``

::

	
	from java.io import File
	    
	docid = 'DISCOTEST_NO11111'
	doforreal = False
	serv = Beans.documentService
	coreDao = ApplicationContext.get('coreDao')
	
	list = sql('''
	select doc_id, file_seq, doc_seq, owner_id, PJT_CD from document where doc_id = ?;
	''', docid)
	
	if list.size() == 0:
	    print 'Nothing found!'
	    
	for doc in list:
	    print doc
	    revid = sql('select revid as revid from comm_attch_file where file_seq =' + str(doc['FILE_SEQ']) +' and format_div=11 order by reg_date desc;')
	    #print revid[0]['REVID']
	    
	    param = HashMap()
	    param.put('file_seq', str(doc['FILE_SEQ']))
	    
	    list = coreDao.getList('core.sql.commAttchFileDetail', param)
	    for file in list:
	        print u''.join( file["title"] ).encode('utf-8')
	        if file["title"].find('.pdf') != -1 and file["title"][:-4] == doc["doc_id"]:
	            
	            print 'Deleting ' + u''.join( file["title"] ).encode('utf-8')
	            if doforreal:
	                coreDao.delete("common.file.deleteRevid", file)
	                coreDao.delete("common.file.deleteEdms", file)
	                
	                filepath = PmisConfig.get("edms.PathRoot") + str(file["FILEPATH"]);
	                print filepath
	                f = File( filepath )
	                if f.exists():
	                    f.delete()
	                    
	    print 'Generating pdf...'
	    if doforreal:
	        serv.generatePdf( doc['DOC_ID'], str(revid[0]['REVID']), str(doc['FILE_SEQ']) )