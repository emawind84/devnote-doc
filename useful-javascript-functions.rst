.. _useful-javascript-functions:

Useful javascript functions
===========================


Query URL Generator
-----------------------------------------------------------------------

.. code-block:: javascript

    pmis.url( url, parameters )
    pmis.action( action, parameters )

Top Message Box
-----------------------------------------------------------------------

.. code-block:: javascript
    
    pmis.successMessage( text )
    pmis.infoMessage( text )
    pmis.errorMessage( text )
    pmis.warningMessage( text )

Event Trigger
-----------------------------------------------------------------------

.. code-block:: javascript

    pmis.trigger( event, data )

jQuery Dialog
-----------------------------------------------------------------------

.. code-block:: javascript
    
    pmis.openDialog( parameters )
    pmis.closeDialog( selector )

selector example: '#dialogid'

parameters::
    
    id,
    url,
    param,
    content,
    width,
    height,
    title
    
.. seealso:: //for more parameters @see http://api.jqueryui.com/dialog/


Other functions
-----------------------------------------------------------------------

.. code-block:: javascript

    pmis.wait( parameters )
    
Loop a function until a condition is verified or until timeout.

parameters::

    delay // default 500ms
    timeout // default -1
    condition // default false
    onWait
    onTimeout
    onExecute
    onCancel

Example:
    
.. code-block:: javascript

    var params = {
        delay: 1000,
        timeout: 10000,
        onWait: function(){ console.log('ciao', this._elapsed); },
        onTimeout: function(){ console.log('CIAO!!!'); },
        onCancel: function(){ console.log('WHY???'); }
    };
    wait( params );

    //params.cancelled = true;
    
.. code-block:: javascript

    pmis.escapeSelector( selector )
    
Escapes special characters and returns a valid jQuery selector

Example:

.. code-block:: javascript

    afterInsertRow: function(rowid, rowdata, rowelem){
        $('tr#' + pmis.escapeSelector(rowid) + ' td', this).css("font-weight", "700");
    }


-----------------------------------------------------------------------

More example:

.. code-block:: javascript

    pmis.url("/FileDownServlet", {
        "filename": fgDoc.TextMatrix(fgDoc.Row,2),
        "filePath": fm.cybox_path.value +"\\"+fgDoc.TextMatrix(fgDoc.Row,0)
    });
    
    pmis.url("/ml/grp/app/AppPop.jsp", params);
    
    pmis.action("/Core/CoreList", params) // no need of '.action'
    
    The parameters value can be a FORM element, JSON object or ARRAY object.
    
    <input name="fileName" value="..." />
    pmis.action("/Core/CoreList", document.forms[0]);
    
    pmis.action("/Core/CoreList", { "fileName": "name" });
    
    pmis.action("/Core/CoreList", [ name: "fileName", value: "name" ]);