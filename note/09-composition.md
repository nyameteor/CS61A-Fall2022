---
title: Composition
---

## Composition

Textbook: http://composingprograms.com/pages/29-recursive-objects.html

We can implement recursive computational data structure using Python's object system.

### Linked List Class

A linked list is either empty **or** a first value and the rest of the linked list.

```text
Representing sequence 3, 4, 5:

A linked list is a pair
     |
     |
Link instance      --->  Link instance      --->  Link instance
  first: 3       /         first: 4       /         first: 5
   rest: -------            rest: -------            rest: Link.empty
     |
     |
The `first` (zeroth) element is an attribute value
The `rest` of the element are stored in a linked list
```

We have objects that are values of attributes.
Here, we're using the idea of `composition` in order to construct the structure.

### Tree Class

A tree is a label and a list of branches, each branch is a tree.

## Efficiency

Textbook: http://composingprograms.com/pages/28-efficiency.html

### Measuring Efficiency

E.g., inspect just how many times `fib` is called.

[Demo](demo/example/efficiency.py)

### Memoization

Idea: Remember the results that have been computed before.

[Demo](demo/example/efficiency.py)

### Orders of Growth

Common Orders of Growth

| Category    | Big O Notation | Time Growth                   | Growth Description                                  | Example         |
| ----------- | -------------- | ----------------------------- | --------------------------------------------------- | --------------- |
| Exponential | $O(b^n)$       | $ab^{n+1} = (ab^n)b$          | Incrementing n multiples time by a constant         | recursive `fib` |
| Quadratic   | $O(n^2)$       | $a(n+1)^2 = a(n)^2 + a(2n+1)$ | Incrementing n increases time by n times a constant | `overlap`       |
| Linear      | $O(n)$         | $a(n+1) = a(n) + a$           | Incrementing n increases time by a constant         | slow `exp`      |
| Logarithmic | $O(\log(n))$   | $a\ln(2n) = a\ln(n) + a\ln2$  | Doubling n increases time by a constant             | fast `exp`      |
| Constant    | $O(1)$         |                               | Increasing n doesn't affect time                    | `abs`           |

## Decomposition

### Modular Design

A design principle: Isolate different parts of a program that address different concerns.

A modular component can be developed and tested independently.

### Data Example: Iterators

[Demo](demo/example/iterators.py)

### Data Example: Linked List

[Demo](demo/example/linked_list.py)
