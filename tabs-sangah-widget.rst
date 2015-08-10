.. _tabs-sangah-widget:

==================
Tabs Sangah Widget
==================




$('.content_area').initTab(); // activate tab functionality
$('.content_area').activeTab(); // return the active tab index
$('.content_area').activeTab('2'); // will set the tab with index '2' as current tab

[NOTE These functions have to be called from an element parent of 'tab_sub' element or an error will be thrown.]


EXAMPLE:

$(function(){
    $('.content_area').initTab();
    
    $('.tab_sub a[data-index="1"]').click(function(){ ... });
    $('.tab_sub a[data-index="2"]').click(function(){ ... });
    $('.tab_sub a[data-index="3"]').click(function(){ ... });
    ...
    
    
...
<div class="content_area">
    <div class="tab_area">
        <div class="tab_btns">
            <ul class="tab_sub">
                <li class="tab_active_left"><a href="#" data-index="1" class="tab_active_right">...</a></li>
                <li><a href="#" data-index="2">...</a></li>
                <li><a href="#" data-index="3">...</a></li>
            </ul>
        </div>
    </div>    
    ...

