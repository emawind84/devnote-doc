.. _jquery-tooltip-qtip2:

====================
jQuery Tooltip qTip2
====================


reference:

- http://qtip2.com/demos
- http://qtip2.com/guides
- http://qtip2.com/options

.. code-block:: javascript
		
	$('.tooltip').qtip({
		content: {
			text: 'ciao!'
			//text: $('.tooltip-content')
		},
		position: {
			target: $('.qtip-target'),
			//target: $('.tooltip')
			viewport: $(window),
			my: 'top right',
			at: 'bottom left'
		},
		style: {
			classes: 'qtip-rounded qtip-light qtip-shadow'
		},
		show: {
			ready: true
		}
		,hide: {
			//event: 'unfocus'
			//inactive: 1000,
			fixed: true,
			delay: 300
		}
	});
	
.. code-block:: html

	<div class="tooltip"></div>
	<div class="qtip-target"></div>