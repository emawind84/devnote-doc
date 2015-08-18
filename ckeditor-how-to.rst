.. _ckeditor-how-to:

===============
CKeditor How To
===============


.. code-block:: html

    <textarea name="editor1" id="editor1" style="display:none;" rows="" cols=""></textarea>

.. code-block:: javascript

    // SET A VARIABLE TO KEEP THE EDITOR ELEMENT
    var editor;
    
    // READY FUNCTION
    $(function(){
    
        CKEDITOR.replace("editor1",{
        // http://docs.ckeditor.com/#!/api/CKEDITOR-method-replace
        
            on: {
            // http://docs.ckeditor.com/#!/api/CKEDITOR.config-cfg-on
            
                instanceReady: function(ev){
                // http://docs.ckeditor.com/#!/api/CKEDITOR.editor-event-instanceReady
                
                    editor = ev.editor;
                
                    // The editor is ready and the content should be set here
                    
                    $(window).resize();
                },
                
                dataReady: function(ev){
                // http://docs.ckeditor.com/#!/api/CKEDITOR.editor-event-dataReady
                }
            
            }
            ,height: 400
            
            /* START READONLY SETTINGS */
            ,readOnly: true
            ,removePlugins: 'showborders,imageattacher'
            ,toolbarGroups: ['mode', 'document', 'find', 'tools']
            /* END READONLY SETTINGS */
        });
        
        CKEDITOR.on( 'currentInstance', function() {
        // http://docs.ckeditor.com/#!/api/CKEDITOR-event-currentInstance     
        } );
    
    
    });
    
.. seealso::
    
    - http://docs.ckeditor.com/#!/api/CKEDITOR-method-replace
    - http://docs.ckeditor.com/#!/api/CKEDITOR.config-cfg-on
    - http://docs.ckeditor.com/#!/api/CKEDITOR.editor-event-instanceReady
    - http://docs.ckeditor.com/#!/api/CKEDITOR.editor-event-dataReady
    - http://docs.ckeditor.com/#!/api/CKEDITOR-event-currentInstance

.. highlight:: javascript

Basic Creation Function
-----------------------------------

This function create a simple editor, most of the features are disabled.

::

	pmis.ckeditor.basic("editor1", {
		on: {
			instanceReady: function(ev){
				editor = ev.editor;
			}
		},
		width: 600,
		height: 300
	});



Editor Document DOM Element
---------------------------------------------

::

    editor.document.$;

Get the content of the editor
---------------------------------------------

::

    editor.getData()


Set the content of the editor
---------------------------------------------

::

    editor.setData( data, {
        callback: function(){
            /* after set content */
        },
        noSnapshot: true
    });


Print the content
---------------------------------------------

::

    CKEDITOR.print(editor)
    
    //or
    
    editor.print()


Download the content
---------------------------------------------

::

    CKEDITOR.download(editor, filename)
    
    //or
    
    editor.download(filename)


Get the full HTML content
---------------------------------------------

::
    
    CKEDITOR.getFullHTMLContent(editor)
    
    //or
    
    editor.getFullHTMLContent()


Toggle the editor READONLY mode
---------------------------------------------

::

    editor.setReadOnly( false|true );


Resize the editor
-----------------------

.. seealso:: http://docs.ckeditor.com/#!/api/CKEDITOR.editor-method-resize

::

    editor.resize( width, height )


Destroy all editor instances at once
---------------------------------------------

::
    
    for(name in CKEDITOR.instances){
        CKEDITOR.instances[name].destroy(true);
    }
