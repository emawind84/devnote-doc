.. _cross-browser-javascript-fix:

============================
Cross browser javascript fix
============================



    
parent.iframeName.location.href -> parent.frames['iframeId'].location.href
document.all.objId. -> document.getElementById('objId').
document.all['objId']. -> document.getElementById('objId').
document.all('objId'). -> document.getElementById('objId').
document.iframeName.location.href -> document.getElementById('iframeId').src
document.frames['iframeName'].document -> document.getElementById('iframeId').contentWindow.document
document.iframeName. -> document.getElementById('iframeId').contentWindow.
windowobj.frames["iframeName"].document.frames["iframeName"] -> windowobj.frames["iframeName"].frames["iframeName"]

windowobj = window | top | parent

