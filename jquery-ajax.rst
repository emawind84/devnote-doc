.. _jquery-ajax:

===========
JQUERY Ajax
===========

.. code-block:: javascript

    $.ajax({
        url: <ACTION>,
        data: <DATA>,
        [type: "GET"|"POST",]
        [dataType: "json"|"html"|"xml",]
        [cache: false,]
        [errorMessage: "error!",]
        [async: false,]
        [preventErrorPopup: false,]
        [asyncAlertOff: false,]
    }).done(function(data){
        //...
    }).fail(function(jqXHR, textStatus){
        //...
    }).always(function(){
            //...
    });


[]: optional

<ACTION>

::

    "/Namespace/ActionName.action"
    pmis.action("/Namespace/ActionName.action", { "param1": "value1", "param2": "value2" } )


<DATA>:

::

    <1 METHOD>
    "param1=value1&param2=value2"
    
    <2 METHOD>    
    $(document.forms[0]).serializeArray()
        
    <3 METHOD>
    { "param1": "value1", "param2": "value2" }
    
    <4 METHOD>
    var param = [
        { name: "param1", value: "value1" },
        { name: "param2", value: "value2" }
    ];
    param.push( { name: "param3", value: "value3"  });
    param.push( { name: "param3", value: "value4"  });            
    

['dataType' is required if you expect a json data and the page has a different contentType like "text/html". Not strictly required if contentType is "text/json" but recommended!]
    
['errorMessage' attribute is used in case the called method throw an exception; an alert message will show the message. 
If errorMessage is not used, in case of exception, an alert message will show the original exception's message thown from the called method.
Please note that the alert message will be shown only with 'json' or 'undefined' dataType, otherwise default error.jsp page will be shown.]

['cache' attribute should be used together with GET requests. Only work with GET requests!. It will force requested pages not to be cached by the browser]

['async' attribute is used if you need synchronous requests, in this case set this option to false]


[Deferred example]

::

    function init() {
        ...
        sub_init().done(function(data){
            ... 
            //do something after ajax call!
        });
    }
    
    function sub_init(){
        var deferred = $.Deferred(); // empty deferred
        var deferred = $.ajax({...}); // non empty deferred
        // ajax operation ended
            deferred.resolve();
        return deferred.promise();
    }

reference: http://api.jquery.com/jQuery.ajax/
