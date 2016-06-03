=======================================
Secure Access Token to PMIS Web Service
=======================================


1. Request the Token
----------------------

URL: ``http://[DOMAIN HERE]/Main/Token.action``

Method: ``POST/GET``

Request Parameters:

cmd
	Must contain the string ``sso``

grant_type
	Must contain the string ``authorization_code`` grant type.

expires_in
	How long the token should be valid in seconds (default to 5 minutes)


Sample Request Body::

	cmd=sso&grant_type=authorization_code&expires_in=3600
	

To receive authorization, the client sends the userid and password,
separated by a single colon (``:``) character, within a **base64**
encoded string in the credentials.

**The request must be sent using the following header field**:

::

	Authorization: Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==

..note ``QWxhZGRpbjpvcGVuIHNlc2FtZQ==`` -> ``userid:password`` encoded in **base64**


The response will be a json like the sample below:

::

	{
		"access_token":"ZGlzY28xMjM0OltCQDFiNDVkODE=",
		"token_type":"",
		"expires":2464947465312
	}


2. Access Secured Pages or Services
-------------------------------------

After received the token is possible to access a page or service with two methods:

1. Sending the request with the following header field:

::

	Authorization: Token ZGlzY28xMjM0OltCQDFiNDVkODE=
	
2. Sending the following parameter with the request:

access_token
	The Access Token received before.
	
	
If the token is not valid or expired you will receive the error code 401::

	HTTP Status 401 - Authentication Failed: Token not valid.