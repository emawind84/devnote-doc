.. _messagedigest:

==============
MessageDigest 
==============


``ex20.py``

::

	
	from javax.crypto import KeyGenerator
	from java.security import MessageDigest
	from javax.crypto.spec import SecretKeySpec
	from org.apache.commons.codec.binary import Base64
	
	# FIRST TEST
	gen = KeyGenerator.getInstance('AES')
	key = gen.generateKey()
	print key.getEncoded()
	print Base64.encodeBase64String( key.getEncoded() )
	
	
	
	# SECOND TEST
	digest = MessageDigest.getInstance("SHA")
	digest.update( String("1").getBytes("UTF-8"))
	key = SecretKeySpec(digest.digest(), 0, 16, "AES")
	print key.getEncoded()
	print Base64.encodeBase64String( key.getEncoded() )
