.. _css3-box-sizing:

===============
CSS3 box-sizing
===============


reference:
http://code.tutsplus.com/tutorials/quick-tip-did-internet-explorer-get-the-box-model-right--net-12328
https://developer.mozilla.org/en-US/docs/Web/CSS/box-sizing

example:

<style>
textarea {
width: 100%;
padding: 10px;
}

THIS MAKE THE TRICK:
.borderbox {
-moz-box-sizing: border-box;
-webkit-box-sizing: border-box;
box-sizing: border-box;
}
</style>

<div style="height: 100px; width: 100px;">
<textarea class="borderbox"></textarea>
</div>