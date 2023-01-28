;; scm> (fact 5)
;; 120
(define fact 
    (lambda (n)
        (if (zero? n)
            1
            (* n (fact (- n 1)))
        )
    )
)

;; trace macro like 
;; scm> (trace (fact 5))
;; (fact 5)
;; (fact 4)
;; (fact 3)
;; (fact 2)
;; (fact 1)
;; (fact 0)
;; 120
(define-macro (trace expr)                          ; (trace (fact 5))
    (define operator (car expr))                    ; fact 
    `(begin
        (define original ,operator)                 ; backup original operator
        (define ,operator                           ; redefine the operator
            (lambda (n)
                (print (list (quote ,operator) n))
                (original n))
        )
        (define result ,expr)                       ; evaluate the expression with redefined operator
        (define ,operator original)                 ; revert original operator
        result
    )
)