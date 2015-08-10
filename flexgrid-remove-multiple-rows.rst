.. _flexgrid-remove-multiple-rows:

=============================
FlexGrid Remove Multiple Rows
=============================


.. code-block:: javascript
	
	var count = fgDoc2.SelectedRows;
	removeRows( count );
	
	
	function removeRows(count) {
		if(count==0) {
			return;
		}
		for(n=fgDoc2.Rows-1 ; n > 0 ; n--)
		{
			if(fgDoc2.isSelected(n)) {
				fgDoc2.RemoveItem(n);
				count--;
				removeRows(count);
				break;
			}
		}
	}