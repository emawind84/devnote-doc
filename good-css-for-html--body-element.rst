.. _good-css-for-html--body-element:

================================
Good CSS for HTML & BODY Element
================================


Good reference to understand how HTML and BODY Element work:

http://phrogz.net/css/htmlvsbody.html


CSS:


html{
	overflow: auto;
	height: 100%;
	min-height: 100%;
}

body{
	position: relative;
}

html,body {
	width: 100%;
	margin: 0;
	/* overflow: auto; the main page doesn't show the vertical scroll if quick right is on */
}
