.. _strict-mode-and-immediately-invoked-function-expression:

=======================================================
Strict Mode and Immediately-Invoked Function Expression
=======================================================




Strict mode changes some previously-accepted mistakes into errors. 
JavaScript was designed to be easy for novice developers, and sometimes it gives operations which should be errors non-error semantics. 
Sometimes this fixes the immediate problem, but sometimes this creates worse problems in the future. Strict mode treats these mistakes as errors so that they're discovered and promptly fixed.

.. code-block:: javascript
  
  function strict(){
    // Function-level strict mode syntax
    'use strict';
    function nested() { return "And so am I!"; }
    return "Hi!  I'm a strict mode function!  " + nested();
  }
  function notStrict() { return "I'm not strict."; }

.. seealso:: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions_and_function_scope/Strict_mode



Immediately-Invoked Function Expression (IIFE)
-----------------------------------------------

A common pattern in JavaScript is the immediately-invoked function expression. 
This pattern creates a function expression and then immediately executes the function. 
This pattern is extremely useful for cases where you want to avoid polluting the global namespace with code – no variables declared inside of the function are visible outside of it. 

.. seealso:: http://stage.learn.jquery.com/javascript-101/functions/#immediately-invoked-function-expression
.. seealso:: http://benalman.com/news/2010/11/immediately-invoked-function-expression/


Good patter to use in page:

.. code-block:: javascript
  
  (function($){
  'use strict';
  
      // all content here!
      // using this pattern will keep functions and variables private
  
  })(jQuery);
