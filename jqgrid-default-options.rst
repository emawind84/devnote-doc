.. _jqgrid-default-options:

======================
jqGrid default options
======================

Use cmTemplate to set default options for colModel

Example:

::
    
    $("#detailList_${rid}").jqGrid({
        ...
        cmTemplate: { sortable: false }