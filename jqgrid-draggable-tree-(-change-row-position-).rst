.. _jqgrid-draggable-tree-(-change-row-position-):

=============================================
jqGrid Draggable Tree ( change row position )
=============================================




[NOTE This plugin is only usable for tree list, for normal list use 'sortableRows' method]

Method:
    draggableTree()

Event:
    onDroppedRow( id )

$("#obsList").jqGrid({
    ...
    onDroppedRow: function(id){
        /* save obs!!! */
        console.log("ID DROPPED: " + id);
    }
}).jqGrid('draggableTree');


