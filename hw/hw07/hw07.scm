(define (cddr s) (cdr (cdr s)))

(define (cadr s) (car (cdr s)))

(define (caddr s) (car (cddr s)))

(define (ascending? asc-lst)
   (if (null? asc-lst)
        #t
        (if (null? (cdr asc-lst))
            #t
            (if (> (car asc-lst) (cadr asc-lst))
                #f
                (ascending? (cdr asc-lst))
            )
        )
   )
)

(define (square n) (* n n))

(define (pow base exp) 
    (if (= exp 0)
        1
        (if (even? exp)
            (square (pow base (/ exp 2)))
            (* base (pow base (- exp 1)))
        )
    )
)
