
.. _learning_python:

===========================
Learning Python Episode One
===========================

.. seealso:: Second episode :ref:`learning_python_2`!

.. code:: python

    'ciao'




.. parsed-literal::

    'ciao'



Formatting
--------------------

.. code:: python

    # Formatting expression
    '%s, eggs, and %s' % ('spam', 'SPAM!')




.. parsed-literal::

    'spam, eggs, and SPAM!'



.. code:: python

    # Formatting method
    '{0}, eggs, and {1}'.format('spam', 'SPAM!')




.. parsed-literal::

    'spam, eggs, and SPAM!'



.. code:: python

    # Numbers are optional
    '{}, eggs, and {}'.format('spam', 'SPAM!')




.. parsed-literal::

    'spam, eggs, and SPAM!'



.. code:: python

    M = [[1,2,3],[5,4,2]]

.. code:: python

    M




.. parsed-literal::

    [[1, 2, 3], [5, 4, 2]]



.. code:: python

    x = 4
    while x > 0:
        print('spam!' * x)
        x -= 1


.. parsed-literal::

    spam!spam!spam!spam!
    spam!spam!spam!
    spam!spam!
    spam!


.. code:: python

    zip?

Mapping Operations
-----------------------

.. code:: python

    bob1 = dict(name='Emanuele', job='Engineer!', age='31')
    bob1




.. parsed-literal::

    {'age': '31', 'job': 'Engineer!', 'name': 'Emanuele'}



.. code:: python

    temp = zip(['name', 'age', 'job'],['Emanuele', '31', 'Engineer!'])
    print(temp)
    type(temp)


.. parsed-literal::

    [('name', 'Emanuele'), ('age', '31'), ('job', 'Engineer!')]




.. parsed-literal::

    list



In Python3 temp is a zip object::

    >>> print(temp)
    <zip object at 0x7698f6c0>

.. code:: python

    dict(temp)




.. parsed-literal::

    {'age': '31', 'job': 'Engineer!', 'name': 'Emanuele'}



Missing Keys: if Tests
-----------------------------

.. code:: python

    D = {'a': 1, 'b': 2, 'c': 3}
    D




.. parsed-literal::

    {'a': 1, 'b': 2, 'c': 3}



.. code:: python

    D['e'] = 99
    D




.. parsed-literal::

    {'a': 1, 'b': 2, 'c': 3, 'e': 99}



.. code:: python

    'f' in D




.. parsed-literal::

    False



.. code:: python

    if not 'f' in D:
        print('missing WTF!')


.. parsed-literal::

    missing WTF!


Index with default value
+++++++++++++++++++++++++++++++

.. code:: python

    value = D.get('x', 0)
    value




.. parsed-literal::

    0



if/else expression form
++++++++++++++++++++++++++++++++

.. code:: python

    value = D['x'] if 'x' in D else 0
    value




.. parsed-literal::

    0



Iteration and Optimization
--------------------------------

.. code:: python

    temp = [x ** 2 for x in [1, 2, 3, 4, 5]]
    temp




.. parsed-literal::

    [1, 4, 9, 16, 25]



.. code:: python

    temp = []
    for x in [1, 2, 3, 4, 5]:
        temp.append(x ** 2)
    temp




.. parsed-literal::

    [1, 4, 9, 16, 25]



Tuples
-----------

.. code:: python

    T = (1, 2, 3, 4)
    len(T)




.. parsed-literal::

    4



.. code:: python

    T + (5, 6)




.. parsed-literal::

    (1, 2, 3, 4, 5, 6)



.. code:: python

    T.index(3) # 3 appears at offset 2




.. parsed-literal::

    2



.. code:: python

    T.count(4) # 4 appears once




.. parsed-literal::

    1



.. code:: python

    T[0] = 123 # immutable


::


    ---------------------------------------------------------------------------

    TypeError                                 Traceback (most recent call last)

    <ipython-input-35-392e8b7c48f8> in <module>()
    ----> 1 T[0] = 123
    

    TypeError: 'tuple' object does not support item assignment


.. code:: python

    T = (2,) + T[1:]
    T




.. parsed-literal::

    (2, 2, 3, 4)



.. code:: python

    # one item tuples require a trailing comma!
    type((2,))




.. parsed-literal::

    tuple



.. code:: python

    # parentheses can be omitted where commas don't otherwise matter
    T = 'spam', 3.0, [11, 12, 34]
    T




.. parsed-literal::

    ('spam', 3.0, [11, 12, 34])



.. code:: python

    [ord(x) for x in 'spaam']




.. parsed-literal::

    [115, 112, 97, 97, 109]



.. code:: python

    # Generator of values
    gen = (ord(x) for x in 'spaaam')
    for x in gen:
        print x


.. parsed-literal::

    115
    112
    97
    97
    97
    109






Files
-----------

.. code:: python

    # writing the file
    f = open('data.txt', 'w')
    f.write('Ciao\n')
    f.write('Bello!\n')
    f.close()

.. code:: python

    # reading the file
    f = open('data.txt', 'r') # r default
    text = f.read()
    text




.. parsed-literal::

    'Ciao\nBello!\n'



.. code:: python

    print(text)


.. parsed-literal::

    Ciao
    Bello!
    


.. code:: python

    text.split()




.. parsed-literal::

    ['Ciao', 'Bello!']



.. code:: python

    for line in open('data.txt'): print(line)


.. parsed-literal::

    Ciao
    
    Bello!
    


.. code:: python

    f.tell()





.. parsed-literal::

    12L



.. code:: python

    f.seek(5)

.. code:: python

    print(f.read())


.. parsed-literal::

    Bello!
    


Binary Bytes Files
--------------------------

.. code:: python

    # writing binary data
    import struct
    packed = struct.pack('>i4sh', 7, b'spam', 8)
    packed




.. parsed-literal::

    '\x00\x00\x00\x07spam\x00\x08'



.. code:: python

    file = open('data.bin', 'wb')
    file.write(packed)
    file.close()

.. code:: python

    # reading binary data
    data = open('data.bin', 'rb').read()
    data




.. parsed-literal::

    '\x00\x00\x00\x07spam\x00\x08'



.. code:: python

    data[4:8]




.. parsed-literal::

    'spam'



.. code:: python

    list(data)




.. parsed-literal::

    ['\x00', '\x00', '\x00', '\x07', 's', 'p', 'a', 'm', '\x00', '\x08']



.. code:: python

    struct.unpack('>i4sh', data)




.. parsed-literal::

    (7, 'spam', 8)



.. code:: python

    len(data) # length in bytes




.. parsed-literal::

    10



Unicode Text Files
-----------------------

.. code:: python

    S = u'sp\xc4m'
    print(S) # for Python 2.x
    S # for Python 3.x


.. parsed-literal::

    spÄm


.. code:: python

    print(S[2])


.. parsed-literal::

    Ä


.. code:: python

    import codecs # required for Python 2.X

.. code:: python

    file = codecs.open('unidata.txt', 'w', encoding='utf-8') # Write/encode UTF-8 text
    file.write(S)

.. code:: python

    file.close()

.. code:: python

    text = codecs.open('unidata.txt', encoding='utf-8').read() # Read/decode UTF-8 text
    print(text) # for Python 2.x
    text # for Python 3.x


.. parsed-literal::

    spÄm




.. parsed-literal::

    u'sp\xc4m'



.. code:: python

    len(text)




.. parsed-literal::

    4



.. code:: python

    # Read raw encoded bytes
    raw = open('unidata.txt', 'rb').read()
    raw




.. parsed-literal::

    'sp\xc3\x84m'



.. code:: python

    # raw/undecoded too
    open('unidata.txt').read() # Python 2.x same as above




.. parsed-literal::

    'sp\xc3\x84m'



.. code:: python

    len(raw)




.. parsed-literal::

    5



.. code:: python

    text.encode('utf-8') # encode to bytes




.. parsed-literal::

    'sp\xc3\x84m'



.. code:: python

    raw.decode('utf-8') # decode to str




.. parsed-literal::

    u'sp\xc4m'



.. code:: python

    text.encode('latin-1')




.. parsed-literal::

    'sp\xc4m'



.. code:: python

    text.encode('utf-16')




.. parsed-literal::

    '\xff\xfes\x00p\x00\xc4\x00m\x00'



.. code:: python

    S = b'\xff\xfes\x00p\x00\xc4\x00m\x00'.decode('utf-16')
    print(S) # Python 2.x
    S # Python 3.x


.. parsed-literal::

    spÄm


.. code:: python

    S




.. parsed-literal::

    u'sp\xc4m'



Other Core Types
---------------------

Sets
+++++++++++++++

.. code:: python

    X = set('spaaaaam')
    Y = {'h', 'a', 'm'}
    X, Y




.. parsed-literal::

    ({'a', 'm', 'p', 's'}, {'a', 'h', 'm'})



.. code:: python

    X & Y




.. parsed-literal::

    {'a', 'm'}



.. code:: python

    {n ** 2 for n in [1,2,3,4]}




.. parsed-literal::

    {1, 4, 9, 16}



.. code:: python

    list(set([1, 2, 1, 4, 1])) #Filtering out duplicates




.. parsed-literal::

    [1, 2, 4]



.. code:: python

    set([1, 2, 1, 4, 1])




.. parsed-literal::

    {1, 2, 4}



.. code:: python

    set('ciao') == set('oaic')




.. parsed-literal::

    True



.. code:: python

    'p' in set('spam'), 'p' in 'spam', 'ham' in ['eggs']




.. parsed-literal::

    (True, True, False)



Floating-point, Decimals & Fractions
+++++++++++++++++++++++++++++++++++++++++

.. code:: python

    1.0 / 3 # A .0 is required in Python 2.x




.. parsed-literal::

    0.3333333333333333



.. code:: python

    (2.0/3) + (1.0/2)




.. parsed-literal::

    1.1666666666666665



.. code:: python

    import decimal
    d = decimal.Decimal('3.141')
    d + 1




.. parsed-literal::

    Decimal('4.141')



.. code:: python

    decimal.getcontext().prec = 3 # decimal precision
    decimal.Decimal('1.00') / decimal.Decimal('3.00')




.. parsed-literal::

    Decimal('0.333')



.. code:: python

    from fractions import Fraction # Fractions: numerator+denominator
    f = Fraction(2, 3)
    f + 1




.. parsed-literal::

    Fraction(5, 3)



.. code:: python

    f + Fraction(1, 2)




.. parsed-literal::

    Fraction(7, 6)



The type Object
+++++++++++++++++++++++

.. code:: python

    L = [1, 2, 4]
    print(type(L)) # in Python 2.x
    type(L) # in Python 3.x


.. parsed-literal::

    <type 'list'>


.. code:: python

    type(L) == type([])




.. parsed-literal::

    True



.. code:: python

    if type(L) == list:
        print(True)


.. parsed-literal::

    True


.. code:: python

    True if type(L) == list else False




.. parsed-literal::

    True



.. code:: python

    True if isinstance(L, list) else False




.. parsed-literal::

    True



.. code:: python

    class Worker:
        def __init__(self, name, pay):
            self.name = name
            self.pay = pay
        def lastName(self):
            return self.name.split()[-1]
        def giveRaise(self, percent):
            self.pay *= (1.0 * percent)

.. code:: python

    ema = Worker('Emanuele Disco', 1000000)

.. code:: python

    ema.lastName()




.. parsed-literal::

    'Disco'



-------------------
Numeric Literals
-------------------

.. code:: python

    bin(5)




.. parsed-literal::

    '0b101'



.. code:: python

    repr(3)




.. parsed-literal::

    '3'



.. code:: python

    repr(ema) # Return the canonical string representation of the object.
    `ema` # same as above removed in Python 3.x




.. parsed-literal::

    '<__main__.Worker instance at 0x28ef6e8>'



.. code:: python

    str(ema)




.. parsed-literal::

    '<__main__.Worker instance at 0x28ef6e8>'



.. code:: python

    x = [1,2,3,4]
    x[0:3:2] # is equivalent to x[slice(0, 3, 2)]




.. parsed-literal::

    [1, 3]



.. code:: python

    x[slice(0, 3, 2)]




.. parsed-literal::

    [1, 3]



.. code:: python

    a = 3
    b = 4

.. code:: python

    a + 1, a - 1




.. parsed-literal::

    (4, 2)



.. code:: python

    b * 3, b / 2.0




.. parsed-literal::

    (12, 2.0)



.. code:: python

    a % 2




.. parsed-literal::

    1



.. code:: python

    b / ( 2.0 + a )




.. parsed-literal::

    0.8



.. code:: python

    str(b / ( 2.0 + a ))




.. parsed-literal::

    '0.8'



.. code:: python

    num = 1 / 3.0
    num # auto echoes




.. parsed-literal::

    0.3333333333333333



.. code:: python

    print(num) # print explicitly


.. parsed-literal::

    0.333333333333


.. code:: python

    '%e' % num # string formatting expression




.. parsed-literal::

    '3.333333e-01'



.. code:: python

    '%4.3f' % num




.. parsed-literal::

    '0.333'



.. code:: python

    '{0:4.2f}'.format(num)




.. parsed-literal::

    '0.33'



.. code:: python

    repr('spam')




.. parsed-literal::

    "'spam'"



.. code:: python

    str('spam')




.. parsed-literal::

    'spam'



.. code:: python

    repr("spam")




.. parsed-literal::

    "'spam'"



Comparisons: Normal and Chained
+++++++++++++++++++++++++++++++++

.. code:: python

    2.0 >= 1




.. parsed-literal::

    True



.. code:: python

    X = 2
    Y = 4
    Z = 6
    X < Y < Z




.. parsed-literal::

    True



.. code:: python

    False < 3




.. parsed-literal::

    True



.. code:: python

    1.1 + 2.2




.. parsed-literal::

    3.3000000000000003



.. code:: python

    int(1.1 + 2.2) == int(3.3)




.. parsed-literal::

    True



Division: Classic, Floor, and True
++++++++++++++++++++++++++++++++++++++

.. code:: python

    X / Y # classic in Python 2.x and true division in Python 3.x




.. parsed-literal::

    0



.. code:: python

    X // Y # floor division




.. parsed-literal::

    0



.. code:: python

    6 // 5




.. parsed-literal::

    1



.. code:: python

    import time

.. code:: python

    time.sleep(.1)

.. code:: python

    10 // 4.0




.. parsed-literal::

    2.0



Use the following module to enable Python 3.x ``/`` behaviour

.. code:: python

    from __future__ import division # enable Python 3.x / behaviour

.. code:: python

    10 / 4




.. parsed-literal::

    2.5



Division in Python 3.X
++++++++++++++++++++++++++++++++

The ``//`` operator is called *truncating* but is more accurate to refer to it as *floor*.

.. code:: python

    5 / 2, 5 / -2




.. parsed-literal::

    (2.5, -2.5)



.. code:: python

    # (2, -3) in Python 2.x

.. code:: python

    5 // 2, 5 // -2 # same in Python 2,x




.. parsed-literal::

    (2, -3)



.. code:: python

    5 / 2.0, 5 / -2.0 # same in Python 2,x




.. parsed-literal::

    (2.5, -2.5)



.. code:: python

    5 // 2.0, 5 // -2.0 # same in Python 2,x




.. parsed-literal::

    (2.0, -3.0)



.. code:: python

    import math

.. code:: python

    math.floor(2.5)




.. parsed-literal::

    2.0



.. code:: python

    math.floor(-2.5)




.. parsed-literal::

    -3.0



.. code:: python

    math.trunc(2.3)




.. parsed-literal::

    2



.. code:: python

    math.trunc(-2.6)




.. parsed-literal::

    -2



.. code:: python

    5 / -2




.. parsed-literal::

    -2.5



.. code:: python

    # -3 in Python 2.x

.. code:: python

    math.trunc(5 / -2) # in Python 3.x




.. parsed-literal::

    -2



.. code:: python

    math.trunc(5 / float(-2)) # in Python 2.x




.. parsed-literal::

    -2



.. code:: python

    1 % 8 # remainder




.. parsed-literal::

    1



Hex, Octal, Binary
++++++++++++++++++++++++++++++

.. code:: python

    0o1, 0o20, 0o377 # octal




.. parsed-literal::

    (1, 16, 255)



.. code:: python

    0x01, 0x10, 0xFF # hex




.. parsed-literal::

    (1, 16, 255)



.. code:: python

    (0b1, 0b10000, 0b11111111)




.. parsed-literal::

    (1, 16, 255)



.. code:: python

    oct(64), hex(64), bin(64)




.. parsed-literal::

    ('0100', '0x40', '0b1000000')



.. code:: python

    64, 0o100, 0x40, 0b10000000




.. parsed-literal::

    (64, 64, 64, 128)



.. code:: python

    int('64'), int('100', 8), int('40', 16), int('100000', 2)




.. parsed-literal::

    (64, 64, 64, 32)



.. code:: python

    int('0x40', 16)




.. parsed-literal::

    64



.. code:: python

    eval('64'), eval('0o34'), eval('0x34'), eval('0b110101')




.. parsed-literal::

    (64, 28, 52, 53)



.. code:: python

    '{0:o}, {1:x}, {2:b}'.format(64,64,64)




.. parsed-literal::

    '100, 40, 1000000'



.. code:: python

    '%o, %x, %x, %X' % (64, 64, 255, 255)




.. parsed-literal::

    '100, 40, ff, FF'



.. code:: python

    # the old octal in Python 2.x
    01, 020, 0377 # error in Python 3.x




.. parsed-literal::

    (1, 16, 255)



.. code:: python

    X = 0x12312123123123
    X




.. parsed-literal::

    5120567972868387L



.. code:: python

    oct(X)




.. parsed-literal::

    '0221422044304430443L'



Bitwise Operations
+++++++++++++++++++++++++

.. code:: python

    x = 1 # 1 decimal is 0001 in bits

.. code:: python

    x << 2 # shift left 2 bits




.. parsed-literal::

    4



.. code:: python

    x | 2 # Bitwise OR




.. parsed-literal::

    3



.. code:: python

    x & 1 # Bitwise AND




.. parsed-literal::

    1



.. code:: python

    X = 0b0001
    X << 2




.. parsed-literal::

    4



.. code:: python

    bin(X << 2)




.. parsed-literal::

    '0b100'



.. code:: python

    bin(X | 0b010)




.. parsed-literal::

    '0b11'



.. code:: python

    bin(X & 0b1) # bitwise AND: both




.. parsed-literal::

    '0b1'



.. code:: python

    X = 0xFF
    bin(X)




.. parsed-literal::

    '0b11111111'



.. code:: python

    X ^ 0b111111 # bitwise XOR: either but not both




.. parsed-literal::

    192



.. code:: python

    X = 99
    bin(X), X.bit_length(), len(bin(X)) - 2




.. parsed-literal::

    ('0b1100011', 7, 7)



.. code:: python

    import math

.. code:: python

    math.pi, math.e




.. parsed-literal::

    (3.141592653589793, 2.718281828459045)



.. code:: python

    math.sqrt(144), math.sqrt(2)




.. parsed-literal::

    (12.0, 1.4142135623730951)



.. code:: python

    min(1,4,8,3), max(5,4,1,1), min([1,5,7])




.. parsed-literal::

    (1, 5, 1)



.. code:: python

    math.floor(2.5), math.floor(-2.3)




.. parsed-literal::

    (2.0, -3.0)



.. code:: python

    int(2.5123), int(-2.634)




.. parsed-literal::

    (2, -2)



.. code:: python

    round(2.523), round(2.4123), round(2.567, 2)




.. parsed-literal::

    (3.0, 2.0, 2.57)



.. code:: python

    # round for display
    '%.1f' % 2.567, '{0:.2f}'.format(2.567)
    # this format produce strings




.. parsed-literal::

    ('2.6', '2.57')



.. code:: python

    (1 / 3.0), round(1 / 3.0, 2), ('%.2f' % (1 / 3.0))




.. parsed-literal::

    (0.3333333333333333, 0.33, '0.33')



.. code:: python

    #square three methods
    import math # Module
    math.sqrt(144)




.. parsed-literal::

    12.0



.. code:: python

    144 ** .5 # expression




.. parsed-literal::

    12.0



.. code:: python

    pow(144, .5)




.. parsed-literal::

    12.0



.. code:: python

    import random
    random.random()




.. parsed-literal::

    0.9649111804202926



.. code:: python

    random.randint(1, 10)




.. parsed-literal::

    9



.. code:: python

    random.choice(['1', '5', '123123'])




.. parsed-literal::

    '5'



.. code:: python

    pinco = ['lol', 'spam', 'che palle']
    random.shuffle(pinco)

.. code:: python

    pinco




.. parsed-literal::

    ['che palle', 'spam', 'lol']



.. code:: python

    0.1 + 0.1 + 0.1 - 0.3




.. parsed-literal::

    5.551115123125783e-17



.. code:: python

    print(0.1 + 0.1 + 0.1 - 0.3)


.. parsed-literal::

    5.55111512313e-17


Decimal basics
+++++++++++++++++++++

.. code:: python

    from decimal import Decimal

.. code:: python

    Decimal('0.1') + Decimal('0.1') + Decimal('0.1') - Decimal('0.3')




.. parsed-literal::

    Decimal('0.0')



.. code:: python

    Decimal.from_float(1.231) # convert float -> decimal




.. parsed-literal::

    Decimal('1.2310000000000000941469124882132746279239654541015625')



.. code:: python

    Decimal(0.1)




.. parsed-literal::

    Decimal('0.1000000000000000055511151231257827021181583404541015625')



.. code:: python

    Decimal(1) / Decimal(7) # default 28 digits




.. parsed-literal::

    Decimal('0.1428571428571428571428571429')



.. code:: python

    # Fixed precition
    import decimal
    decimal.getcontext().prec = 4
    Decimal(1) / Decimal(7)




.. parsed-literal::

    Decimal('0.1429')



.. code:: python

    Decimal(0.1) + Decimal(0.1) + Decimal(0.1) - Decimal(0.3)




.. parsed-literal::

    Decimal('1.110E-17')



.. code:: python

    1999 + 1.33




.. parsed-literal::

    2000.33



.. code:: python

    decimal.getcontext().prec = 2
    pay = Decimal(str(1999 + 1.33))
    pay




.. parsed-literal::

    Decimal('2000.33')



.. code:: python

    # decimal context manager
    with decimal.localcontext() as ctx:
        ctx.prec = 6
        d = Decimal('1.00') / Decimal('3.00')
        print(repr(d))


.. parsed-literal::

    Decimal('0.333333')


.. code:: python

    d = Decimal('1.00') / Decimal('3.00')
    print(repr(d))


.. parsed-literal::

    Decimal('0.33')


Fraction Type
++++++++++++++++++++++++++++

.. code:: python

    from fractions import Fraction
    x = Fraction(1, 3)
    y = Fraction(4, 6)

.. code:: python

    x




.. parsed-literal::

    Fraction(1, 3)



.. code:: python

    print(y)


.. parsed-literal::

    2/3


.. code:: python

    x + y




.. parsed-literal::

    Fraction(1, 1)



.. code:: python

    Fraction('.25')




.. parsed-literal::

    Fraction(1, 4)



.. code:: python

    a = 1 / 3.0 # only as accurate as floating-point hardware
    b = 4 / 6.0
    a, b




.. parsed-literal::

    (0.3333333333333333, 0.6666666666666666)



.. code:: python

    a + b




.. parsed-literal::

    1.0



.. code:: python

    0.1 + 0.1 + 0.1 - 0.3




.. parsed-literal::

    5.551115123125783e-17



.. code:: python

    from fractions import Fraction
    Fraction(1, 10) + Fraction(1, 10) + Fraction(1, 10) - Fraction(3, 10)




.. parsed-literal::

    Fraction(0, 1)



.. code:: python

    from decimal import Decimal
    Decimal('0.1') + Decimal('0.1') + Decimal('0.1') - Decimal('0.3')




.. parsed-literal::

    Decimal('0.0')



.. code:: python

    1 / 3.0




.. parsed-literal::

    0.3333333333333333



.. code:: python

    Fraction(1, 3)




.. parsed-literal::

    Fraction(1, 3)



.. code:: python

    import decimal
    decimal.getcontext().prec = 2
    Decimal(1) / Decimal(3)




.. parsed-literal::

    Decimal('0.33')



.. code:: python

    (1 / 3.0) + (6 / 12.0)




.. parsed-literal::

    0.8333333333333333



.. code:: python

    Fraction(6, 12)
    Fraction(1, 3)
    Fraction(1, 3) + Fraction(6, 12)




.. parsed-literal::

    Fraction(5, 6)



.. code:: python

    decimal.Decimal(str(1/3.0)) + decimal.Decimal(str(6/12.0))




.. parsed-literal::

    Decimal('0.83')



.. code:: python

    str(1/3.0)




.. parsed-literal::

    '0.333333333333'



.. code:: python

    1 / 3 # in Python 3.x
    # = 0.333333333333333314829616256247390992939472198486328125




.. parsed-literal::

    0.3333333333333333



.. code:: python

    str(1/3.0)




.. parsed-literal::

    '0.333333333333'



Fraction convertions
++++++++++++++++++++++++++++

.. code:: python

    (2.5).as_integer_ratio()




.. parsed-literal::

    (5, 2)



.. code:: python

    f = 2.5
    z = Fraction(*f.as_integer_ratio()) # convert float ->  fraction
    z




.. parsed-literal::

    Fraction(5, 2)



.. code:: python

    f.as_integer_ratio()




.. parsed-literal::

    (5, 2)



.. code:: python

    (1/3.0).as_integer_ratio()




.. parsed-literal::

    (6004799503160661L, 18014398509481984L)



.. code:: python

    x = Fraction(1, 3)
    float(x) # convert fraction -> float




.. parsed-literal::

    0.3333333333333333



.. code:: python

    Fraction.from_float(1.75) # convert float -> fraction




.. parsed-literal::

    Fraction(7, 4)



.. code:: python

    Fraction(*(1.75).as_integer_ratio())




.. parsed-literal::

    Fraction(7, 4)



.. code:: python

    x




.. parsed-literal::

    Fraction(1, 3)



.. code:: python

    x + 2




.. parsed-literal::

    Fraction(7, 3)



.. code:: python

    x + 2.0




.. parsed-literal::

    2.3333333333333335



.. code:: python

    x + (1./3)




.. parsed-literal::

    0.6666666666666666



.. code:: python

    x + Fraction(4, 3)




.. parsed-literal::

    Fraction(5, 3)



.. code:: python

    4.0 / 3




.. parsed-literal::

    1.3333333333333333



.. code:: python

    (4.0 / 3).as_integer_ratio()




.. parsed-literal::

    (6004799503160661L, 4503599627370496L)



.. code:: python

    x




.. parsed-literal::

    Fraction(1, 3)



.. code:: python

    a = x + Fraction(*(4.0 / 3).as_integer_ratio())
    a




.. parsed-literal::

    Fraction(22517998136852479, 13510798882111488)



.. code:: python

    22517998136852479 / 13510798882111488.




.. parsed-literal::

    1.6666666666666667



.. code:: python

    a.limit_denominator(10)




.. parsed-literal::

    Fraction(5, 3)



Sets basics in Python 2.6 and earlier
++++++++++++++++++++++++++++++++++++++++++++

.. code:: python

    y = set('abcgsdf')
    x = set('abcnbcx')
    x, y




.. parsed-literal::

    ({'a', 'b', 'c', 'n', 'x'}, {'a', 'b', 'c', 'd', 'f', 'g', 's'})



.. code:: python

    print(x) # Python <= 2.6 display format


.. parsed-literal::

    set(['a', 'x', 'c', 'b', 'n'])


.. code:: python

    x - y # difference




.. parsed-literal::

    {'n', 'x'}



.. code:: python

    x | y # union




.. parsed-literal::

    {'a', 'b', 'c', 'd', 'f', 'g', 'n', 's', 'x'}



.. code:: python

    x ^ y # xor




.. parsed-literal::

    {'d', 'f', 'g', 'n', 's', 'x'}



.. code:: python

    'e' in x




.. parsed-literal::

    False



.. code:: python

    z = x.intersection(y)
    print(z)


.. parsed-literal::

    set(['a', 'c', 'b'])


.. code:: python

    z.add('SPAM')
    print(z)


.. parsed-literal::

    set(['a', 'c', 'b', 'SPAM'])


.. code:: python

    z.update(['x', 'y'])
    print(z)


.. parsed-literal::

    set(['a', 'c', 'b', 'SPAM', 'y', 'x'])


.. code:: python

    z.remove('c')
    print(z)


.. parsed-literal::

    set(['a', 'b', 'SPAM', 'y', 'x'])


.. code:: python

    for item in set('abc'): print(item * 4)


.. parsed-literal::

    aaaa
    cccc
    bbbb


.. code:: python

    S = set([1, 2, 3])
    S | set([3, 4]) # union between sets




.. parsed-literal::

    {1, 2, 3, 4}



.. code:: python

    S | [3, 4] # require both to be sets


::


    ---------------------------------------------------------------------------

    TypeError                                 Traceback (most recent call last)

    <ipython-input-3-7e2ecfb4bd18> in <module>()
    ----> 1 S | [3, 4]
    

    TypeError: unsupported operand type(s) for |: 'set' and 'list'


.. code:: python

    S.union([3, 5]) # their methods allow any iterable




.. parsed-literal::

    {1, 2, 3, 5}



.. code:: python

    S.intersection((1,2,3,4,5))




.. parsed-literal::

    {1, 2, 3}



.. code:: python

    S.issubset(range(-5,6))




.. parsed-literal::

    True



Set literals in Python 3.x and 2.7
++++++++++++++++++++++++++++++++++++++++

.. code:: python

    S = set([1, 2, 3, 4]) # built-in
    print(S)


.. parsed-literal::

    set([1, 2, 3, 4])


.. code:: python

    S = {1, 2, 3, 4} # newer set literals
    print(S)


.. parsed-literal::

    set([1, 2, 3, 4])


.. code:: python

    S1 = {1, 2, 3, 4}
    S1 & {1, 3}




.. parsed-literal::

    {1, 3}



.. code:: python

    S1 > {1, 3}




.. parsed-literal::

    True



.. code:: python

    S = set({}) # init an empty set
    S.add(1.23)
    S




.. parsed-literal::

    {1.23}



.. code:: python

    {1, 2, 3} | {1}




.. parsed-literal::

    {1, 2, 3}



.. code:: python

    # only immutable objects work in a set
    S
    S.add([1,2])


::


    ---------------------------------------------------------------------------

    TypeError                                 Traceback (most recent call last)

    <ipython-input-20-077718e65280> in <module>()
          1 # only immutable objects work in a set
          2 S
    ----> 3 S.add([1,2])
    

    TypeError: unhashable type: 'list'


.. code:: python

    S.add({'a': 1}) # dict unhashable


::


    ---------------------------------------------------------------------------

    TypeError                                 Traceback (most recent call last)

    <ipython-input-21-908b7e066db8> in <module>()
    ----> 1 S.add({'a': 1})
    

    TypeError: unhashable type: 'dict'


.. code:: python

    S.add((1, 2, 3)) # tuple OK
    S




.. parsed-literal::

    {1.23, (1, 2, 3)}



.. code:: python

    (1, 2, 3) in S




.. parsed-literal::

    True



Set comprehensions in Python 3.X and 2.7
+++++++++++++++++++++++++++++++++++++++++++++

.. code:: python

    {x ** 2 for x in [1, 2, 6, 3]}




.. parsed-literal::

    {1, 4, 9, 36}



.. code:: python

    {x for x in 'spam'} # same as set('spam')




.. parsed-literal::

    {'a', 'm', 'p', 's'}



.. code:: python

    L = [1, 2, 3, 1, 7, 1 , 1, 2]
    set(L)




.. parsed-literal::

    {1, 2, 3, 7}



.. code:: python

    L = list(set(L)) # order may change
    L




.. parsed-literal::

    [1, 2, 3, 7]



.. code:: python

    set([1, 3, 5, 7]) - set([1, 2, 4, 5, 6])




.. parsed-literal::

    {3, 7}



.. code:: python

    set('abcgqwe') - set('asdvvwer')




.. parsed-literal::

    {'b', 'c', 'g', 'q'}



.. code:: python

    S = set(dir(bytes)) - set(dir(bytearray)) # in bytes but not in bytearray
    print(S)


.. parsed-literal::

    set(['__getslice__', 'format', '__mod__', '_formatter_field_name_split', 'encode', '__rmod__', '__getnewargs__', '_formatter_parser'])


.. code:: python

    S = set(dir(bytearray)) - set(dir(bytes))
    print(S)


.. parsed-literal::

    set(['insert', 'reverse', 'extend', '__delitem__', 'fromhex', '__setitem__', 'pop', '__iter__', '__iadd__', 'remove', 'append', '__alloc__', '__imul__'])


.. code:: python

    L1, L2 = [1, 3, 4, 5], [5, 3, 4, 1]
    L1 == L2




.. parsed-literal::

    False



.. code:: python

    set(L1) == set(L2)




.. parsed-literal::

    True



.. code:: python

    sorted(L1) == sorted(L2)




.. parsed-literal::

    True



.. code:: python

    'spam' == 'psam', set('spam') == set('asmp'), sorted('spam') == sorted('pmas')




.. parsed-literal::

    (False, True, True)



.. code:: python

    engineers = {'bob', 'sue', 'ann', 'vic'}
    managers = {'tom', 'sue'}

.. code:: python

    'bob' in engineers




.. parsed-literal::

    True



.. code:: python

    engineers & managers




.. parsed-literal::

    {'sue'}



.. code:: python

    engineers | managers




.. parsed-literal::

    {'ann', 'bob', 'sue', 'tom', 'vic'}



.. code:: python

    engineers - managers




.. parsed-literal::

    {'ann', 'bob', 'vic'}



.. code:: python

    engineers > managers




.. parsed-literal::

    False



.. code:: python

    (managers | engineers) - (managers ^ engineers) # intersection




.. parsed-literal::

    {'sue'}



Booleans
++++++++++++++++++

.. code:: python

    True + 4




.. parsed-literal::

    5



.. code:: python

    print(type(True))


.. parsed-literal::

    <type 'bool'>


.. code:: python

    isinstance(True, int)




.. parsed-literal::

    True



.. code:: python

    True == 1




.. parsed-literal::

    True



.. code:: python

    9 ** 0.5




.. parsed-literal::

    3.0



.. code:: python

    import math

.. code:: python

    math.sqrt(9)




.. parsed-literal::

    3.0



.. code:: python

    pow(3, 2)




.. parsed-literal::

    9



.. code:: python

    9 ** .5




.. parsed-literal::

    3.0



.. code:: python

    pow(3, 2)




.. parsed-literal::

    9



.. code:: python

    int(4.234) # truncate a float




.. parsed-literal::

    4



.. code:: python

    math.trunc(5.623)




.. parsed-literal::

    5



.. code:: python

    round(4.512312, 2)




.. parsed-literal::

    4.51



.. code:: python

    math.floor(4.7123 / 2)




.. parsed-literal::

    2.0



.. code:: python

    float(5) # convert int => float




.. parsed-literal::

    5.0



.. code:: python

    from __future__ import division
    5 / 1 # convert int => float for Python 3.X




.. parsed-literal::

    5.0



.. code:: python

    '%.2f' % (2.5123) # format a float with the % formatting expression




.. parsed-literal::

    '2.51'



.. code:: python

    '%x' % (255) # convert an int to hex with % formatting expression




.. parsed-literal::

    'ff'



.. code:: python

    '{0:.2f}'.format(2.3423) # format a float with string format method




.. parsed-literal::

    '2.34'



.. code:: python

    '%o, %x, %X' % (64, 64, 64)




.. parsed-literal::

    '100, 40, 40'



.. code:: python

    '{:o}, {:x}, {:b}'.format(64, 64, 64)




.. parsed-literal::

    '100, 40, 1000000'



.. code:: python

    '{0:o}, {1:x}, {2:b}'.format(64, 64, 64)




.. parsed-literal::

    '100, 40, 1000000'



.. code:: python

    int('FF', 16) # convert an hex => int




.. parsed-literal::

    255



.. code:: python

    int('1011', 2) # convert a binary => int




.. parsed-literal::

    11



.. code:: python

    int('0o100', 8) # convert oct => int




.. parsed-literal::

    64



.. code:: python

    int('10000', 2)




.. parsed-literal::

    16



.. code:: python

    eval('0o100')




.. parsed-literal::

    64



Variables, Objects, References
-------------------------------------

.. code:: python

    L1 = [2, 4, 6]
    L2 = L1[:] # copy the list to L2
    L2




.. parsed-literal::

    [2, 4, 6]



.. code:: python

    L2 = list(L1) # make a copy using constructor
    L2




.. parsed-literal::

    [2, 4, 6]



.. code:: python

    import copy
    L2 = copy.copy(L1) # make a copy using the module copy
    L2




.. parsed-literal::

    [2, 4, 6]



.. code:: python

    L2 = copy.deepcopy(L1) # make a deep copy
    L2




.. parsed-literal::

    [2, 4, 6]



.. code:: python

    import sys
    sys.getrefcount(1) # reference count for an object




.. parsed-literal::

    1360



Strings
----------------------

.. code:: python

    r'\temp\spam' # raw strings




.. parsed-literal::

    '\\temp\\spam'



.. code:: python

    print('s\np\ta\x00m') # escape sequence


.. parsed-literal::

    s
    p	a m


.. code:: python

    b = b'sp\xc4m'
    b




.. parsed-literal::

    'sp\xc4m'



.. code:: python

    print(u'sp\u00c4m')


.. parsed-literal::

    spÄm


.. code:: python

    type(b'sp\xc4m')




.. parsed-literal::

    str



.. code:: python

    title = 'this' ' is' " a test"
    title




.. parsed-literal::

    'this is a test'



.. code:: python

    s = 'a\0b\0c' # \0 Null:binary 0 character
    s




.. parsed-literal::

    'a\x00b\x00c'



.. code:: python

    len(s)




.. parsed-literal::

    5



.. code:: python

    s = '\001\002\x03'
    s # python display nonprintable chars in hex




.. parsed-literal::

    '\x01\x02\x03'



.. code:: python

    x = 'C:\pasd\qwe'
    x




.. parsed-literal::

    'C:\\pasd\\qwe'



.. code:: python

    x = '\0'
    x




.. parsed-literal::

    '\x00'



.. code:: python

    print(x)


.. parsed-literal::

     


.. code:: python

    len(x)




.. parsed-literal::

    1



Raw Strings
+++++++++++++++++++++

.. code:: python

    # raw strings
    # r turn off the escape mechanism
    myfile = open(r'\home\pi\script.php', 'w')
    myfile




.. parsed-literal::

    <open file '\\home\\pi\\script.php', mode 'w' at 0xf56650>



.. code:: python

    path = r'C:\nsd\twe.dat'
    path




.. parsed-literal::

    'C:\\nsd\\twe.dat'



.. code:: python

    print(path)


.. parsed-literal::

    C:\nsd\twe.dat


.. code:: python

    r'...\' # a raw string cannot end with a backslash


::


      File "<ipython-input-50-3a2c1f40ff86>", line 1
        r'...\'
              ^
    SyntaxError: EOL while scanning string literal



.. code:: python

    r = r'...\\'[:-1] # if u want to end a string with a backslash
    print(r)


.. parsed-literal::

    ...\


.. code:: python

    len('abc')




.. parsed-literal::

    3



.. code:: python

    'abc' + 'def'




.. parsed-literal::

    'abcdef'



.. code:: python

    'Ni!' * 4




.. parsed-literal::

    'Ni!Ni!Ni!Ni!'



.. code:: python

    print('-' * 50)


.. parsed-literal::

    --------------------------------------------------


.. code:: python

    myjob = 'hacker'
    for c in myjob: print c


.. parsed-literal::

    h
    a
    c
    k
    e
    r


.. code:: python

    "k" in myjob




.. parsed-literal::

    True



.. code:: python

    'spam' in 'acasdqwqwe'




.. parsed-literal::

    False



Indexing and slicing
+++++++++++++++++++++++++++++

.. code:: python

    S = 'spam'
    S[0], S[-2]




.. parsed-literal::

    ('s', 'a')



.. code:: python

    S[:], S[1:3]




.. parsed-literal::

    ('spam', 'pa')



.. code:: python

    S[-2], S[len(S)-2]




.. parsed-literal::

    ('a', 'a')



.. code:: python

    S[::-1], S[::2] # stride




.. parsed-literal::

    ('maps', 'sa')



.. code:: python

    'spam'[1:3]




.. parsed-literal::

    'pa'



.. code:: python

    'spam'[slice(1, 3)]




.. parsed-literal::

    'pa'



.. code:: python

    'spam'[::-1], 'spam'[slice(None, None, -1)]




.. parsed-literal::

    ('maps', 'maps')



.. code:: python

    import sys
    print(sys.argv) # argv -- command line arguments


.. parsed-literal::

    ['/home/pi/python_example/ipython/lib/python2.7/site-packages/ipykernel/__main__.py', '-f', '/home/pi/.local/share/jupyter/runtime/kernel-f18712dd-c818-40e4-a909-e4d4fb9148e1.json']


.. code:: python

    sys.argv[1:]




.. parsed-literal::

    ['-f',
     '/home/pi/.local/share/jupyter/runtime/kernel-f18712dd-c818-40e4-a909-e4d4fb9148e1.json']



String Convertion Tools
+++++++++++++++++++++++++++++++

.. code:: python

    repr(43)




.. parsed-literal::

    '43'



.. code:: python

    str(32)




.. parsed-literal::

    '32'



.. code:: python

    print str('spam'), repr('spam')


.. parsed-literal::

    spam 'spam'


.. code:: python

    print(str('spam'), repr('spam')) # Raw interactive echo display


.. parsed-literal::

    ('spam', "'spam'")


.. code:: python

    str(3.123)




.. parsed-literal::

    '3.123'



.. code:: python

    ord('A') # str => integer code




.. parsed-literal::

    65



.. code:: python

    chr(65) # integer code => str




.. parsed-literal::

    'A'



.. code:: python

    ord('0')




.. parsed-literal::

    48



.. code:: python

    ord('5') - ord('0')




.. parsed-literal::

    5



.. code:: python

    B = '1101'
    I = 0
    while B != '':
        I = I * 2 + (ord(B[0]) - ord('0'))
        print B[0], I
        B = B[1:]
    I


.. parsed-literal::

    1 1
    1 3
    0 6
    1 13




.. parsed-literal::

    13



.. code:: python

    s = 4
    s << 1




.. parsed-literal::

    8



.. code:: python

    '{0:.3f}'.format(5.561)




.. parsed-literal::

    '5.561'



String Method: Changing String
+++++++++++++++++++++++++++++++++++++

.. code:: python

    S = 'xxxSPAMxxxSPAMxxx'
    where = S.find('SPAM')
    where




.. parsed-literal::

    3



.. code:: python

    S = S[:where] + 'EGGS' + S[(where+4):]
    S




.. parsed-literal::

    'xxxEGGSxxxSPAMxxx'



.. code:: python

    S = 'xxxSPAMxxxSPAMxxx'
    S.replace('SPAM', 'EGGS', 1) # replace one




.. parsed-literal::

    'xxxEGGSxxxSPAMxxx'



.. code:: python

    S = 'spammy'
    L = list(S)
    L




.. parsed-literal::

    ['s', 'p', 'a', 'm', 'm', 'y']



.. code:: python

    L[4] = 'x'
    L




.. parsed-literal::

    ['s', 'p', 'a', 'm', 'x', 'y']



.. code:: python

    S = ''.join(L)
    S




.. parsed-literal::

    'spamxy'



.. code:: python

    'SPAM'.join(['eggs', 'sausage', 'hamn'])




.. parsed-literal::

    'eggsSPAMsausageSPAMhamn'



Parsing Text
+++++++++++++++++++++++++++

.. code:: python

    line = 'aaa bbb ccc'
    col1 = line[0:3]
    col2 = line[8:]
    col1




.. parsed-literal::

    'aaa'



.. code:: python

    col2




.. parsed-literal::

    'ccc'



.. code:: python

    cols = line.split()
    cols




.. parsed-literal::

    ['aaa', 'bbb', 'ccc']



.. code:: python

    line = 'Aqwe gsdf EGHSDv sdvsd\n'
    line.rstrip()




.. parsed-literal::

    'Aqwe gsdf EGHSDv sdvsd'



.. code:: python

    line.upper()




.. parsed-literal::

    'AQWE GSDF EGHSDV SDVSD\n'



.. code:: python

    line.endswith('d\n')




.. parsed-literal::

    True



.. code:: python

    line.startswith('QWE')




.. parsed-literal::

    False



.. code:: python

    line.find('sdv') != -1




.. parsed-literal::

    True



.. code:: python

    'sdv' in line




.. parsed-literal::

    True



.. code:: python

    sub = 'd\n'
    line.endswith(sub)




.. parsed-literal::

    True



.. code:: python

    line[-len(sub):] == sub




.. parsed-literal::

    True



.. code:: python

    # the old module string
    import string

.. code:: python

    S = 'a+b+c'
    y = string.replace(S, '+', 'spam')
    y




.. parsed-literal::

    'aspambspamc'



Formatting Expression Basics
+++++++++++++++++++++++++++++++++++++++

.. code:: python

    'That is %d %s bird' % (1, 'dead')




.. parsed-literal::

    'That is 1 dead bird'



.. code:: python

    # string substitution
    s = 'asd'
    'ciao %s!' % s




.. parsed-literal::

    'ciao asd!'



.. code:: python

    '%d %s %g' % (1, 'spam', 4.0)




.. parsed-literal::

    '1 spam 4'



.. code:: python

    '%s -- %s -- %s' % (42, 3.123, [1, 2, 3]) # all types match a %s target




.. parsed-literal::

    '42 -- 3.123 -- [1, 2, 3]'



Advance Formatting
++++++++++++++++++++++++++++++

.. code:: python

    x = 1234
    res = 'integer: ...%d...%-6d...%06d' % (x, x, x)
    res




.. parsed-literal::

    'integer: ...1234...1234  ...001234'



.. code:: python

    x = 1.234156451
    x




.. parsed-literal::

    1.234156451



.. code:: python

    '%e | %f | %.2f | %g' % (x ,x, x, x)




.. parsed-literal::

    '1.234156e+00 | 1.234156 | 1.23 | 1.23416'



.. code:: python

    '%E' % x




.. parsed-literal::

    '1.234156E+00'



.. code:: python

    '%g' % 123.123198765432 # default precision of 6 digits




.. parsed-literal::

    '123.123'



.. code:: python

    '%-6.2f | %05.2f | %+06.1f | %-06.1f' % (x, x, x, x)




.. parsed-literal::

    '1.23   | 01.23 | +001.2 | 1.2   '



.. code:: python

    '%s' % x, str(x)




.. parsed-literal::

    ('1.234156451', '1.234156451')



.. code:: python

    # if sizes are not know until runtime use *
    '%f, %.2f, %.*f' % (1/3.0, 1/3.0, 4, 1/3.0)




.. parsed-literal::

    '0.333333, 0.33, 0.3333'



Dictionary based formatting exp
+++++++++++++++++++++++++++++++++++++++++

.. code:: python

    '%(qty)d more %(food)s' % {'qty': 2, 'food': 'gnocchi'}




.. parsed-literal::

    '2 more gnocchi'



.. code:: python

    reply = """
    Ciao!
    Hello %(name)s!
    Your age is %(age)s
    """
    values = {'name': 'Emanuele', 'age': '25'}
    print(reply % values)


.. parsed-literal::

    
    Ciao!
    Hello Emanuele!
    Your age is 25
    


.. code:: python

    qty = 10
    food = 'gnocchi'
    '%(qty)d more %(food)s' % vars()




.. parsed-literal::

    '10 more gnocchi'



.. code:: python

    '%o, %x, %x, %X' % (64, 64, 255, 64)




.. parsed-literal::

    '100, 40, ff, 40'



String formatting Method Calls
++++++++++++++++++++++++++++++++++++++++

.. code:: python

    template = '{0}, {1} and {2}'.format('a', 'b', 'c') # by position
    template




.. parsed-literal::

    'a, b and c'



.. code:: python

    templ = '{motto} {0} and {pork}' # by keywords and position
    templ.format('ham', motto='pasta', pork='porco')




.. parsed-literal::

    'pasta ham and porco'



.. code:: python

    templ = '{} {} {}' # be relative pos
    templ.format('123', 'cioao', 'gdfg')




.. parsed-literal::

    '123 cioao gdfg'



.. code:: python

    template = '%(motto)s, %(pork)s and %(food)s'
    template % dict(motto='asd', pork='123', food='876')





.. parsed-literal::

    'asd, 123 and 876'



.. code:: python

    X = '{motto} {0} and {food}'.format(42, motto=3.14, food=[1, 2])
    X




.. parsed-literal::

    '3.14 42 and [1, 2]'



.. code:: python

    X.split(' and ')




.. parsed-literal::

    ['3.14 42', '[1, 2]']



.. code:: python

    import sys

.. code:: python

    'My {1[kind]} runs {0.platform}'.format(sys, {'kind': 'laptop'})




.. parsed-literal::

    'My laptop runs linux2'



.. code:: python

    'My {map[kind]} runs {sys.platform}'.format(sys=sys, map={'kind': 'laptop'})




.. parsed-literal::

    'My laptop runs linux2'



.. code:: python

    somelist = list('SPAM')
    somelist




.. parsed-literal::

    ['S', 'P', 'A', 'M']



.. code:: python

    'first={0[0]}, third={0[2]}'.format(somelist) # only positive offset work




.. parsed-literal::

    'first=S, third=A'



.. code:: python

    'first={0}, last={1}'.format(somelist[0], somelist[-1])




.. parsed-literal::

    'first=S, last=M'



.. code:: python

    parts = (somelist[0], somelist[1:3], somelist[-1])
    'first={0}, middle={1}, last={2}'.format(*parts)




.. parsed-literal::

    "first=S, middle=['P', 'A'], last=M"



Advanced formatting method syntax
++++++++++++++++++++++++++++++++++++++

.. code:: python

    '{0[kind]!s}'.format(dict(kind='test'))




.. parsed-literal::

    'test'



.. code:: python

    '{0[kind]!s}'.format(dict(kind=1.12312)) # is like calling str




.. parsed-literal::

    '1.12312'



.. code:: python

    '{0[kind]!r}'.format(dict(kind='test')) # is like calling repr




.. parsed-literal::

    "'test'"



.. code:: python

    '{0[kind]:<,}'.format(dict(kind=12425612341))




.. parsed-literal::

    '12,425,612,341'



.. code:: python

    '{0[kind]:<10,.4}'.format(dict(kind=3.12312341))




.. parsed-literal::

    '3.123     '



.. code:: python

    '{0:10} = {1:10}'.format('spam', 123.456)




.. parsed-literal::

    'spam       =    123.456'



.. code:: python

    '{0:>10} = {1:<10}'.format('spam', 123.3467)




.. parsed-literal::

    '      spam = 123.3467  '



.. code:: python

    '{0.platform:>10} = {1[kind]:<10}'.format(sys, dict(kind='porco'))




.. parsed-literal::

    '    linux2 = porco     '



.. code:: python

    # a less explicit way to format with method call
    '{:10} = {:10}'.format('spamspam', 123.45678)




.. parsed-literal::

    'spamspam   =  123.45678'



.. code:: python

    '{.platform:>10} = {[kind]:<10}'.format(sys, dict(kind='porco'))




.. parsed-literal::

    '    linux2 = porco     '



.. code:: python

    '{0:e}, {1:.3e}, {2:g}'.format(3.123512, 3.123512, 3.123512)




.. parsed-literal::

    '3.123512e+00, 3.124e+00, 3.12351'



.. code:: python

    '{0:f}, {1:.2f}, {2:06.2f}'.format(3.123512, 3.123512, 3.123512)




.. parsed-literal::

    '3.123512, 3.12, 003.12'



.. code:: python

    '{0:X} {1:o} {2:b}'.format(255, 255, 255)




.. parsed-literal::

    'FF 377 11111111'



.. code:: python

    bin(255), int('11111111', 2), 0b11111111 # binary from/to




.. parsed-literal::

    ('0b11111111', 255, 255)



.. code:: python

    hex(255), int('FF', 16), 0xFF # from/to hex




.. parsed-literal::

    ('0xff', 255, 255)



.. code:: python

    oct(255), int('377', 8), 0o377 # from/to octal




.. parsed-literal::

    ('0377', 255, 255)



.. code:: python

    '{0:.{1}f}'.format(2.124356, 3) # take parameter from arguments




.. parsed-literal::

    '2.124'



.. code:: python

    '%.*f' % (3, 1 / 3.0)




.. parsed-literal::

    '0.333'



.. code:: python

    '%s %s %s' % (3.14159, 42, [1, 2])




.. parsed-literal::

    '3.14159 42 [1, 2]'



.. code:: python

    'My %(kind)s runs %(platform)s' % {'kind': 'computer', 'platform': sys.platform}




.. parsed-literal::

    'My computer runs linux2'



.. code:: python

    '%(test)s' % dict(test='this is a test')




.. parsed-literal::

    'this is a test'



.. code:: python

    '%-10s = %10s' % ('spam', 123.4567)




.. parsed-literal::

    'spam       =   123.4567'



.. code:: python

    '%e, %.3e, %g' % (3.235123, 12.34231, 2.423412)




.. parsed-literal::

    '3.235123e+00, 1.234e+01, 2.42341'



.. code:: python

    '%f, %.3f, %06.2f' % (3.14156, 3.14156, 3.14156)




.. parsed-literal::

    '3.141560, 3.142, 003.14'



.. code:: python

    '%x, %o' % (255, 255) # there is not binary




.. parsed-literal::

    'ff, 377'



.. code:: python

    '{1[kind]:<8}   {0.platform:>8}'.format(sys, {'kind':'laptop'})




.. parsed-literal::

    'laptop       linux2'



.. code:: python

    '%(kind)-8s   %(plat)8s' % dict(kind='laptop', plat=sys.platform)




.. parsed-literal::

    'laptop       linux2'



.. code:: python

    data = dict(platform=sys.platform, kind='laptop')
    '{kind:<8} {platform:>8}'.format(**data)




.. parsed-literal::

    'laptop     linux2'



.. code:: python

    '%(kind)-8s  %(platform)8s' % data




.. parsed-literal::

    'laptop      linux2'



.. code:: python

    '{0:,d}'.format(999999999999999) # thousand separator




.. parsed-literal::

    '999,999,999,999,999'



