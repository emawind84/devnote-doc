.. _encodeutil-key-generation:

==========================
EncodeUtil Key Generation 
==========================



.. note::

    .. include:: ../python-example-header.txt

    
filename => ``ex21.py``

::

	
	from javax.crypto import KeyGenerator
	from java.security import MessageDigest
	from javax.crypto.spec import SecretKeySpec
	from pmis.common.util import EncodeUtil
	
	from org.apache.commons.codec.binary import Base64
	
	print '#TEST1'
	gen = KeyGenerator.getInstance('AES')
	key = gen.generateKey()
	print key.getEncoded()
	print EncodeUtil.toHex( key.getEncoded() )
	
	print 'wrapping...'
	wrapped = EncodeUtil.wrapKey( '1234', key )
	print wrapped
	
	print 'unwrapping...'
	key = EncodeUtil.unwrapKey( '1234', wrapped )
	print key.getEncoded()
	print EncodeUtil.toHex( key.getEncoded() )
	
	print '\n#TEST2'
	print EncodeUtil.encrypt('ciao', '1234')
	print EncodeUtil.decrypt('{AES}CaMPjb3mGgCgxx6Hal5XUg==', '1234')