.. _input-mask:

==========
Input Mask
==========




<input ... data-keylvl="H" data-masktype="date" data-label="input_name_field" maxlength="10" >

data-dsize: the number of decimal places to format the number to ( in case 'numeric' or 'number' masktype is used )

data-masktype:
    date
    shortdate -> 2013-04
    mediumdate -> 2013-04-01
    longdate = date -> 2013-01-01 10:12 | 2013-01-01 오전 10:12 
    zipcode
    ssn
    currency
    percent
    numeric, number
    email
    jumin
    string

data-keylvl:
    R -> READONLY
    H -> REQUIRED
    M -> if the value is empty a popup will ask if we want to save the empty field ( not tested! )

class available: 
    input_data3, input_text -> NORMAL textbox
    input_data2, input_required -> REQUIRED textbox
    input_data1, input_readonly -> READONLY textbox
    
    
<input ... data-keylvl="R" ... >  == <input ... class="input_readonly" readonly="readonly" ... >
<input ... data-keylvl="H" ... >  == <input ... class="input_required" ... >


Input alignment automatic method:

    <input ... class="input-resize" data-resize="45" >
    
    the input will be resized as follow: parent.width - 45 
    
[NOTE maxlength property is required during validation if data-masktype="STRING" is used]

