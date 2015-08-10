.. _drop-table-constraints:

======================
drop table constraints
======================

.. code-block:: sql

    BEGIN
      FOR ind IN 
        (SELECT index_name FROM user_indexes WHERE table_name = upper('comm_attch_file') AND index_name NOT IN 
           (SELECT unique index_name FROM user_constraints WHERE 
              table_name = upper('comm_attch_file') AND index_name IS NOT NULL))
      LOOP
          execute immediate 'DROP INDEX '||ind.index_name;
      END LOOP;
    END;