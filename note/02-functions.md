---
title: Functions
---

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
