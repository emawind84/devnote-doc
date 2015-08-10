.. _ibatis-and-hashmap:

==================
iBatis and HashMap
==================




pmis.common.struts.CustomHashMap

Using: resultClass="java.util.HashMap"
---------------------------------------------------------
[NOTE keys are upper case!]

java: map.get("KEY");
jsp: <s:out value='${list.KEY}' />


Using: resultClass="pmis.common.struts.CustomHashMap"
---------------------------------------------------------
[NOTE On the map will be set lower case keys]
[NOTE the key is case insensitive! 'key' or 'KEY' return the same value]

java: map.get("key");
jsp: <s:out value='${list.key}' />

java: map.get("KEY")
jsp: <s:out value='${list.KEY}' />



Alias:

resultClass="java.util.HashMap" -> resultClass="hmap"
resultClass="pmis.common.struts.CustomHashMap" -> resultClass="cmap"


IMPORTANT!

Map m = CoreUtil.getParameters(request);
Map ibatisResult = dao.getMap();

ibatisResult.putAll(m);

If ibatis return java.util.HashMap, is not possible to mix correctly the two tables since keys are different,
the map created by ibatis has upper case key and the map populated from request has lower case and upper case keys as defined on jsp!
Mixing the map from ibatis and parameters map from request can lead to undesirable behavior.
Using CustomHashMap as the result of ibatis query can solve the problem.
    
