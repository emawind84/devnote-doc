=======================================
Token Authentication to PMIS
=======================================


1. Request the Token
----------------------

.. important:: 
	To request the token the user need to be already authenticated and able to access PMIS services.

What we want to achieve here is authenticate the user 
and request a token that can be used later to access our web services.

URL: ``http://dev.sangah.com/Main/Token.action``

Method: ``POST/GET``

Request Parameters:

expires_in (*optional*)
	How long the token should be valid in seconds (default to 5 minutes)


Sample Request Body::

	expires_in=3600


We have two methods to authenticate the user before requesting the token:

1. Together with the token request, we send the userid and password, 
   separated by a single colon (``:``) character, within a **base64**
   encoded string in the credentials.

 **The request must be sent using the following header field**:

 ::

	Authorization: Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==

 .. note:: ``userid:password`` => ``QWxhZGRpbjpvcGVuIHNlc2FtZQ==`` encoded in **base64**

2. Together with the token request we send the following parameters:

 user_no
 	The username

 passwd
 	The user password

 cmd (``=sso``)
 	This parameter tell to our server to use the **basic** authentication (username/password).
 	This parameter is *deprecated* (will be removed in future release in replace of **auth_type**), 
	but is still required for some projects.

 auth_type (``=basic``)
 	This parameter tell to our server to use the **basic** authentication (username/password).

 Sample Request Body::

	user_no=con001&passwd=pwd001&expires_in=3600


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