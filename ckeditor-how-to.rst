.. highlight:: javascript
.. _ckeditor-how-to:

===============
CKeditor How To
===============


Basic Creation Function
-----------------------------------


To create the editor you need a textarea element and an id attribute set as below:

.. code-block:: html

	<textarea name="editor1" id="editor1" style="display:none;" rows="" cols=""></textarea>

The full editor, with all the plugins active, can be initialized with the following code:

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
	
A much smaller version with just the essentials can be created with the following code
(this is useful for a simple rich text editor)::

	pmis.ckeditor.basic('salary-editor', {
		on: {
			instanceReady : function(ev) {
				// http://docs.ckeditor.com/#!/api/CKEDITOR.editor-event-instanceReady
				
				// load the content here
				ev.editor.setData('ciao mamma!');
	
				$(window).resize();
			}
		},
		width : '100%',
		height : 'auto',
		
		// if you need preview and print plugins
		extraPlugins: 'preview,print',
		
		// put the editor in readonly mode
		readOnly: true
	});

.. seealso::

	- http://docs.ckeditor.com/#!/api/CKEDITOR-method-replace
	- http://docs.ckeditor.com/#!/api/CKEDITOR.config-cfg-on
	- http://docs.ckeditor.com/#!/api/CKEDITOR.editor-event-instanceReady
	- http://docs.ckeditor.com/#!/api/CKEDITOR.editor-event-dataReady
	- http://docs.ckeditor.com/#!/api/CKEDITOR-event-currentInstance



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
	
Then you can get the editor element with::

	CKEDITOR.instances['editor1']



Editor Document DOM Element
---------------------------------------------

::
	
	CKEDITOR.instances['edtior-id-here'].document.$;
	

Get the content of the editor
---------------------------------------------

::

	CKEDITOR.instances['edtior-id-here'].getData()


Set the content of the editor
---------------------------------------------

::

	CKEDITOR.instances['edtior-id-here'].setData( data, {
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

	CKEDITOR.instances['edtior-id-here'].print()


Download the content
---------------------------------------------

::

	CKEDITOR.download(editor, filename)

	//or

	CKEDITOR.instances['edtior-id-here'].download(filename)


Get the full HTML content
---------------------------------------------

::

	CKEDITOR.getFullHTMLContent(editor)

	//or

	CKEDITOR.instances['edtior-id-here'].getFullHTMLContent()


Toggle the editor READONLY mode
---------------------------------------------

::

	CKEDITOR.instances['edtior-id-here'].setReadOnly( false|true );


Resize the editor
-----------------------

.. seealso:: http://docs.ckeditor.com/#!/api/CKEDITOR.editor-method-resize

::

	CKEDITOR.instances['edtior-id-here'].resize( width, height )


Destroy all editor instances at once
---------------------------------------------

::

	for(name in CKEDITOR.instances){
		CKEDITOR.instances['edtior-id-here'].destroy(true);
	}


Update textarea Element
------------------------------------

updateElement()
	Updates the <textarea> element that was replaced by the editor with the current data available in the editor.

::

	CKEDITOR.instances['edtior-id-here'].updateElement();