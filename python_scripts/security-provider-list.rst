.. _security-provider-list:

=======================
Security provider list 
=======================


``ex26.py``

::

	
	from java.security import Security
	
	pl =  Security.getProviders()
	
	for p in pl:
	    print p
	    
	    for s in p.getServices():
	        if s.type == 'Cipher':
	    		print '	' + s.getAlgorithm()
	        	#print '	'+s.type