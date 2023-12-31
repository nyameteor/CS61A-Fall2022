---
title: Mutability
---

Textbook:

- http://composingprograms.com/pages/23-sequences.html
- http://composingprograms.com/pages/24-mutable-data.html

## Mutability

### Objects

- Objects represent information.
- Objects consist of data and behavior, bundled together to create abstractions.
- Objects can represent things, but also properties, interactions, & processes.

Excample: Strings

ASCII

```python
>>> a = 'A'
>>> ord(a)
65
>>> hex(ord(a))
'0x41'
```

Unicode

```python
>>> from unicodedata import name, lookup
>>> name('A')
'LATIN CAPITAL LETTER A'
>>> lookup('WHITE SMILING FACE')
'☺'
>>> lookup('SNOWMAN')
'☃'
>>> lookup('SNOWMAN').encode()
b'\xe2\x98\x83'
```

### Mutation

All names that refer to same object are affected by a mutation.

Identity Operators:

Identity

`<exp0> is <exp1>`

Evalueats to `True` if <exp0> and <exp1> evaluates to the same object.

```python
>>> a = [10]
>>> b = a
>>> a is b
True
>>> a == b
True
```

Equality

`<exp0> == <exp1>`

Evalueats to `True` if <exp0> and <exp1> evaluates to equal values.

```python
>>> [10] == [10]
True
>>> a = [10]
>>> b = [10]
>>> a == b
True
>>> a is b
False
```

Mutable default arguments are **dangerous** in Python.

A default argument value is part of a function value, not generated by a call.

```python
>>> def f(s=[]):
...     s.append(5)
...     return len(s)
...
>>> f()
1
>>> f()
2
>>> f()
3
```

### Mutable Functions

Let's model a bank account that has a balance of $100.

```python
>>> withdraw = make_withdraw_list(100)
>>> withdraw(25)
75
>>> withdraw(25)
50
>>> withdraw(60)
'Insufficient funds'
>>> withdraw(15)
35
```

**Mutable Values & Persistent Local State**

```python
def make_withdraw_list(balance):
    """Return a withdraw function that draws down balance with each call."""
    b = [balance]                        # Name bound outside of withdraw function
    def withdraw(amount):
        if amount > b[0]:
            return 'Insufficient funds'
        b[0] = b[0] - amount             # Element assignment changes a list
        return b[0]
    return withdraw
```

Function `withdraw` doesn't change what `b` are bound to, instead, it changes the value of `b` itself.

As a result, we used the mutable value to create a mutable function.

Another implementation from textbook:

```python
def make_withdraw(balance):
    """Return a withdraw function that draws down balance with each call."""
    def withdraw(amount):
        nonlocal balance                 # Declare the name "balance" nonlocal
        if amount > balance:
            return 'Insufficient funds'
        balance = balance - amount       # Re-bind the existing balance name
        return balance
    return withdraw
```

The `nonlocal` statement declares that whenever we change the binding of the name `balance`, the binding is changed in the frame in which `balance` is already bound.

### Tuples

Tuples are immutable sequences.

```python
>>> {(1, 2): 3}
{(1, 2): 3}
```

An immutable sequence may still change if it contains a mutable value as an element.

```python
>>> s = ([1, 2], 3)
>>> s[0][0] = 4
>>> s
([4, 2], 3)
```
