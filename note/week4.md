# Week4

textbook: http://composingprograms.com/pages/17-recursive-functions.html

## Self-Reference

A function can refer to its own name.

```python
def print_all(x):
    print(x)
    return print_all

>>> print_all(1)(3)(5)
1
3
5

def print_sums(x):
    print(x)
    def next_sum(y):
        return print_sums(x+y)
    return next_sum

>>> print_sums(1)(3)(5)
1
4
9
```

Here is a simple environment diagram when evaluating `print_sums(1)(3)(5)`:

```text
Frames                                  Objects

Global frame
        print_sums : ------------------> func print_sums(x)  [parent=Global]


f1: print_sums [parent=Global]
                 x : 1
          next_sum : ------------------> func next_sum(y) [parent=f1]
      return value : --------------------^


f2: next_sum [parent=f1]
                 y : 3
      return value : ------------------
                                        \
                                         |
f3: print_sums [parent=Global]           |
                 x : 4                   V
          next_sum : ------------------> func next_sum(y) [parent=f3]
      return value : --------------------^


f4: next_sum [parent=f3]
                 y : 5
      return value : ------------------
                                        \
                                         |
f5: print_sums [parent=Global]           |
                 x : 9                   V
          next_sum : ------------------> func next_sum(y) [parent=f5]
      return value : --------------------^
```

## Recursive Functions

Definition: A function is called recursive if the body of that function calls itself, either directly or indirectly.

E.g., sum digits:

```python
def split(n):
    return n // 10, n % 10

def sum_digits(n):
    if n < 10:
        return n
    else:
        all_but_last, last = split(n)
        return sum_digits(all_but_last) + last
```

E.g., factorial:

```python
def fact(n):
    if n == 0:
        return 1
    else:
        return n * fact(n-1)
```

and iteration version:

```python
def fact_iter(n):
    total, k = 1, 1
    while k <= n:
        total, k = total * k, k+1
    return total
```

With recursion in math:

$$
n! =
    \begin{cases}
    1       & \quad \text{if } n = 0 \\
    n(n-1)! & \quad \text{otherwise}
    \end{cases}
$$

With iteration in math:

$$
n! = \prod_{i=1}^{n}i
$$

Converting Recursion to Iteration

Idea: Figure out what state must be maintained by the iterative function.

Converting Iteration to Recursion

Idea: The state of an iteration can be passed as arguments.

## Mutual Recursion

### The Luhn Alogrithms

wikipedia: https://en.wikipedia.org/wiki/Luhn_algorithm

Used to compute the checksum of credit card numbers.

```python
def split(n):
    return n // 10, n % 10

def sum_digits(n):
    if n < 10:
        return n
    else:
        all_but_last, last = split(n)
        return sum_digits(all_but_last) + last

def luhn_sum(n):
    if n < 10:
        return n
    else:
        all_but_last, last = split(n)
        return luhn_sum_double(all_but_last) + last

def luhn_sum_double(n):
    all_but_last, last = split(n)
    luhn_digit = sum_digits(2 * last)
    if n < 10:
        return luhn_digit
    else:
        return luhn_sum(all_but_last) + luhn_digit
```

### Order of Recursive Calls

Until the return value appears, that call has not completed.

E.g., the cascade function

```python
def cascade(n):
    if n < 10:
        print(n)
    else:
        print(n)
        cascade(n//10)
        print(n)

>>> cascade(123)
123
12
1
12
123
```

E.g., inverse cascade function

```python
def inverse_cascade(n):
    grow(n)
    print(n)
    shrink(n)

def f_then_g(f, g, n):
    if n:
        f(n)
        g(n)

grow = lambda n: f_then_g(grow, print, n//10)
shrink = lambda n: f_then_g(print, shrink, n//10)

>>> inverse_cascade(123)
1
12
123
12
1
```

## Tree Recursion

Tree recursion happens when one function makes more than one recursive call.

E.g., Computing the sequence of Fibonacci numbers.

```python
def fib(n):
    if n == 0:
        return 0
    elif n == 1:
        return 1
    else:
        return fib(n-2) + fib(n-1)
```

This process is highly repetitive; fib is called on the same argument multiple times.

E.g., Couting partitions

```python
def count_partitions(n, m):
    """Count the ways to partition n using parts up to m."""
    if n < 0:
        return 0
    elif n == 0:
        return 1
    elif m == 0:
        return 0
    else:
        with_m = count_partitions(n-m, m)
        without_m = count_partitions(n, m-1)
        return with_m + without_m

>>> count_partitions(6, 4)
9
>>> count_partitions(10, 4)
23
```
