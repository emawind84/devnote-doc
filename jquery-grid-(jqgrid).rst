.. _jquery-grid-(jqgrid):

====================
JQuery GRID (jqGrid)
====================


.. note:: 
    Take a look at document management inside the folder ``/pmis/STND_PMIS/doc2/`` to see some examples.

.. note:: Some links that might be useful
    
    - `Date format convention <http://php.net/manual/en/datetime.formats.date.php>`_
    - http://www.trirand.com/jqgridwiki/doku.php?id=wiki:jqgriddocs
    - http://www.trirand.com/jqgridwiki/doku.php?id=wiki:retrieving_data
    - http://www.trirand.com/jqgridwiki/doku.php?id=wiki:treegrid
    - http://www.trirand.com/jqgridwiki/doku.php?id=wiki:adjacency_model
    - http://www.trirand.com/jqgridwiki/doku.php?id=wiki:options
    - http://www.trirand.com/jqgridwiki/doku.php?id=wiki:events
    - http://www.trirand.com/jqgridwiki/doku.php?id=wiki:colmodel_options
    - http://www.trirand.com/jqgridwiki/doku.php?id=wiki:methods
    - http://www.trirand.com/jqgridwiki/doku.php?id=wiki:custom_formatter
    - http://www.trirand.com/jqgridwiki/doku.php?id=wiki:predefined_formatter

LOADING DATA PROCEDURE:
------------------------

DATA FROM JSP:
^^^^^^^^^^^^^^^^
    
.. code-block:: javascript

    var mydata = 
        <j:array value="list" >
            <j:text name="seq" value="seq" />
            <j:text name="doc_no" value="doc_no" />
            ...
        </j:array>;
    
    //Normal grid:
            
    $("#listId").jqGrid({
        datatype: "local",
        data: mydata,
        localReader: { id: "seq" }, // important
        colNames:['Inv No','Date', 'Amount','Tax','Total','Notes'],
        colModel: [ ... ]
        ...
            
    //Tree grid:
    
    $("#listId").jqGrid({
        datastr: mydata,
        datatype: "jsonstring",
        jsonReader : {
            root: function (obj) { return obj; },
            repeatitems: false,
            id: "seq", // important
            page: function (obj) { return 1; },
            total: function (obj) { return 1; },
            records: function (obj) { return obj.length; }
        },
        colNames:['Inv No','Date', 'Amount','Tax','Total','Notes'],
        colModel: [ ... ]
        ...


DATA FROM SERVER:
^^^^^^^^^^^^^^^^^^^
    
.. code-block:: javascript

    $("#obsList").jqGrid({
        url: [URL],
        postData: {
            ...
        },
        mtype: "POST",
        treedatatype: "local",
        datatype: "json",
        jsonReader : {
            repeatitems: false,
            root: "obs_data", // the root element name
            id: "seq" // important list id
        },
        // ### tree parameters ###
        treeGrid: true,
        treeGridModel: "adjacency",
        tree_root_level: 1,
        treeReader : {
            level_field: "lvl",
            parent_id_field: "up_obs_cd",
            leaf_field: "leaf",
            expanded_field: "expanded"
        }
        // ### end tree parameters ###

ADD ROW:
----------

.. code-block:: javascript

    // add row
    $("#list").jqGrid('addRowData', $.jgrid.randId(), { "flag": "I", ... }, "first" );
	
.. note:: [NOTE $.jgrid.randId() // jqgrid function that will generate a key!]


EDIT ROW (INLINE MODE):
------------------------

Add these options to the grid:

.. code-block:: javascript

    ...
    editurl: "clientArray",
    onSelectRow: function(id){
    	$(this).jqGrid('restoreRow', $(this).data("lastsel") );
    	$("#list").jqGrid('editRow',id,true, oneditfunc, null, null, null, aftersavefunc);
    	$(this).data("lastsel", id);
    	...
    ...
		
.. note::
    | ``oneditfunc`` is a function called before the column is editable.
    | ``aftersavefunc`` is a function called after the column is saved.

EDIT ROW (CELL MODE):
----------------------

Add these parameters to the grid:

::

    cellEdit : true
    cellsubmit: 'clientArray'

    
REMOVE ROW:
------------

Multiselect:
^^^^^^^^^^^^^

.. code-block:: javascript

    var ids = $("#list").jqGrid('getGridParam','selarrrow');
    for(var i= ids.length-1; i>=0; i--){
        var ret = $("#list").jqGrid('getLocalRow', ids[i]);
        ...
        $("#list").jqGrid('delRowData', ids[i]);
    }
    
Select:
^^^^^^^^^^

.. code-block:: javascript

    var id = $("#list").jqGrid('getGridParam','selrow');
    var ret = $("#list").jqGrid('getLocalRow', id);
    ...
    $("#list").jqGrid('delRowData', id);


ON SAVE ROW (INLINE/CELL MODE):
---------------------------------

.. code-block:: javascript

    var irow = $("#distList")[0].p.savedRow[0].id; // current editing row
    var icol = $("#distList")[0].p.savedRow[0].ic; // current editing col
    
    //Single cell save in case was used the cell edit mode ( cellEdit : true ):
    $("#distList").jqGrid("saveCell", irow, icol );    
    
    //Row save in case was used the row edit mode:
    $("#list").jqGrid("saveRow", id, false); // if edit mode is active, the function will save data to the grid and will close the edit mode.
    
    var ids = $("#list").jqGrid('getDataIDs');
    for(var i=ids.length-1; i>=0; i--){
        var ret = $("#list").jqGrid('getLocalRow', ids[i]);
        ...
    }


FORMATTER EXAMPLE:
------------------

.. code-block:: javascript

    colModel:[
        {name:'action_ro', ... , formatter: dataFormatter, unformat: dataUnformat },
        {name:'action_ro', ... , formatter: 'integer' },                                // 천원 단위 콤마 
        ...
    ],
    formatter : {
        integer : {thousandsSeparator: ",", defaultValue: '0'}
       },
    
    function dataFormatter(cellvalue, options, cellobject)
    {
        return format(cellvalue);
    }
    
    function dataUnformat(cellvalue, options, rowObject)
    {
        return unformat(cellvalue);
    }


HIERARCHY SELECTION FOR TREE GRID:
----------------------------------

.. code-block:: javascript

    function _cmdAdd(selectedRowId){
        var ret = $("#list").jqGrid('getLocalRow', selectedRowId);
        var childs = $("#obsList").jqGrid('getNodeChildren', ret);
        if( childs.length == 0 ) {
            // child element selected
            return selectedRowId;
        } else {
            $.each( childs, function(index, data){
                _cmdAdd(data["_id_"])
            });
            return selectedRowId;
        }
    }


Change grid's width dynamically with ``shrinkToFit``

.. code-block:: javascript
  
    var myGrid = $("#docList"),
    width = myGrid.jqGrid('getGridParam', 'width'); // get current width
    myGrid.jqGrid('setGridWidth', width, true);
    
.. note:: [NOTE true is for activate shrinkToFit]
    
    
Editable Date:

.. code-block:: javascript

    afterEditCell: function (id,name,val,iRow,iCol){
        $("#"+iRow+"_step1", this).datepicker({showOn: "focus"});
    },
    



How to change style on row and single column:

.. code-block:: javascript

    ...
    afterInsertRow: function(rowid, rowdata, rowelem){
        // set class on td element
        example1: $( "td", "#" + rowid ).addClass('not-editable-cell');
        
        // set css or classes on td element by column name
        example2: $(this).jqGrid('setCell', rowid, "step1", '', { color: "red" });
        example3: $(this).jqGrid('setCell', rowid, "step1", '', "classname anotherclassname");
        
        // set css or classes along the entire row
        example4: $(this).jqGrid('setRowData', rowid, false, { "border-bottom": "3px solid #CCCCCC" });
        example5: $(this).jqGrid('setRowData', rowid, false, "classname anotherclassname");
    },
    ...