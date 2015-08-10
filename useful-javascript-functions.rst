.. _useful-javascript-functions:

===========================
Useful javascript functions
===========================


Query URL Generator
-----------------------------------------------------------------------
pmis.url( url, parameters )
pmis.action( action, parameters )

Top Message Box
-----------------------------------------------------------------------
pmis.successMessage( text )
pmis.infoMessage( text )
pmis.errorMessage( text )
pmis.warningMessage( text )

Event Trigger
-----------------------------------------------------------------------
pmis.trigger( event, data )

jQuery Dialog
-----------------------------------------------------------------------
pmis.openDialog( parameters )
pmis.closeDialog( selector )

selector example: '#dialogid'

parameters:
    id,
    url,
    param,
    content,
    width,
    height,
    title
    
//for more parameters @see http://api.jqueryui.com/dialog/
    

Other functions
-----------------------------------------------------------------------
pmis.wait( parameters )
Loop a function until a condition is verified or until timeout.

parameters:
    delay // default 500ms
    timeout // default -1
    condition // default false
    onWait
    onTimeout
    onExecute
    onCancel

    Example:
    
    var params = {
        delay: 1000,
        timeout: 10000,
        onWait: function(){ console.log('ciao', this._elapsed); },
        onTimeout: function(){ console.log('CIAO!!!'); },
        onCancel: function(){ console.log('WHY???'); }
    };
    wait( params );

    //params.cancelled = true;
    

pmis.escapeSelector( selector )
Escapes special characters and returns a valid jQuery selector

    Example:

    afterInsertRow: function(rowid, rowdata, rowelem){
        $('tr#' + pmis.escapeSelector(rowid) + ' td', this).css("font-weight", "700");
    }


-----------------------------------------------------------------------

More example:

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