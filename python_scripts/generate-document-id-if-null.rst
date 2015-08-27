.. _generate-document-id-if-null:

=============================
Generate document ID if null 
=============================



.. note::

    .. include:: ../python-example-header.txt

    
filename => ``ex29.py``

::

	
	from pmis.common.util import CustomHashMap
	list = sql('''
	select * from document where  pjt_cd = 'GLB_PMIS' and doc_status = 'IDLE' and doc_id is null;
	''')
	
	docServ = Beans.documentService
	
	for _d in list:
	    
	    dparam = CustomHashMap();
	    dparam.putAll(_d)
	    
	    d = docServ.loadDocument( dparam.get('DOC_SEQ'), dparam.get('OWNER_ID') )
	    
	    if d.get('doc_id_prefix') == None:
	        d.put( 'doc_id', docServ.getNextDocId( d ) )
	    else:
	        d.put( 'doc_id', docServ.getNextDocId( d.get('doc_id_prefix') ) )
	        
	    docServ.updateDocument(d.get('doc_seq'), d.get('owner_id'), d)
	    
	print 'Script terminated!'