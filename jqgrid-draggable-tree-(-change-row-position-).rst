.. _jqgrid-draggable-tree-(-change-row-position-):

=============================================
jqGrid Draggable Tree ( change row position )
=============================================




.. note:: [NOTE This plugin is only usable for tree list, for normal list use 'sortableRows' method]

Method:

.. js:function:: draggableTree()

Event:

.. js:function:: onDroppedRow( id )

.. code-block:: javascript
    
    $("#obsList").jqGrid({
        ...
        onDroppedRow: function(id){
            /* save obs!!! */
            console.log("ID DROPPED: " + id);
        }
    }).jqGrid('draggableTree');
    

