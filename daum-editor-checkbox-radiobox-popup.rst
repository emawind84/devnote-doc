.. _daum-editor-checkbox-radiobox-popup:

=========================================
Daum Editor <checkbox> <radiobox> <popup>
=========================================


// COMMON CODE SEARCH POPUP

.. code-block:: html

	<div class="commcode_search" data-commcd="COST_COMP" data-index="2">Dealim</div>
	<div class="dbdata_common_code2" style="display:none;">04</div>
	
	<div class="commcode_search" data-commcd="COST_COMP" data-index="1">STX Elec.</div>
	<div class="dbdata_common_code1" style="display:none;">01</div>


// CHECK BOX

.. code-block:: html

	<style>
	.check_field{background:url(/ext/style/COMMON/image/icon/unchecked_15.png) no-repeat scroll 0 0 / 15px 15px rgba(0,0,0,0);height:15px;width:15px;cursor:default;text-indent:-9999px;}
	.check_field.checked{background:url(/ext/style/COMMON/image/icon/checked_15.png) no-repeat scroll 0 0 / 15px 15px rgba(0,0,0,0);height:15px;width:15px;}
	.check_field.disabled{opacity:0.7;}
	</style>

	<div class="check_field dbdata_input_area1" data-value="value2222"></div>
	<div class="check_field dbdata_number_area2" data-value="3333"></div>


// RADIO BOX

.. code-block:: html

	<style>
	.radio_field{background:url(/ext/style/COMMON/image/icon/radio_unchecked_15.png) no-repeat scroll 0 0 / 15px 15px rgba(0,0,0,0);height:15px;width:15px;cursor:default;text-indent:-9999px;}
	.radio_field.checked{background:url(/ext/style/COMMON/image/icon/radio_checked_15.png) no-repeat scroll 0 0 / 15px 15px rgba(0,0,0,0);height:15px;width:15px;}
	.radio_field.disabled{opacity:0.7;}
	</style>
	
	<div class="radio_field dbdata_input_area1" data-group="aaa" data-value="bbb"></div>
	<div class="radio_field dbdata_input_area1 checked" data-group="aaa" data-value="ccc">ccc</div>
	<div class="radio_field dbdata_input_area1" data-group="aaa" data-value="eee"></div>
	<div class="radio_field dbdata_input_area1" data-group="aaa" data-value="ddd"></div>