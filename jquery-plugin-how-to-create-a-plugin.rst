.. _jquery-plugin-how-to-create-a-plugin:

====================================
jQuery Plugin How to Create a Plugin
====================================


Reference:
http://learn.jquery.com/plugins/ ( recommended! )

**Protecting the $ Alias and Adding Scope**

.. note:: The $ variable is very popular among JavaScript libraries, and if you're using another library with jQuery, 
	you will have to make jQuery not use the $ with jQuery.noConflict(). 
	However, this will break our plugin since it is written with the assumption that $ is an alias to the jQuery function. 
	To work well with other plugins, and still use the jQuery $ alias, we need to put all of our code inside of an Immediately Invoked Function Expression, 
	and then pass the function jQuery, and name the parameter $:

.. code-block:: javascript
	
	(function ( $ ) {
		$.fn.greenify = function() {
			this.css( "color", "green" );
			return this;
		};
	
		$.ltrim = function( str ) {
			return str.replace( /^\s+/, "" );
		};
	
		$.rtrim = function( str ) {
			return str.replace( /\s+$/, "" );
		};
	}( jQuery ));
	
In addition, the primary purpose of an Immediately Invoked Function is to allow us to have our own private variables. Pretend we want a different color green, and we want to store it in a variable.

.. code-block:: javascript

	(function ( $ ) {
		var shade = "#556b2f";
		$.fn.greenify = function() {
			this.css( "color", shade );
			return this;
		};
	}( jQuery ));