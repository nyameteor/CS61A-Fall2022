---
title: Higher-Order Functions
---

## Higher-Order Functions

- Textbook: http://composingprograms.com/pages/16-higher-order-functions.html

Higher-order function: A function that takes a function as an argument value or returns a function as a return value.

E.g., Generalizing for computing the area of shape.

```python
"""Generalization."""
from math import pi, sqrt

def area(r, shape_constant):
    assert r > 0, 'A length must be positive'
    return r * r * shape_constant

def area_square(r):
    return area(r, 1)

def area_circle(r):
    return area(r, pi)

def area_hexagon(r):
    return area(r, 3 * sqrt(3) / 2)
```

E.g., Generalizing for computing summations.

```python
"""Generalization"""

def identity(k):
    return k

def cube(k):
    return pow(k, 3)

def pi_term(k):
    return 8 / (4 * k - 3) * (4 * k - 1)

def summation(n, term):
    """Sum the first N terms of sequence.

    >>> summation(5, cube)
    225
    """
    total, k = 0, 1
    while k <= n:
        total, k = total + term(k), k + 1
    return total

def sum_naturals(n):
    """Sum the first N natural numbers.

    >>> sum_naturals(5)
    15
    """
    return summation(n, identity)

def sum_naturals(n):
    """Sum the first N cubes of natural numbers.

    >>> sum_naturals(5)
    225
    """
    return summation(n, cube)

def pi_sum(n):
    """Computes the sum of terms which converages to pi.
    """
    return summation(n, pi_term)
```

### Environments for Nested Definitions

```python
def make_adder(n):
    def adder(k):
        return k + n
    return adder

add_three = make_adder(3)
add_three(4)
```

When we call `add_three(4)`, the environment diagram looks like this:

```text
Global frame
        make_adder : ---------------> func make_adder(n) [parent=Global]
        add_three  : ---------------> func adder(k) [parent=f1]
                                         ^  ^
                                         |  |
f1: make_adder [parent=Global]           |  |
                 n : 3                  /   |
             adder : ------------------    /
      return value : ---------------------


f2: adder      [parent=f1]
                 k : 4
      return value : 7
```

### Lambda Expressions

Lambda expressions evaluate to unnamed functions.

The structure of a lambda expression is:

```text
    lambda              x           :           x * x
"a function that    takes x    and returns      x * x"
```

We can create function values on the fly using lambda expressions.

E.g, We can bind a name to the funcion value, so that we can refer to it later:

```python
>>> square = lambda x: x * x
>>> square(10)
100
```

Or we can apply a function straight away in a call expression:

```python
>>> (lambda x: x * x)(10)
100
```

A practical case, create function value and take it as argument:

```python
def compose1(f, g):
    return lambda x: f(g(x))

f = compose1(lambda x : x * x,
             lambda y : y + 1)
result = f(12)
```

Note that lambda expressions always create simple functions that only evaluate a single expression, it cannot contain statements at all.

### Function Currying

Currying: Transforming a multi-argument function into a single-argument, higher-order function.

```python
>>> from operator import add
>>> curry2 = lambda f: lambda x: lambda y: f(x, y)
>>> m = curry2(add)
>>> m(2)(3)
5
```

### Function Decorators

Function decorators are a feature of Python that utilizes higher-order functions.

```python
def trace(fn):
    """Returns a version of fn that first prints before it is called."""
    def traced(*args):
        print('Calling', fn, 'on arguments', *args)
        return fn(*args)
    return traced

@trace
def triple(x):
    return 3 * x

# is identical to

def triple(x):
    return 3 * x
triple = trace(triple)
```

### Return Statements

A return statement completes the evaluation of a call expression and provides its value.

When we evaluating `f(x)`:

- switch to a new environments.
- execute `f`'s body.

  After execute `return` statement within `f`:

  switch back to the previous environment, `f(x)` now has a value.

E.g., we can define a function `inverse`:

```python
def search(f):
    """Search for x until f(x) is True."""
    x = 0
    while not f(x):
        x += 1
    return x

def inverse(f):
    """Return g(y) such that g(f(x)) -> x."""
    return lambda y: search(lambda x: f(x) == y)

def square(x):
    return x * x
```

And then we can implement a square root function:

```python
>>> sqrt = inverse(square)
>>> square(16)
256
>>> sqrt(256)
16
>>> sqrt(2)
[Infinite Loop]
```

It's just a very simple implementation of `sqrt` function, and only works for perfect square.
For a better version please see Newton's method section of the textbook.

## Functional Abstraction

Functional abstraction is giving a name to some computational process,
and then referring to that process without worrying about its implementation details.

Some Naming Tips:

- Names can be long if they help document your code:

  `average_age = average(age, students)`

- Names can be short if they represent generic quantities:
  counts, arbitray functions, arguments to mathmetical operations, etc.

  - `n, k, i` - Usually integers
  - `x, y, z` - Usually real numbers
  - `f, g, h` - Usually functions

## Midterm 1 Review

[video](https://www.youtube.com/watch?v=guc-Q1x2vAY)

```python
from operator import add, mul
def square(x):
    return mul(x, x)

def delay(arg):
    print('delayed')
    def g():
        return arg
    return g

def pirate(arg):
    print('matey')
    def plunder(arg):
        return arg
    return plunder
```

What Would Python Print?

```text
This expression                                     Evaluates to            Interactive Output

delay(delay)( )(6)( )
-----------------  -
--------------- -
------------ -
----- -----
func delay.<locals>.g()                                                     delayed
------------ -
func delay(arg)
--------------- -
func delay.<locals>.g()                                                     delayed
-----------------  -
         6                                          6                       6
---------------------


add(pirate(3)(square)(4), 1)
--- -------------------   -
    ----------------- -
    --------  ------
    ------ -
func pirate.<locals>.plunder(arg)                                           Matey
    --------  ------
    func square(x)
    ----------------- -
            16
    -------------------   -
            17                                      17                      17
-----------------------------

```

Note: above demo can not show the environments clearly enough, please consider to draw environment diagrams instead.

```python
def horse(mask):
    horse = mask
    def mask(horse):
        return horse
    return horse(mask)

mask = lambda horse : horse(2)

horse(mask)
```

Todo: try to evaluate this expression by drawing environment diagrams.
