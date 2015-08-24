.. _add-recipient-to-document:

==========================
Add recipient to document 
==========================


``ex30.py``

::

	
	docServ = Beans.documentService
	
	doc = docServ.loadDocument('135401', 'encA13689')
	
	print doc
	
	docServ.addRecipient(doc, '11170480', 'TO')
	
	print 'Script terminated!'