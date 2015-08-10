.. _baseaction:

==========
BaseAction
==========




BaseAction is a support class to use in place of ActionSupport

Methods:

// sets a java object directly in the ValueStack, on jsp is possible to get the object as usual.
// note: is not the same as request.setAttribute(key, value)!!!
void setValueStackParam( String key, Object value )

// return a parameter directly from the parameters map as String, if not present return defaultValue
String parameter( String name, String defaultValue )



Objects ready to use:

HttpServletRequest request
String forward
