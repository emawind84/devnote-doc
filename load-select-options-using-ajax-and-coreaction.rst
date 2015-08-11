.. _load-select-options-using-ajax-and-coreaction:

=============================================
Load select options using Ajax and CoreAction
=============================================




Data.jsp
---------------------------------------------------------

.. code-block:: jsp
    
    <%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    {
        "list": [
        <c:forEach var="value" items="${list}" varStatus="status">
            "${value}"
            <c:if test="${!status.last}" >,</c:if>
        </c:forEach>
        ]
    }

Ibatis xml
---------------------------------------------------------

.. code-block:: xml
    
    <select id="consPlanRateBackupList" resultClass="string">
    select value from tableName
    </select>

jsp file:
---------------------------------------------------------

.. code-block:: html

    <select id="ratebackup" ></select>

.. code-block:: javascript
    
    $.ajax({
        url: "/Core/CoreList.action",
        data: {
            "user-query": "pmis.cons.conspkg.consPlanRateBackupList",
            "user-forward": "/ml/cons/conspkg/Data.jsp"
        },
        type: "POST",
        dataType: "json"
    }).done(function(data){
        var options = $("#ratebackup");
        $.each(data.list, function(index, value) {
            options.append($("<option />").val(this).text(this));
        });
    });
    
