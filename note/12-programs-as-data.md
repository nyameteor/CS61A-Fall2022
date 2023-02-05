---
title: Programs as Data
---

## Functional Programming

Functional programming is a very board term, but often refers to the following properties:

- All functions are pure functions.
- No re-assignment and no mutable data types.
- Name-value bindings are permanent.

Advantages of functional programming:

- The value of expression is independent of the order in which sub-expressions are evaluated.
- Sub-expressions can safely be evaluated in parallel or on demand (lazily).
- **Referential transparency:** The value of an expressions does not change when we substitute one of its sub-expression with the value of that sub-expression.

## Tail Recursion

### Tail Calls

A tail call is a call expression in a _tail context_:

- The last body sub-expression in a lambda expression.
- Sub-expressions 2 & 3 in a tail context **if** expression.
- All non-predicate sub-expressions in a tail context **cond**.
- The last sub-expression in a tail context **and** or **or**.
- The last sub-expression in a tail context **begin**.

A call expression is not a tail call if more computation is still required in the calling procedure.

```scheme
(define (length s)
    (if (null? s)
        0
        (+ 1 (length (cdr s)))  ; not a tail context
    )
)
```

Linear recursive procedures can often be re-written to use tail calls.

```scheme
(define (length s)
    (define (length-iter s n)
        (if (null? s)
            n
            (length-iter (cdr s) (+ 1 n))   ; recursive call is a tail call
        )
    )
    (length-iter s 0)
)
```

### Eval with Tail Call Optimization

The return value of the tail call is the return value of the current procedure call. Therefore, tail calls shouldn't increase the environment size.

## Programs as Data

### Programs as Data

The built-in Scheme list data structure can represent combinations:

```scheme
scm> (list '/ 10 2)
(/ 10 2)
scm> (eval (list '/ 10 2))
5
```

In such a language, it is straightforward to write a program that writes a program.

```scheme
(define (fact n)
    (if (= n 0)
        1
        (* n (fact (- n 1)))
    )
)

;; Returns an expression that computes the factorial of n
;; scm> (fact-exp 5)
;; (* 5 (* 4 (* 3 (* 2 (* 1 1)))))
(define (fact-exp n)
    (if (= n 0)
        1
        (list '* n (fact-exp (- n 1)))
    )
)
```

### Generating Code

Quasiquotation is particularly convenient for generating scheme expressions.

```scheme
scm> (define b 4)
b
scm> '(a ,(+ b 1))  ;; Quote
(a (unquote (+ b 1)))
scm> `(a ,(+ b 1))  ;; Quasiquote
(a 5)
```

Example: Sum While

[Demo](demo/example/scheme/sum-while.scm)

## Macros

### Macros Perform Code Transformations

A macro is an operation performed on the source code of a program before evaluation.

Scheme has a **define-macro** special form that defines a source code transformation.

Evaluation procedure of a macro call expression:

- Evaluate the operator sub-expression, which evaluates to a macro.
- Call the macro procedure on the operand expressions _without evaluating them first_.
- Evaluate the expression returned from the macro procedure.

```scheme
scm> (define-macro (twice expr) (list 'begin expr expr))
scm> (twice (print 2))
2
2

;; is equalvalent to
scm> (define (twice expr) (list 'begin expr expr))
scm> (eval (twice '(print 2)))
2
2
```

Example: For Macro

[Demo](demo/example/scheme/macro-for.scm)

Example: Trace Macro

[Demo](demo/example/scheme/macro-trace.scm)
