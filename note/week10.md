# Week10

## Scheme

Textbook: http://composingprograms.com/pages/32-functional-programming.html

Online REPL: https://code.cs61a.org/

### Fundamentals

Scheme programs consist of expressions, which can be:

- Primitive expressions: `2`, `3.3`, `true`, `+`, `quotient`, ...
- Combinations: `(+ 6 1)`, `(quotient 10 2)`, `(not true)`, ...

Numbers are self-evaluating; symbols are bound to values.

Call expressions include an operator and 0 or more operands in parentheses.

### Special Forms

A combination that is not a call expression is a special form:

- **If** expression: `(if <predicate> <consequent> <alternative>)`
- **And** and **or**: `(and <e1> ... <en>)`, `(or <e1> ... <en>)`
- Binding symbols: `(define <symbol> <expression>)`
- New procedures: `(define (<symbol> <formal parameters>) <body>)`
- Lambda: `(lambda (<formal parameter>) <body>)`

Example: square root procedure

```scheme
(define (square x)
    (* x x)
)

(define (average x y)
    (/ (+ x y) 2)
)

(define (sqrt x)
    (define (update guess)
        (if (= (square guess) x)
            guess
            (update (average guess (/ x guess)))
        )
    )
    (update 1)
)
```

### Symbolic Programming

Symbols normally refer to values; how do we refer to symbols?

```scheme
> (define a 1)
> (define b 2)
> (list a b)
(1 2)           ;; No sign of "a" and "b" in the resulting value.
```

Quotation is used to refer to symbols directly in Lisp.
`(quote <symbol>)` is the special form to indicate that the symbol itself is the value.

```scheme
> (list 'a 'b)  ;; 'a is Shorthand for (quote a)
(a b)
> (list 'a b)
(a 2)
```

We can't evaluate a symbol until we've defined it.
But we can refer to a symbol before we've defined it, because it's just a symbol.

### Example: Even Subsets

A recursive approach, The even subsets of s include:

- all the even subsets of the rest of s
- the first element of s followed by an (even/odd) subset of the rest
- just the first element of s if it is even

```scheme
;;; Non-empty subsets of integer list s that have an even sum
;;;
;;; > (even-subsets '(3 4 5 7))
;;; ((5 7) (4 5 7) (4) (3 7) (3 5) (3 4 7) (3 4 5))
(define (even-subsets s)
    (if (null? s)
        nil
        (append (even-subsets (cdr s))
                (subsets-helper even? s)
        )
    )
)

;;; Non-empty subsets of integer list s that have an odd sum
;;;
;;; > (odd-subsets '(3 4 5 7))
;;; ((7) (5) (4 7) (4 5) (3 5 7) (3 4 5 7) (3 4) (3))
(define (odd-subsets s)
    (if (null? s)
        nil
        (append (odd-subsets (cdr s))
                (subsets-helper odd? s)
        )
    )
)

;;; Subsets helper procedure
(define (subset-helper f s)
    (map (lambda (t) (cons (car s) t))
         (if (f (car s))
             (even-subsets (cdr s))
             (odd-subsets (cdr s))
         )
    )
    (if (f (car s))
        (list (list (car s)))
        nil
    )
)
```

A simpler way, find even subsets using filter:

```scheme
;;; non-empty subsets of s
(define (nonempty-subsets s)
    (if (null? s)
        nil
        (let ((rest (nonempty-subsets (cdr s))))
             (append rest
                     (map (lambda (t) (cons (car s) t)) rest)
                     (list (list (car s)))
             )
        )
    )
)

;;; Non-empty subsets of integer list s that have an even sum
(define (even-subsets s)
    (filter (lambda (t) (even? (apply + t))) (nonempty-subsets s))
)
```
