.. _jqgrid-footer-row-(-total-row-):

===============================
jqGrid Footer Row ( Total Row )
===============================


.. code-block:: javascript
    
    $("#rescList").jqGrid({
        ...
        footerrow : true,
        
        colModel:[
            ...
            {name:'unit' },
            {name:"tot_before_sum_qty" },
            {name:"today_qty" },
            {name:"total_qty" },
            ...
        ],
            
        loadComplete: function(){
            // footer data
            $(this).jqGrid("footerData", "set", {
                unit: "Total:",
                tot_before_sum_qty: $(this).jqGrid('getCol', 'tot_before_sum_qty', false, 'sum'),
                today_qty: $(this).jqGrid('getCol', 'today_qty', false, 'sum'),
                total_qty: $(this).jqGrid('getCol', 'total_qty', false, 'sum')
            });
        },
        ...
        
    // resize
    $('#rescList').jqGrid("setGridHeight", $(this).height() 
        - $('.search_area', this).outerHeight() 
        - $('.workcalendar', this).outerHeight() 
        - $('tr.footrow', this).outerHeight() 
        - 25 );


