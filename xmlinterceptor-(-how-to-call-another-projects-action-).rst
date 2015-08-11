.. _xmlinterceptor-(-how-to-call-another-projects-action-):

=======================================================
XmlInterceptor ( How to call another project's action )
=======================================================


Web service call

Reference classes::
	
	pmis.common.struts.interceptor.xml.XmlInterceptor
	pmis.common.xml

Example: 

This action will try to request a service
http://localhost:8003/Test/Web/requestService.action

Is possible to execute the main class in WebServiceTestAction for testing purpose

.. note::

	In the same action you will find the method doServiceTest, this is the method that will provide the service.
	For testing purpose the service (provider's service) has been put in the same action of the requester 
	but is important to understand that the service will be called from another web application
	(requester and provider are in different web applications)

See the class test::

	test.webservice.WebServiceTestAction    
