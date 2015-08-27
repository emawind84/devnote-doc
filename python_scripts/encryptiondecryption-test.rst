.. _encryptiondecryption-test:

===========================
Encryption/decryption test 
===========================



.. note::

    .. include:: ../python-example-header.txt

    
filename => ``ex27.py``

::

	
	from java.security import *
	from javax.crypto import *
	from javax.crypto.spec import *
	from org.apache.commons.codec.binary import Base64
	from pmis.common.util import EncodeUtil
	
	strToEncode = 'stringToEncode'
	print 'String to encrypt: ' + strToEncode
	cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
	
	iv_i = "PD$32KYDUHEFVOAW"
	iv = String(iv_i).getBytes()
	ivPS = IvParameterSpec(iv)
	
	key = EncodeUtil.genKey('1234')
	cipher.init(Cipher.ENCRYPT_MODE, key, ivPS );
	encByte = cipher.doFinal( String(strToEncode).getBytes("UTF-8"));
	encStr = String( Base64.encodeBase64( encByte ) )
	print 'Encrypted string: ' + str(encStr)
	
	
	cipher.init(Cipher.DECRYPT_MODE, EncodeUtil.genKey('1234'), ivPS)
	encB = Base64.decodeBase64( encStr )
	decrypt = cipher.doFinal(encB)
	print 'Decrypted string: ' + str(String(decrypt))