.. _grid-excel-export:

=================
Grid Excel Export
=================


.. code-block:: javascript
    
    top.exportXls({
        url: "/Common/ExcelAction/exportXls.action",
        content: {
            param1: "value1",
            param2: "value2",
            param3: "value3",
            param4: "value4",
            query: "eis.eisresc.getSTXRescList",
            title: titleName,
            templeteFileName: 'templatename',
            fileName: 'filename' 
        }
    });      
    
