---
title: Iterators and Generators
---

## Implicit Sequences

Textbook: http://composingprograms.com/pages/42-implicit-sequences.html

### Iterators

Sequential data can be represented implicitly using an `iterator`.

An `iterator` is an object that provides sequential access to values, one by one.

`iter(iterable)`: Return an iterator over the elements of an iterable value.

`next(iterator)`: Return the next element in an iterator.

Objects are `iterable` if they have an `__iter__` method that returns an `iterator`.

And `iterator` has a `__next__` method that returns the next item from the iterator.

We can also call `iter` on the iterator itself, which will just return the same iterator without changing its state.

```python
>>> primes = [2, 3, 5, 7]
>>> iterator = iter(primes)
>>> next(iterator)
2
>>> next(iter(iterator))    # Calling iter on an iterator returns itself
3
>>> next(iterator)
5
>>> list(iterator)
[7]
```

### Iterables

Any value that can produce iterators is called an `iterable` value.

A dictionary, its keys, its values, and its items are all iterable values.

- The order of items is the order in which they were added (Python 3.6+)
- items are unordered (Python 3.5 and earlier)

```python
>>> d = {'one': 1, 'two': 2, 'three': 3}
>>> k = iter(d.keys())  # or iter(d)
>>> next(k)
'one'
>>> next(k)
'two'
>>> next(k)
'three'
>>> i = iter(d.items())
>>> next(i)
('one', 1)
>>> next(i)
('two', 2)
>>> next(i)
('three', 3)
```

We can change the value of iterable values during iteration, but if we change the `size` of iterable values, then the previous iterator will be invalid.

```python
>>> d = {'one': 1, 'two': 2, 'three': 3}
>>> k = iter(d)
>>> next(k)
'one'
>>> d['zero'] = 0
>>> next(k)
RuntimeError: dictionary changed size during iteration
```

### Built-in Functions for Iteration

Many built-in Python sequence operations return iterators that compute results lazily.

Lazy computation means that a result is only computed when it has been requested.

All of these function return iterators. And those iterators produce these values each time we call `next` on them:

```python
         map(func, iterable)    # Iterate over func(x) for x in iterable

      filter(func, iterable)    # Iterate over x in iterable if func(x)

zip(first_iter, second_iter)    # Iterate over co-indexed (x, y) pairs

          reversed(sequence)    # Iterate over x in a sequence in reverse order
```

For example, If we only ask for elements one at a time, then they will be computed lazily:

```python
def double(x):
    print('**', x, '=>', 2*x, '**')
    return 2*x

>>> m = map(double, [3, 5, 7])
>>> next(m)
** 3 => 6 **
6
>>> f = lambda y: y >= 10
>>> t = filter(f, map(double, range(3, 7)))
>>> next(t)
** 3 => 6 **
** 4 => 8 **
** 5 => 10 **
10
```

## Generators

A `generator` is an iterator created by calling a `generator function`.

A `generator function` is a function that yields values instead of returing them.

A normal function returns once; a generator function can yield multiple times.

When a `generator function` is called, it returns a `generator` that iterates over its yields.

With generator, we can set up any computation we want, and that computation will be executed lazily.

```python
def plus_minus(x):
    yield x
    yield -x

>>> t = plus_minus(3)
>>> next(t)
3
>>> next(t)
-3
>>> next(t)
```

Another example:

```python
def even(start, end):
    even = start + (start % 2)
    while even < end:
        yield even
        even += 2

>>> list(even(1, 10))
[2, 4, 6, 8]
>>> t = even(1, 10)
>>> next(t)
2
>>> next(t)
4
>>> next(t)
6
>>> next(t)
8
```

A `yield from` statement yields all values from an iterator or iterable values.

```python
def a_then_b(a, b):
    for x in a:
        yield x
    for x in b:
        yield x

# or
def a_then_b(a, b):
    yield from a
    yield from b

>>> list(a_then_b([3, 4], [5, 6]))
[3, 4, 5, 6]
```

And we can do it recursively.

```python
def countdown(k):
    if k > 0:
        yield k
        yield from countdown(k-1)
    else:
        yield 'Blast off'

>>> for k in countdown(3):
...     print(k)
...
3
2
1
Blast off
```

Example: substrings

```python
def prefixes(s):
    if s:
        yield from prefixes(s[:-1])
        yield s

def substrings(s):
    if s:
        yield from prefixes(s)
        yield from substrings(s[1:])

>>> list(prefixes('both'))
['b', 'bo', 'bot', 'both']
>>> list(substrings('tops'))
['t', 'to', 'top', 'tops', 'o', 'op', 'ops', 'p', 'ps', 's']
```

Example: Partitions

[Demo](demo/example/partitions.py)
