.. _jqgrid-settings-object-content-example:

======================================
jqGrid Settings Object Content Example
======================================


Example content of : $('#wfList')[0].p

.. code-block:: json
      
      {
         "url":"",
         "height":240,
         "page":1,
         "rowNum":99999,
         "rowTotal":null,
         "records":3,
         "pager":"",
         "pgbuttons":true,
         "pginput":true,
         "colModel":[
            {
               "name":"user_id",
               "width":1,
               "hidden":true,
               "key":true,
               "sortable":false,
               "title":true,
               "widthOrg":1,
               "resizable":true
            },
            {
               "name":"action_ro",
               "width":100,
               "fixed":true,
               "editable":true,
               "edittype":"select",
               "editoptions":{
                  "value":{
                     "APPR":"[App.↑]",
                     "AGRE":"[Agree↑]"
                  }
               },
               "sortable":false,
               "formatter":"select",
               "title":true,
               "hidden":false,
               "widthOrg":100,
               "resizable":true
            },
            {
               "name":"obs_name",
               "sortable":false,
               "width":161,
               "title":true,
               "hidden":false,
               "widthOrg":150,
               "resizable":true
            },
            {
               "name":"action",
               "hidden":true,
               "width":150,
               "title":true,
               "widthOrg":150,
               "resizable":true,
               "sortable":true
            }
         ],
         "rowList":[
      
         ],
         "colNames":[
            "user_id",
            "Step action",
            "Members",
            ""
         ],
         "sortorder":"asc",
         "sortname":"",
         "datatype":"local",
         "mtype":"GET",
         "altRows":false,
         "selarrrow":[
      
         ],
         "savedRow":[
      
         ],
         "shrinkToFit":true,
         "xmlReader":{
            "root":"rows",
            "row":"row",
            "page":"rows>page",
            "total":"rows>total",
            "records":"rows>records",
            "repeatitems":true,
            "cell":"cell",
            "id":"[id]",
            "userdata":"userdata",
            "subgrid":{
               "root":"rows",
               "row":"row",
               "repeatitems":true,
               "cell":"cell"
            }
         },
         "jsonReader":{
            "root":"rows",
            "page":"page",
            "total":"total",
            "records":"records",
            "repeatitems":true,
            "cell":"cell",
            "id":"id",
            "userdata":"userdata",
            "subgrid":{
               "root":"rows",
               "repeatitems":true,
               "cell":"cell"
            }
         },
         "subGrid":false,
         "subGridModel":[
      
         ],
         "reccount":3,
         "lastpage":0,
         "lastsort":0,
         "selrow":"test10@STND_PMIS",
         "beforeSelectRow":null,
         "onSortCol":null,
         "onRightClickRow":null,
         "onPaging":null,
         "onSelectAll":null,
         "onInitGrid":null,
         "gridComplete":null,
         "loadError":null,
         "loadBeforeSend":null,
         "afterInsertRow":null,
         "beforeRequest":null,
         "beforeProcessing":null,
         "onHeaderClick":null,
         "viewrecords":false,
         "loadonce":false,
         "multiselect":false,
         "multikey":false,
         "editurl":"clientArray",
         "search":false,
         "caption":"",
         "hidegrid":true,
         "hiddengrid":false,
         "postData":{
            "_search":false,
            "nd":1385616092429,
            "rows":99999,
            "page":1,
            "sidx":"",
            "sord":"asc"
         },
         "userData":{
      
         },
         "treeGrid":false,
         "treeGridModel":"nested",
         "treeReader":{
      
         },
         "treeANode":-1,
         "ExpandColumn":null,
         "tree_root_level":0,
         "prmNames":{
            "page":"page",
            "rows":"rows",
            "sort":"sidx",
            "order":"sord",
            "search":"_search",
            "nd":"nd",
            "id":"id",
            "oper":"oper",
            "editoper":"edit",
            "addoper":"add",
            "deloper":"del",
            "subgridid":"id",
            "npage":null,
            "totalrows":"totalrows"
         },
         "forceFit":false,
         "gridstate":"visible",
         "cellEdit":true,
         "cellsubmit":"clientArray",
         "nv":0,
         "loadui":"enable",
         "toolbar":[
            false,
            ""
         ],
         "scroll":false,
         "multiboxonly":false,
         "deselectAfterSort":true,
         "scrollrows":true,
         "autowidth":true,
         "scrollOffset":18,
         "cellLayout":5,
         "subGridWidth":20,
         "multiselectWidth":20,
         "gridview":false,
         "rownumWidth":25,
         "rownumbers":false,
         "pagerpos":"center",
         "recordpos":"right",
         "footerrow":false,
         "userDataOnFooter":false,
         "hoverrows":true,
         "altclass":"ui-priority-secondary",
         "viewsortcols":[
            false,
            "vertical",
            true
         ],
         "resizeclass":"",
         "autoencode":false,
         "remapColumns":[
      
         ],
         "ajaxGridOptions":{
      
         },
         "direction":"ltr",
         "toppager":false,
         "headertitles":false,
         "scrollTimeout":40,
         "data":[
            {
               "user_id":"test10@STND_PMIS",
               "action_ro":"APPR",
               "obs_name":"Test User 10",
               "action":"APPR",
               "id":"test10@STND_PMIS"
            },
            {
               "user_id":"test09@STND_PMIS",
               "action_ro":"APPR",
               "obs_name":"김구구",
               "action":"APPR",
               "id":"test09@STND_PMIS"
            },
            {
               "user_id":"test03@STND_PMIS",
               "action_ro":"APPR",
               "obs_name":"홍삼삼",
               "action":"APPR",
               "id":"test03@STND_PMIS"
            }
         ],
         "_index":{
            "test10@STND_PMIS":0,
            "test09@STND_PMIS":1,
            "test03@STND_PMIS":2
         },
         "grouping":false,
         "groupingView":{
            "groupField":[
      
            ],
            "groupOrder":[
      
            ],
            "groupText":[
      
            ],
            "groupColumnShow":[
      
            ],
            "groupSummary":[
      
            ],
            "showSummaryOnHide":false,
            "sortitems":[
      
            ],
            "sortnames":[
      
            ],
            "summary":[
      
            ],
            "summaryval":[
      
            ],
            "plusicon":"ui-icon-circlesmall-plus",
            "minusicon":"ui-icon-circlesmall-minus",
            "displayField":[
      
            ]
         },
         "ignoreCase":false,
         "cmTemplate":{
      
         },
         "idPrefix":"",
         "recordtext":"View {0} - {1} of {2}",
         "emptyrecords":"No records to view",
         "loadtext":"Loading...",
         "pgtext":"Page {0} of {1}",
         "useProp":true,
         "id":"wfList",
         "keyIndex":0,
         "localReader":{
            "root":"rows",
            "page":"page",
            "total":"total",
            "records":"records",
            "repeatitems":false,
            "cell":"cell",
            "id":"id",
            "userdata":"userdata",
            "subgrid":{
               "root":"rows",
               "repeatitems":true,
               "cell":"cell"
            }
         },
         "width":271,
         "tblwidth":271,
         "disableClick":false,
         "totaltime":1,
         "knv":"wfList_kn",
         "iCol":2,
         "iRow":3
      }