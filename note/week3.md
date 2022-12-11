# Week3

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

### Functional Abstraction

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

### Midterm 1 Review

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
