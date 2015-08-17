.. _attributes-and-custom-properties-in-html:

========================================
Attributes and custom properties in HTML
========================================




reference::

.. seealso::
    http://javascript.info/tutorial/attributes-and-custom-properties
    http://api.jquery.com/prop/
    http://api.jquery.com/attr/

In contrast with properties, attributes:

- May be only strings.
- Names not case-sensitive, because HTML attributes are not case-sensitive
- They show up in innerHTML (unless it’s older IE)
- You can list all attributes using an array-like attributes property of the element.


.. note:: 
    Setting an attribute can synch the corresponded property automatically
    
.. note:: 
    Setting a property doesn't synch the corresponded attribute!


example::

    <input type="text" value="markup">
    
    input.setAttribute('value', 'new')    
    input.getAttribute('value') 
    // output: 'markup' 
    // return the original value!

Please read the reference!


