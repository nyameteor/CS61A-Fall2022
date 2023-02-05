---
title: Interpreters
---

## Programming Languages

### Metalinguistic Abstraction

A powerful form of abstraction is to define a new language that is tailored to a particular type of application or problem domain.

- **Type of application**:
  Erlang was designed for concurrent programs. It has built-in elements for expressing concurrent communication.

- **Problem domain**:
  The MediaWiki mark-up language was designed for generating static web pages. It has built-in elements for text formatting and cross-page linking.

A programming language has:

- **Syntax:** The legal statements and expressions in the language.
- **Semantics:** The execution/evaluation rule for those statements and expressions.

To create a new programming language, you either need a:

- **Specification:** A document describe the precise syntax and semantics of the language.
- **Canonical Implementation:** An interpreter or compiler for the language.

## Calculator

Textbook: http://composingprograms.com/pages/34-interpreters-for-languages-with-combination.html

A scheme syntax calculator is a scheme interpreter that does not support many features of scheme,
but does include the arithmetic operators of scheme as well as call expressions which can be nested.

### Parsing Expressions

A Parser takes text and returns an expression.

```text
         Lexical analysis                 Syntactic analysis
Text ------------------------> Tokens ----------------------------> Expression

'(+1'                          '(', '+', 1                          Pair('+', Pair(1, ...))
'  (- 23)'                     '(', '-', 23, ')'                        *printed as*
'  (* 4 5.6))'                 '(', '*', 4, 5,6, ')', ')'           (+ 1 (- 23) (* 4 5.6))
```

### Calculator Syntax

The Calculator language has primitive expressions and call expressions.

A primitive expression is a number: `2`, `-4`, `5.6`

A call expression is a combination that begins with an operator (`+, -, *, /`), followed by 0 or more expressions: `(+ 1 2 3)`, `(/ 3 (+ 4 5))`

Expressions are represented as Scheme lists (Pair instances) that encode tree structures.

### Calculator Semantics

The value of a calculator expression is defined recursively.

**Primitive:** A number evaluates to itself.

**Call:** A call expression evaluates to its argument values combined by an operator.

- `+`: Sum of the arguments.
- `*`: Product of the arguments.
- `-`: If one argument, negate it. If more than one, subtract the rest from the first.
- `/`: If one argument, invert it. If more than one, divide the rest from the first.

### Calculator Evaluation

**The Eval Function**

Evaluate a Calculator expressions.

Language Semantics:

```text
A number evaluates...
    to itself
A call expression evalutes...
    to its argument values
    combined by an operator
```

**The Apply Function**

Apply the named operator to a list of arguments.

Language Semantics:

```text
+:
    Sum of the arguments
-:
    ...
...
```

## Interpreter

Textbook: http://composingprograms.com/pages/35-interpreters-for-languages-with-abstraction.html

### The structure of an Interpreter

```text
Eval
  Base cases:
    - Primitive values
    - Look up values bound to symbols
  Recursive calls:
    - Eval(operator, operands) of call expression
    - Apply(procedure, arguments)
    - Eval(sub-expressions) of special forms

        |       ^
        |       |
        |       |
        V       |

Apply
  Base cases:
    - Built-in primitive procedures
  Recursive calls:
    - Eval(body) of user-defined procedures
```

- _Eval_ requires an environment for symbol lookup.
- _Apply_ creates a new environment each time a user-defined procedure is applied.

### Special Forms

The scheme_eval function dispatches on expression form:

- Symbols are bound to vlaues in the current environment.
- Self-evaluating expressions are returned.
- All other legal expressions are represented as _combinations_.
  - Special forms: Special forms are identified by the first list element, for example: `if`, `lambda`, `define`.
  - Call expression: Any combination that is not a known special form is a call expression.
