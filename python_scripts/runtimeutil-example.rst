.. _runtimeutil-example:

====================
RuntimeUtil Example 
====================



.. note::

    .. include:: ../python-example-header.txt

    
filename => ``ex33.py``

::

	
	import jarray
	from java.io import *
	from pmis.common.util import RuntimeUtil
	
	eos = ByteArrayOutputStream()
	os = ByteArrayOutputStream()
	    
	envps = jarray.array(['net','use', 'Z:', '\\DISCO-HP\netdrive'], String )
	RuntimeUtil.getExecuteCommand(envps, eos, os)
	
	print eos.toString()
	print os.toString()