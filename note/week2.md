# Week2

## Defining New Functions

- TextBook: http://composingprograms.com/pages/13-defining-new-functions.html
- Online visualizer: https://pythontutor.com/cp/composingprograms.html#mode=edit

### Life Cycle of a User-Defined Function

**Def statement**:

```text
    `Name`  `Formal parameter`
       \      /
  def square( x )
      return mul(x, x)
                 |
         `Return expression`
```

**Call expression**:

```text
         `Operand: 2+2`
         `Argument: 4`
             |
   square (2 + 2)
     |
 `Operator name: square`
 `Operator value: function square(x)`
```

### Environment Diagrams

Code:

```text
-> 1    from math import pi
-> 2    ttau = 2 * pi
```

- Statements and expressions
- Arrows indicate evaluation order

Frames:

```text
 `Global frame`
 name   value
  pi  | 3.1416
```

- Each name is bound to a value
- Within a frame, a name cannot be repeated

### Looking Up Names In Environments

Every expression is evaluated in a context of environment.

```python
>>> from operator import mul
>>> def square(x):
...     return mul(x, x)
...
>>> square(-2)
4
```

**An environment is a sequence of frames.**

We start from global frame, and when we apply a function, we will create a new frame.

**A name evaluates to the value bound to that name in the earliest frame of the current environment in which that name is found.**

E.g., to look up some name in the body of the `square` function:

- Lookup for that name in the local frame.
- If not found, look for it in the global frame.

Now we can understand how these statements works:

```python
>>> from operator import mul
>>> def square(square):
...     return mul(square, square)
...
>>> square(-2)
4
```

Name `square` have different meanings in local and global environment.
In local frame, `square` bounds to `-2`, while in global frame, `square` bounds to `func square(x)`.

## Control

TextBook: http://composingprograms.com/pages/15-control.html

### Statements

We have seen some kinds of statements already:

- assignment
- `def`
- `return`

These lines of Python code are not themeselves expressions, although they all contain expressions as components.

**Statements are `executed`.**

Each statement describes some change to the interpreter state, and executing a statement applies that change.

**Expressions are `evaluated`.**

Expressions also can be executed as statements, in which case they are evaluated, but their value is discarded.

### Compound Statements

In general, Python code is a sequence of statements.

A compound statement looks like these:

```text
<header>:
  <statement>
  <statement>
  ...
<seperating header>:
  <statement>
  <statement>
  ...
```

- `header`: identifies the type of compound statement.
- `suite`: a sequence of statements follow the header.
- `clauses`: a header and an indented suite of statements.

E.g., Conditional Statements:

```text
if <expression>:
  <suite>
elif <expression>:
  <suite>
else:
  <suite>
```

E.g., While Statements:

```text
while <expression>:
  <suite>
```

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
