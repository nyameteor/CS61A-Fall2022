(define (my-filter pred s)
    (if (null? s)
        nil
        (if (pred (car s))
            (cons (car s) (my-filter pred (cdr s)))
            (my-filter pred (cdr s))
        )
    )
)

(define (interleave lst1 lst2)
    (if (null? lst1)
        lst2
        (if (null? lst2)
            lst1
            (cons (car lst1) (cons (car lst2) (interleave (cdr lst1) (cdr lst2))))
        )
    )
)

(define (accumulate joiner start n term)
    (if (= n 0)
        start
        (joiner (term n) (accumulate joiner start (- n 1) term))
    )
)

(define (no-repeats lst)
    (if (null? lst)
        nil
        (cons (car lst)
              (no-repeats (my-filter (lambda (e) (not (= (car lst) e))) (cdr lst)))
        )
    )
)
