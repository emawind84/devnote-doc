.. _generate-pdf-for-a-given-document:

==================================
Generate pdf for a given document 
==================================



.. note::

    .. include:: ../python-example-header.txt

    
filename => ``ex11.py``

::

	# ============ DEPRECATED ============ 
	
	
	
	list = sql('''
	select doc_id, file_seq, doc_seq, owner_id, PJT_CD from document where doc_id = 'CSCEC-LETTER-2014-0080';
	''')
	
	for doc in list:
	    print doc
	    revid = sql('select revid as revid from comm_attch_file where file_seq =' + str(doc['FILE_SEQ']) +' and format_div=11 order by reg_date desc;')
	    print revid[0]['REVID']
	    
	    param = HashMap()
	    
	    param.put('revid', revid[0]['REVID'] )
	    
	    param.put('owner_id', doc['OWNER_ID'] )
	    param.put('file_seq', str(doc['FILE_SEQ']))
	    param.put('doc_id', doc['DOC_ID'])
	    param.put('pjt_cd', doc['PJT_CD'])
	    
	    serv = Beans.documentService
	    print param
	    serv.generatePdf( param )