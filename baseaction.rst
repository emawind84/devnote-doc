.. _baseaction:

==========
BaseAction
==========




BaseAction is a support class to use in place of ActionSupport

Methods:

::
	
	void setValueStackParam( String key, Object value )
	
sets a java object directly in the ValueStack, on jsp is possible to get the object as usual.
	
.. note:: is not the same as request.setAttribute(key, value)!!!

::

	String parameter( String name, String defaultValue )

return a parameter directly from the parameters map as String, if not present return defaultValue

Objects ready to use:

::

	HttpServletRequest request
	String forward
