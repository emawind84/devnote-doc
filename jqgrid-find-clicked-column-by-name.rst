.. _jqgrid-find-clicked-column-by-name:

==================================
jqGrid find clicked column by name
==================================


$('#list').jqGrid({
    ondblClickRow: function(rowid, irow, icol) {
	var ret = $(this).jqGrid('getRowData',rowid);
	var cm = $(this).jqGrid('getGridParam','colModel');
	if(cm[icol].name == "selected"){
		//...
	}
	else if(cm[icol].name == "del_image"){
		//...
	}
	//...