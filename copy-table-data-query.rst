.. _copy-table-data-query:

=====================
Copy Table Data Query
=====================

.. code-block:: sql

  begin
    for r in (select *
               from [TABLE]
               where
                   [CONDITION]
            )
    loop
        --change fields if needed
      SELECT NVL( MAX( idx ), 0 ) + 1 into r.idx from document_to;
      r.owner_id := #new_owner_id#;
      --insert new data in a new table or the same table
      insert into [TABLE] values r;
    end loop;
  end;