.. _java-totalfreeused-memory:

============================
Java Total/Free/Used Memory 
============================



.. note::

    .. include:: ../python-example-header.txt

    
filename => ``ex19.py``

::

	
	from java.lang import Runtime
	
	rt = Runtime.getRuntime();
	rt.gc();
	
	total = rt.totalMemory()
	free = rt.freeMemory()
	used = total - free;
	    
	print String.format("Total memory: %s", total )
	print String.format("Free memory: %s", free )
	print String.format("Used memory: %s", used )