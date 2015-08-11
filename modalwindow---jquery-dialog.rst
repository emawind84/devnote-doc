.. _modalwindow---jquery-dialog:

============================
ModalWindow -> jQuery Dialog
============================




docView.jsp:
-------------------------------------------------------------------------------------------------------------

.. code-block:: html
    
    <body>
        ...
        <div style="display: none;" id="serviceDialog"><iframe style="height: 100%; width: 100%;"></iframe></div>
        ...

.. code-block:: javascript

    function cmdFindWorkObs(){
        $("#serviceDialog iframe").get(0).src = commonPopDialogUrl("/Core/CoreList.action", { ... });
        $("#serviceDialog").dialog( "option", { "height": 650, "width": 650 } );
        $("#serviceDialog").dialog("open");
        
    }
     
    topic.subscribe("fbs/selected", function(data){
        //data.doc_cd available!
        //data.doc_nm available!
        ... // do something with data!!!
    });

    $(function() {
        $("#serviceDialog").dialog({
            autoOpen: false,
            closeOnEscape: true,
            modal: true,
            resizable: false,
            appendTo: "#formId", // (form id) important!
            title: "Dialog Title"
        });
        
        topic.subscribe("dialog/close", function(){
            $("#serviceDialog").dialog("close");
        });
        
        ...
    
    
dialog jsp:
------------------------------------------------------------------

.. code-block:: javascript
    
    function cmdClose(){topic.publish('dialog/close');}
    
    function cmdSelect() {
        ...
        topic.publish("fbs/selected", {
            doc_cd: ret.doc_cd,
            doc_nm: ret.doc_clss_name
        })
        cmdClose();
    }

.. seealso:: commonPopDialogUrl in functionsml.js


