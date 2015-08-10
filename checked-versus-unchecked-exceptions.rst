.. _checked-versus-unchecked-exceptions:

===================================
Checked versus unchecked exceptions
===================================


Checked versus unchecked exceptions
reference: http://www.javapractices.com/topic/TopicAction.do?Id=129

Unchecked exceptions
--------------------

represent defects in the program (bugs) - often invalid arguments passed to a non-private method. To quote from The Java Programming Language, by Gosling, Arnold, and Holmes: "Unchecked runtime exceptions represent conditions that, generally speaking, reflect errors in your program's logic and cannot be reasonably recovered from at run time."
are subclasses of RuntimeException, and are usually implemented using IllegalArgumentException, NullPointerException, or IllegalStateException
a method is not obliged to establish a policy for the unchecked exceptions thrown by its implementation (and they almost always do not do so)

Checked exceptions
------------------

represent invalid conditions in areas outside the immediate control of the program (invalid user input, database problems, network outages, absent files)
are subclasses of Exception
a method is obliged to establish a policy for all checked exceptions thrown by its implementation (either pass the checked exception further up the stack, or handle it somehow)

It's somewhat confusing, but note as well that RuntimeException (unchecked) is itself a subclass of Exception (checked). 