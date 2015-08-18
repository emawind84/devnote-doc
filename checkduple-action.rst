.. _checkduple-action:

=================
CheckDuple Action
=================


.. note::
	pmis.common.checkduple.CheckDupleAction
	
	
.. code-block:: javascript

	var URL = "/Common/CheckDuple.action";
	//@을 추가해서 체크함
	params = {
		"checkDupleForm.table": "PMIS_USER",
		"checkDupleForm.col": "USER_NO",
		"checkDupleForm.data": <value here>;
	}
	$.ajax({
		url: URL,
		data: params,
		type: "POST",
		dataType: "json"
	}).done(function (request){
		// do something with the result
	});
    
