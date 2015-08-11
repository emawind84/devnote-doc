.. _jquery-dialog:

=============
JQUERY Dialog
=============




[NEW PMIS FUNCTIONS]

.. js:function:: pmis.openDialog()
.. js:function:: pmis.closeDialog()

.. seealso:: functionsml.js pmis object

Example:

.. code-block:: javascript

    //local content
    pmis.openDialog({
        content: "content test",
        title: "title test",
        id: "dialogId",
        width: 123,
        height: 123,
        maxHeight: 500
    });
    
    //server content
    pmis.openDialog({
        url : "/Progress/DesignEcoaItem.action",
        param : {
            "form.pjt_cd" : "<c:out value="${login.pjt_cd}"/>",
            "form.ecoa_cd" : "<c:out value="${form.ecoa_cd}"/>"
        },
        title: "title test",
        id: "dialogId",
        width: 123,
        height: 123,
        maxHeight: 500
    });

    // to close the dialog
    pmis.closeDialog('#dialogId');

.. note:: [IMPORTANT don't close the dialog with $('#dialogId').dialog("close"); ]

-------------------------------------------------------------------

.. code-block:: html
    
    <style>
    // to remove the close button on the top bar
    .no-close .ui-dialog-titlebar-close {
        display: none;
    }
    </style>
    
    <div id="modalDialog">
        <span>Document saved. Go to the document list?<br />Click [Yes] to continue or [No] to create another document.</span>
    </div>
    
.. code-block:: javascript
    
    function cmdOpenDialog(){
        $("#modalDialog").dialog("open");
    }
    
    $("#modalDialog").dialog({
        autoOpen: false,
        dialogClass: "no-close",
        closeOnEscape: false,
        modal: true,
        title: "PMIS Message",
        buttons: {
            "Yes": function(){
                // ... do something
                $(this).dialog( "close" );
            },
            "No": function(){
                // ... do something
                $(this).dialog( "close" );
            }
        }
    });    
    
.. seealso::
    reference: http://jqueryui.com/dialog/

