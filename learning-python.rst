
===============
Learning Python
===============

.. code:: python

    'ciao'




.. parsed-literal::

    'ciao'



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


