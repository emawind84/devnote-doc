.. _messagedigest-test--sha-key:

=============================
MessageDigest Test & SHA Key 
=============================


``ex14.py``

::

	
	from java.security import MessageDigest
	from org.apache.commons.codec.binary import Base64
	
	digest = MessageDigest.getInstance("SHA-1")
	
	digest.update(String('1234').getBytes("UTF-8"))
	
	key = Base64.encodeBase64String( digest.digest() )
	
	print key