---
title: Final Examples
---

## Tree

### Tree-Structured Data

A tree can contains other trees:

```text
[5, [6, 7], 8, [[9], 10]]   # nested list

(+5 (-6 7) 8 (* (- 9) 10))  # an expression in scheme

<ul>                        # an html element
  <li>Midterm <b>1</b><li>
  <li>Midterm <b>2</b><li>
<ul>
```

So trees appear anywhere, there's hierarchical structure in the data that we try to represent.

Tree processing often involves recursive calls on subtrees.

### Tree Processing Example

Approach 1: Returning the accumulation for one part of the tree, and then combine the different values from the branches to complete the accumulation.

```python
def bigs(t):
    """Return the number of nodes in t that are larger than all their ancestors.

    >>> a = Tree(1, [Tree(4, [Tree(4), Tree(5)]), Tree(3, [Tree(0), [Tree(2)]])])
    >>> bigs(a)
    4
    """
    def f(a, x):
        # a: a node in t
        # x: max ancestor label
        if a.label > x:
            return 1 + sum([f(b, a.label) for b in x.branches])
        else:
            return sum([f(b, x) for b in x.branches])

    # Root label is always larger than its ancestors (it doesn't have ancestors)
    return f(t, t.label - 1)
```

Approach 2: Initialize some value, and then traverses the tree and updates that accumulated value appropriately whenever it's time to add to it.

```python
def bigs(t):
    """Return the number of nodes in t that are larger than all their ancestors.
    """
    n = [0]
    def f(a, x):
        if a.label > x:
            n[0] += 1
        for b in a.branches:
            f(b, max(a.label, x))

    f(t, t.label - 1)
    return n[0]
```

## Designing Functions

### How to Design Programs

https://htdp.org/2022-8-7/Book/part_preface.html

- From Problem Analysis to Data Definitions
- Signature, Purpose statement, Header
- Functional Examples
- Function Template
- Function Definition
- Testing

### Applying the Design Process

```python
def smalls(t):  # Signature: Tree -> List of Trees
    """Return the non-leaf nodes in t that are smaller than all their descendants.

    >>> a = Tree(1, [Tree(2, [Tree(4), Tree(5)]), Tree(3, [Tree(0), Tree(6)])])
    >>> sorted([t.label for t in smalls(a)])
    [0, 2]
    """
    result = []
    def process(t): # Signature: Tree -> number, Find smallest label in t & maybe add t to result
        if t.is_leaf():
            return t.label
        else:
            smallest = min([process(t) for b in t.branches])
            if t.label < smallest:
                result.append[t]
            return min(smallest, t.label)
    process(t)
    return result
```
