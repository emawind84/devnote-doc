.. _daum-editor-functions-and-events:

================================
Daum Editor Functions and Events
================================

Reference:

#. //@see canvas.js
#. //@see resizer.js
#. //@see observables.js
#. //@see saver.jsp
#. //@see docparser.js

list trex events available
---------------------------

Trex.Ev

how to attach a function to an event
------------------------------------

.. code-block:: javascript
    
    canvas.observeJob( Trex.Ev.__CANVAS_HEIGHT_CHANGE, function(){ alert('Hello!') } );
    
    Editor.canvas
    
    // actual editor mode ( html, text, source )
    Editor.canvas.mode
    
    // change editor mode
    Editor.canvas.changeMode('html')
    
    // get encoded content
    Editor.getContent()
    
    // get not encoded content
    Editor.canvas.getContent()
    
    
    // list all the functions attached to the Trex events.
    Editor.canvas.jobObservers
    
    // parser for set content to the editor
    Editor.getDocParser().convertAtLoad(contents, editorMode, inputMode);
    
    // parser for get content from editor
    Editor.getDocParser().convertAtSave( content, editorMode, outputMode )


.. code-block:: javascript
    
    Editor.getContent()
        will call -> Editor.getSaver().getContent()
            will parse  -> Editor.canvas.getContent()
            using -> Editor.getDocParser().convertAtSave( content, editorMode, outputMode )
            
    // to get RAW content Editor.canvas.getContent() have to be used
    
    
    Editor.modify = function(data) {
        if (Editor.__PANEL_LOADED && Editor.__EDITOR_LOADED) {
            if (this.loadEditor) {
                this.loadEditor(data);
            }
        } else {
            setTimeout(this.modify.bind(this, data), 10);
        }
    };