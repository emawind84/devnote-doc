.. _load-webpage-with-url:

======================
Load webpage with URL 
======================



.. note::

    .. include:: ../python-example-header.txt

    
filename => ``ex24.py``

::

	
	from java.net import URL
	from javax.xml.parsers import *
	from java.io import *
	from org.w3c.dom import Document
	
	url = URL("http://localhost:8003/Core/Document/viewPrint.action?doc_seq=134451&owner_id=kspmisadmin&forward=/pmis/STND_PMIS/doc2/DocPrint.jsp")
	spoof = url.openConnection()
	spoof.setRequestProperty("User-Agent", "Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 5.0;    H010818)")
	br = BufferedReader(InputStreamReader(url.openStream()))
	strLine = ""
	finalHTML = ""
	
	strLine = br.readLine()
	while strLine is not None:
	    finalHTML += strLine
	    strLine = br.readLine()
	
	print finalHTML.encode("UTF-8")