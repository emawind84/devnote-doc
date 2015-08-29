
===============
Learning Python
===============

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
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code:: python

    value = D.get('x', 0)
    value




.. parsed-literal::

    0



if/else expression form
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

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
^^^^^^^^^

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
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

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
^^^^^^^^^^^^^^^^^^^^^

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







===================
Numeric Literals
===================

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
---------------------------------------

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
-------------------------------------

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
---------------------------

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



Hex, Octal, Binary
----------------------------

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



