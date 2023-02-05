---
title: Sequences and Containers
---

Textbook:

- http://composingprograms.com/pages/21-introduction.html
- http://composingprograms.com/pages/22-data-abstraction.html
- http://composingprograms.com/pages/23-sequences.html

## Sequences

### Lists

A list value is a sequence that can have arbitrary length.

### Sequence Iteration

`for` statement, it will unpack the sequence during iteration:

```text
for <name> in <expression>:
    <suite>
```

### Sequence Processing

List comprehensions:

```python
>>> odds = [1, 3, 5, 7, 9]
>>> [x+1 for x in odds]
[2, 4, 6, 8, 10]
>>> [x for x in odds if 25 % x == 0]
[1, 5]
```

### Sequence Abstraction

Slicing, note slicing creates a new copy of values:

```python
>>> odds = [1, 3, 5, 7, 9]
>>> odds[1:3]
[3, 5]
>>> [odds[i] for i in range(1, 3)]
[3, 5]
```

### Strings

Length, element selection, and slicing are similar to all sequences:

```python
>>> city = 'Berkely'
>>> len(city)
8
>>> city[3]
'k'
>>> city[0:3]
'Ber'
```

Howerver, the `in` operators match substrings:

```python
>>> 'here' in "Where's Waldo?"
True
```

### Dictionaries

Dictionaries are collections of key-value pairs.

Dictionary keys do have two restrictions:

- Key must be hashable types(cannot be any mutable type).
  This restriction is tied to Python's implementation of dictionaries, read more: [hashable](https://docs.python.org/3.10/glossary.html#term-hashable).

- Two keys cannot be equal.
  This restriction is part of the dictionary abstraction.

Dictionary comprehensions:

```python
def index(keys, values, match):
    """Return a dictionary from keys k to a list of values v
    for which match(k, v) is a true value.

    >>> index([7, 9, 11], range(30, 50), lambda k, v: v % k == 0)
    {7: [35, 42, 49], 9: [36, 45], 11: [33, 44]}
    """
    return {k: [v for v in values if match(k, v)] for k in keys}
```

## Data Abstraction

Compound objects combine objects together.

For example:

- A date: a year, a month, and a day
- A geographic position: latitude and longitude
