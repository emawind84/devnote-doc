.. _daum-editor:

===========
DAUM Editor
===========




Folder: /web/ext/daumeditor

Example pages: 
/ml/sample/daumeditor/main.jsp
/ml/doc2/DocEdit.jsp, /ml/doc2/DocView.jsp, ...

load content
----------------------------------------------------

Editor initialization:
^^^^^^^^^^^^^^^^^^^^^^

.. code-block:: javascript

    Editor.init({
        form: "formId", // required form id ( default: "form" )
        canvas: { 
            readonly: true // readonly view
        }
    });

Set content editor:
^^^^^^^^^^^^^^^^^^^

.. code-block:: javascript

    //NO AJAX CALL:

    Editor.modify({
        "content": "test"
    });
    ...
            
    //AJAX CALL:

    $.ajax({
        url: "/Common/FileView.action",
        data: {
            "fileForm.revid": "${view.revid}"
        },
        type: "POST",
        dataType: "html"
    }).done( function(data){
        Editor.modify({
            "content": data
        });
    });


.. code-block:: html

    <div class="editor-container">
    <%@ include file="/ext/daumeditor/editor.jsp"%>
    </div>

save content
----------------------------------------------------

.. code-block:: javascript

    $.ajax({
        url: ...,
        data: {
            "content" : Editor.getContent(),
            ...
        },
        ...
    });

Custom available functions:
----------------------------------------------------

#. Editor.init();
    required to inizialize the editor    
#. Editor.readonly(param);
    put the editor in readonly mode
    parameter: true|false
#. Editor.resize(height);
    resize the editor
#. Editor.onReady().done(function(){//do something});
    using this function ensures the editor is ready
#. Editor.getDocument();
    return the Document object of the editor ( https://developer.mozilla.org/en-US/docs/Web/API/Document ) 
#. Editor.download(filename); 
    will save the content of the editor in a temporary file
    parameter filename // default value: template.html
#. Editor.print() 
    will print the content of the editor
    
