;; Return the sum of the squares of even numbers less than 10, starting with 2
(begin
    (define (f x total)
        (if (< x 10)
            (f (+ x 2) (+ total (* x x)))
            total
        )
    )
    (f 2 0)
)

;; Return the sum of the numbers whose squares are less than 50, starting with 1
(begin
    (define (f x total)
        (if (< (* x x) 50)
            (f (+ x 1) (+ total x))
            total
        )
    )
    (f 1 0)
)

;; Return the generic sum-while function 
;; scm> (define result (sum-while 1     '(< (* x x) 50)  'x  '(+ x 1)))
;; result
;; scm> result
;; (begin (define (f x total) (if (< (* x x) 50) (f (+ x 1) (+ total x)) total)) (f 1 0))
;; scm> (eval result)
;; 28
(define (sum-while initial-x condition add-to-total update-x)
    `(begin
        (define (f x total)
            (if ,condition
                (f ,update-x (+ total ,add-to-total))
                total
            )
        )
        (f ,initial-x 0)
    )
)