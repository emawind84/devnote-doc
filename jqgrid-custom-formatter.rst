.. _jqgrid-custom-formatter:

=======================
jqGrid Custom Formatter
=======================


Some custom formatters made by Sangah

FORMATTER FOR DATE
********************************************************************************************************
    
.. code-block:: javascript
    
    function dateFormatter(cellvalue, options, rowObject) {
        return formatDate(cellvalue);
    }

FORMATTER FOR ATTACHMENT FILE COUNT
********************************************************************************************************

.. code-block:: javascript
   
    // JQGRID ATTACH FORMATTER defined in common.js
    $.extend($.fn.fmatter , {
    	attachments : function(cellvalue, options, rowdata) {
    		if( !cellvalue || cellvalue == 0 ) return '-';
    		return "<span class='btn_icon_file' data-rowid='"+ options.rowId +
                "' style='height: 14px;width: 14px;display: inline-block;vertical-align: middle;'></span> " + 
                ( cellvalue || "" );
        }
    });
    
    // USE IT
    {name:'file_size_ro', ..., formatter: "attachments"},

.. seealso:: script/common.js    

.. warning:: Deprecated do not use it

.. code-block:: javascript

    function attachFormatter(cellvalue, options, rowObject) {
        var strAttcImgPath = "<%=PmisConfig.get("system.WebRoot") %>/ext/image/icon/icon_zip.gif";
        return "<img src='"+ strAttcImgPath +"' /> " + cellvalue;
    }

FORMATTER FOR CHECKBOX
********************************************************************************************************

.. code-block:: javascript

    function checkBoxFormatter(cellvalue, options, rowObject){
        if(rowObject.obs_cd ) {
            return "<input type=\"checkbox\" class=\"menu-checkbox\" data-idx=\""+ options.rowId +"\" value=\"1\" checked=\"checked\" >";
        }
        return "<input type=\"checkbox\" class=\"menu-checkbox\" data-idx=\""+ options.rowId +"\" value=\"1\" >";
    }


FORMATTER FOR STATUS
********************************************************************************************************
    
.. code-block:: javascript

    function statusFormatter(cellvalue, options, rowObject) {
        var ret = rowObject;
        if( ret.status == '0' ) {
            return "<img src='" + "<%=PmisConfig.get("system.WebRoot") %>/ext/image/icon/ic_poi.gif" + "' />";
        }
        else if( ret.status == '1' ) {
            return "<img src='" + "<%=PmisConfig.get("system.WebRoot") %>/ext/image/icon/ic_ing.gif" + "' />";
        }
        else if( ret.status == '4' ) {
            return "<img src='" + "<%=PmisConfig.get("system.WebRoot") %>/ext/image/icon/ic_bpoi.gif" + "' />";
        }
        return "";
    }

FORMATTER FOR NUMBER
********************************************************************************************************

.. code-block:: javascript

    function numberFormatter(cellvalue, options, rowObject){
        return addCommas(cellvalue);
    }

    
FORMATTER FOR RATE
********************************************************************************************************

.. code-block:: javascript
    
    function rateFormatter(cellvalue, options, rowObject){
        return formatNumber(cellvalue, 4, true);
    }


FORMATTER FOR FILE SIZE
********************************************************************************************************

.. code-block:: javascript

    // JQGRID FILESIZE FORMATTER defined in common.js
	$.extend($.fn.fmatter , {
		filesize : function(cellvalue, options, rowdata) {
			if( cellvalue+"" == "0") return "0";
			if( !cellvalue ) return "";
			if( isNaN( parseInt( new Number(cellvalue) ) ) ) return "NaN";
			return Number(cellvalue).fileSize();
	    }
	});
    
    // USE IT
    {name:'file_size_ro', ..., formatter: "filesize"},

.. seealso:: script/common.js

.. warning:: Deprecated, do not use it

.. code-block:: javascript
    
    function sizeFormatter(cellvalue, options, cell) {
        var fileSize = 0;
        if (cellvalue > 1024 * 1024) {
            fileSize = (Math.round(cellvalue * 100 / (1024 * 1024)) / 100)
                    .toString()
                    + 'MB';
        } else {
            fileSize = (Math.round(cellvalue * 100 / 1024) / 100)
                    .toString()
                    + 'KB';
        }
        return fileSize;
    }

FORMATTER FOR IMAGE + TEXT
********************************************************************************************************

.. code-block:: javascript

    function nameFormatter(cellvalue, options, rowObject){
        var ret = $(this).jqGrid('getLocalRow', options.rowId);
        var result = "";
        if(!ret) {
            var ret = rowObject;
        }
        result = "<div class='float-left'><img src='"+ strUpImgPath +"' /> <span>" + cellvalue + "</span></div>";
    }
    
UNFORMATTER
^^^^^^^^^^^^^^^^

.. code-block:: javascript
    
    function nameUnFormatter(cellvalue, options, cell){
        return $('span', cell).text();
    }
    

FORMATTER FOR REVERSE ROW NUMBER
********************************

.. code-block:: javascript

    var rowcount = 0; // 줄번호 계산 때문에 필요합니다
    function rownoFormatter(cellvalue, options, rowObject){
    	return Number( "${pageUtil.total - pageUtil.pageScale * ( pageUtil.current - 1 )}" ) - rowcount++;
    }
    $('#docList').on('jqGridGridComplete', function(){ rowcount = 0; /* 줄번호 계산 때문에 필요합니다 */ });