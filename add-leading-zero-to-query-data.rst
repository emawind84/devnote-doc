.. _add-leading-zero-to-query-data:

==============================
Add Leading Zero to Query Data
==============================


Java String Object will remove the leading zero if a number is returned without formatting

fix::

    RTRIM(TO_CHAR(PLAN_RATE, 'FM99990D99'), '.') PLAN_RATE

reference::

    http://docs.oracle.com/cd/B19306_01/server.102/b14200/sql_elements004.htm
    http://www.techonthenet.com/oracle/functions/rtrim.php