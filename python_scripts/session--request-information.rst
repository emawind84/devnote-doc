.. _session--request-information:

==============================
Session & request information 
==============================



.. note::

    .. include:: ../python-example-header.txt

    
filename => ``ex04.py``

::

	
	from org.springframework.security.context import SecurityContextHolder
	from org.springframework.web.context.request import RequestContextHolder
	sessionReg = ApplicationContext.get('sessionRegistry')
	
	#list methods available
	#print dir(sessionReg)
	
	# ALL SESSION CONNECTED TO THE SERVER
	principals = sessionReg.allPrincipals
	for principal in principals:
	    for session in sessionReg.getAllSessions( principal, True ):
	        print session.principal + ' - ' + session.sessionId
	        #session.expireNow()
	
	
	#PERSONAL SESSION INFO
	#print SecurityContextHolder.getContext()
	
	#get ServletRequestAttributes
	requestAttribute = RequestContextHolder.currentRequestAttributes()
	
	#get Session/Request/ecc...
	request = requestAttribute.request
	session = request.session
	#print requestAttribute.sessionId
	securityContext = session.getAttribute('SPRING_SECURITY_CONTEXT')
	
	print securityContext.authentication