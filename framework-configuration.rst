.. _framework-configuration:

=======================
Framework configuration
=======================



_____________________________________________________________________________
Libraries on the build path:

IMPORTANT! 
Please check the sorting of the libraries in the file .classpath
 
<classpath>
    <classpathentry kind="src" path="src"/>
    <classpathentry kind="src" path="messages"/>
    <classpathentry kind="src" path="properties"/>
    <classpathentry kind="con" path="org.eclipse.jdt.launching.JRE_CONTAINER"/>
    <classpathentry kind="con" path="org.eclipse.jst.server.core.container/org.eclipse.jst.server.tomcat.runtimeTarget/Apache Tomcat v6.0"/>
    ...
    <classpathentry kind="lib" path="lib/..."/>
    <classpathentry kind="lib" path="web/WEB-INF/lib/..."/>
    <classpathentry kind="output" path="web/WEB-INF/classes"/>
</classpath> 
