.. _json-tags:

=========
JSON TAGS
=========




tags:
    
#. <j:obj></j:obj>  
        output: {}
#. <j:obj name="test" ></j:obj>
        output: "test": {}
#. <j:text name="test" value="testValue" /> 
        output: "test": "String value from ValueStack"
#. <j:number name="test" value="testValue"> 
        output: "test": "Number value from ValueStack"
#. <j:write value="testValue" />  
        output: "valuefromvaluestack"
#. <j:array value="list" >
        output: []
#. <j:array name="listName" value="list" >          
        output: "listName": []        
#. <j:var>"test"</j:var>
        output: var name = "test" ;

example:
--------

.. code-block:: html
    
    <%@taglib prefix="j" tagdir="/WEB-INF/tags/json"%>
    
    <j:obj>
        <j:obj name="error">
            <j:text name="type" value="exception.class.name"/>
            <j:text name="message" value="exception.message"/>
            <j:array name="stackTrace" value="exception.stackTrace">
                <j:text name="className" value="className"/>
                <j:text name="method" value="methodName"/>
                <j:text name="line" value="lineNumber"/>
            </j:array>
        </j:obj>
    </j:obj>

output:
^^^^^^^^

.. code-block:: json
    
    {
        "error": {
            "type": "...",
            "message": "...",
            "stackTrace": [
                { 
                    "className": "...", 
                    "method": "...", 
                    "line": "..." 
                }, 
                { ... }
            ]
        }
    }


example:
--------

.. code-block:: html
    
    <j:var name="data">
    <j:obj>
        <j:text value="fileId"/>        
        <j:text value="fileName"/>    
        <j:text name="fileSizeName" value="fileSize"/>    
        <j:text value="contentType"/>    
    </j:obj>
    </j:var>

output:
^^^^^^^^

.. code-block:: javascript
    
    var data = {
        "fileId" : "...",
        "fileName": "...",
        "fileSizeName": "...",
        "contentType": "..."
    }



.. note:: [IMPORTANT!]

    | If request.setAttribute is used, is required the use of '#request.' to retrieve the object in the request.
    | If the object to retrieve is a property of an action it can be referenced by name without any other alias.
    | If the object to retrieve is put in the ValueStack it can be referenced by name without any other alias.

------------------

Action:


::

    ...
    request.setAttribute("list", list);
    ActionContext.getContext().getValueStack().set("list2", list2);

------------------

JSP:

::

    ...
    <j:array name="listName" value="#request.list">
    <j:array name="listName" value="list2">


.. note:: [NOTE] if this exception is thrown: java.lang.ClassCastException: java.lang.Long cannot be cast to java.lang.String change [<j:text ...] to [<j:number ...]


reference:
 
- https://commons.apache.org/proper/commons-ognl/language-guide.html [recommended]
- http://www.tutorialspoint.com/struts_2/struts_value_stack_ognl.htm [recommended]
- https://struts.apache.org/release/2.2.x/docs/ognl-basics.html [recommended]
