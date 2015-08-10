.. _declaring-character-encodings-in-css:

====================================
Declaring character encodings in CSS
====================================



    
Using @charset

To set the character encoding inside the style sheet, use the @charset "at-rule". Its syntax is:
@charset "<IANA-defined-charset-name>";

Only one @charset rule may appear in an external style sheet and it must appear at the very start of the document. 
It must not be preceded by any characters, not even comments. 
(However, a byte-order mark is OK for a document in one of the Unicode encodings.)

reference: 
    http://www.w3.org/International/questions/qa-css-charset.en.php
    https://www.iana.org/assignments/character-sets/character-sets.xhtml
    
