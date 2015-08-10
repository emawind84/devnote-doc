.. _jqgrid-custom-select-row:

========================
jqGrid Custom Select Row
========================



The following function produce the same effect of the default function 'setSelection' save when the passed parameter is null or empty. 
In case the parameter is null or empty, if data are present, will be selected the first row or no action otherwise.

selectGridRow(rowid)

example:

//Can be used in the situation when after the loading of the grid we want to select the row passed by the request.

$('#gridid').jqGrid({
    ...
    loadComplete: function(){
        var $grid = $(this); 
        setTimeout( function(){ // timeout function can resolve scroll issue on the selected row 
            $grid.jqGrid('selectGridRow', "${param.menu_cd}");
        }, 100);    
    },
    ...

