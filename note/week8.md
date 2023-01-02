# Week8

## Objects

Textbook: http://composingprograms.com/pages/25-object-oriented-programming.html

### Object-Oriented Programming

A method for organizing modular programs

- Abstraction barriers
- Bundling together information and related behavior

A metaphor for computation using distributed state

- Each object has its own local state.
- Each object also knows how to manage its own local state, based on method calls.
- Method calls are `messages` passed between objects.

### Classes

A class serves as a template for its instances.

```text
class <name>:
    <suite>   --> The suite is executed immediately when the class statement is executed.
```

### Methods

Methods are defined in the suite of a class statement.

These def statements create function objects as always, but their names are bound as attributes of the class.

All invoked methods have access to the object via the `self` parameter, and so they can all access and manipulate the object's state.

### Attributes

All objects have attributes, which are name-value pairs.

- Instance attribute: attribute of an instance
- Class attribute: attribute of the class of an instance

## Inheritance

Textbook: http://composingprograms.com/pages/25-object-oriented-programming.html

### Inheritance

Inheritance is a method for relating classes together.

A subclass `inherits` the attributes of its base class.

```text
class <name>(<base class>):
    <suite>
```

Looking Up Attribute Names on Classes

To look up a name in a class:

1. if it names an attribute in the class, return the attribute value.
2. Otherwise, look up the name in the base class recursively, if there is one.

### Object-Oriented Design

Inheritance and Composition

Inheritance is best for representing `is-a` relationships.

- E.g., a cheking account `is a` specialized type of account.

  So, CheckingAccount inherits from Account.

Composition is best for representing `has-a` relationships.

- E.g., a bank `has a` collection of bank accounts it manages.

  So, A bank has a list of accounts as an attribute.

### Multiple Inheritance

Python supports the concept of a subclass inheriting attributes from multiple base classes, a language feature called `multiple inheritance`.

Further reading: Python resolves this name using a recursive algorithm called the C3 Method Resolution Order.

The method resolution order can be queried using the `mro` method on all classes.

Reference to the original paper: http://python-history.blogspot.com/2010/06/method-resolution-order.html

## Representation

Textbook: http://composingprograms.com/pages/27-object-abstraction.html

### String Representations

In Python, all objects produce two string representations:

- The `str` is legible to humans.

- The `repr` is legible to the Python interpreter.

  `repr(obj)` return the canonical string representation of the object. For many object types, `eval(repr(obj)) == obj`.

### Polymorphic Functions

Polymorphic function: A function that applies to many (poly) different forms (morph) of data.

E.g., `str` and `repr` are both polymorphic, they apply to any object.

### Interfaces

**Message passing:** Objects interact by looking up attributes on each other (passing messages).

The attribute look-up rules allow different data types to respond to the same message.

A **shared message** (attribute name) can elicit similar behavior from different objects.

An **interface** is a set of shared messages, along with a specification of what they mean.

Example:

Classes that implement `__repr__` and `__str__` methods that return Python-interpretable and human-readable strings implement an interface for producing string representations.

### Special Method Names (Particular to Python Language)

Certain names are special because they have built-in behavior.

References:

- http://getpython3.com/diveintopython3/special-method-names.html
- https://docs.python.org/3/reference/datamodel.html#special-method-names
