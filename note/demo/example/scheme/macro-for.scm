;; scm> (map (lambda (x) (* x x)) '(2 3 4 5))
;; (4 9 16 25)
(define (map fn vals)
    (if (null? vals)
        nil
        (cons (fn (car vals)) 
              (map fn (cdr vals)))
    )
)

;; scm> (for x '(2 3 4 5) (* x x))
;; (4 9 16 25)
(define-macro (for sym vals expr)
    (list 'map (list 'lambda (list sym) expr) vals)
)

;; Another implementation
;; scm> (for x '(2 3 4 5) (* x x))
;; (4 9 16 25)
(define-macro (for sym vals expr)
    `(map (lambda (,sym) ,expr) ,vals)
)