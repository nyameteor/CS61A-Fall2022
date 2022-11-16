# Week 1

## About The Course

A Course about managing complexity:

- Matering abstraction
- Programming paradigms

An introduction to programming:

- Full understanding of Python fundamentals
- Combining multiple ideas in large projects
- How computers interpret programming languages

Different types of languages:

- Scheme & SQL

## Elements of Programming

TextBook: http://composingprograms.com/pages/12-elements-of-programming.html

### Expressions

An expression describes a computation and evaluates to a value.

### Call Expression

All expressions can use function call notation.

```python
>>> from operator import add, mul
>>> mul(add(2, mul(4, 6)), add(3, 5))
208
```

### Anatomy of a Call Expression

```text
    add     (      2      ,       3     )
     |             |              |
  Operator      Operand        Operand
```

To evaluate nested expressions, we can use an `expression tree` to visualize the evaluation procedures.

### Pure and Non-pure Functions

**Pure functions** (just return values)

functions have some input and return some output.

E.g., `abs` is a pure function.

```python
>>> abs(-2)
2
```

**Non-pure functions** (have side effects)

In addition to returning a value, applying a non-pure function can generate side effects, which make some change to the state of the interpreter.

E.g., `print` function is a non-pure function, beyond the return value `None`, the side effect is to generate additional ouput.

```python
>>> print(1, 2, 3)
1 2 3
```

A nested expression of calls to print highlights the non-pure character of the function.

```python
>>> print(print(1), print(2))
1
2
None None
```

We can draw an expression tree to visualize:

```text
                    None
           print(print(1), print(2))
           /       |          \
          /        |           \
         /         |            \
  `print(...)`   None           None
          `print(...)` `1`  `print(...)` `2`
```

1. Evaluates the operator `function print`.
2. Evaluates the first operand, which is another call expression:
   1. Evaluates the operator `function print`.
   2. Evaluates the operand `1`.
   3. Apply operand to operator, it display `1` and return `None`.
3. Evaluates the second operand, which is another call expression:
   1. Evaluates the operator `function print`.
   2. Evaluates the operand `2`.
   3. Apply operand to operator, it display `2` and return `None`.
4. Apply operands to operator, it display `None None` and return `None`.
