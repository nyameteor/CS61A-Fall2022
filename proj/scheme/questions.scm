(define (caar x) (car (car x)))
(define (cadr x) (car (cdr x)))
(define (cdar x) (cdr (car x)))
(define (cddr x) (cdr (cdr x)))

;; Problem 15
;; Returns a list of two-element lists
(define (enumerate s)
  ; BEGIN PROBLEM 15
  (define (helper s n)
    (if (null? s)
      nil
      (cons (list n (car s) ) 
        (helper (cdr s) (+ n 1)))
      )
    )
  (helper s 0)
  )
  ; END PROBLEM 15

;; Problem 16

;; Merge two lists LIST1 and LIST2 according to ORDERED? and return
;; the merged lists.
(define (merge ordered? list1 list2)
  ; BEGIN PROBLEM 16
  (cond 
    ((null? list1) list2)
    ((null? list2) list1)
    ((ordered? (car list1) (car list2)) 
      (cons (car list1) (merge ordered? (cdr list1) list2)))
    (else 
      (cons (car list2) (merge ordered? list1 (cdr list2))))
    )
  )
  ; END PROBLEM 16

;; Optional Problem 2

;; Returns a function that checks if an expression is the special form FORM
(define (check-special form)
  (lambda (expr) (equal? form (car expr))))

(define lambda? (check-special 'lambda))
(define define? (check-special 'define))
(define quoted? (check-special 'quote))
(define let?    (check-special 'let))

;; Converts all let special forms in EXPR into equivalent forms using lambda
(define (let-to-lambda expr)
  (cond ((atom? expr)
         ; BEGIN OPTIONAL PROBLEM 2
         expr
         ; END OPTIONAL PROBLEM 2
         )
        ((quoted? expr)
         ; BEGIN OPTIONAL PROBLEM 2
         expr
         ; END OPTIONAL PROBLEM 2
         )
        ((or (lambda? expr)
             (define? expr))
         (let ((form   (car expr))
               (params (cadr expr))
               (body   (cddr expr)))
           ; BEGIN OPTIONAL PROBLEM 2
           (let ((real-params (map (lambda (expr) (let-to-lambda expr)) params))
                 (real-body (map (lambda (expr) (let-to-lambda expr)) body)))
               (append `(lambda ,real-params) real-body)
            )
           ; END OPTIONAL PROBLEM 2
           ))
        ((let? expr)
         (let ((values (cadr expr))
               (body   (cddr expr)))
           ; BEGIN OPTIONAL PROBLEM 2
           (let ((combines (zip values)))
             (let ((formals (car combines))
                   (args (cadr combines)))
               (let ((real-formals (map (lambda (expr) (let-to-lambda expr)) formals))
                     (real-args (map (lambda (expr) (let-to-lambda expr)) args))
                     (real-body (map (lambda (expr) (let-to-lambda expr)) body)))
                  (cons (append `(lambda ,real-formals) real-body) real-args)
                )
              )
            )
           ; END OPTIONAL PROBLEM 2
           ))
        (else
         ; BEGIN OPTIONAL PROBLEM 2
         (map (lambda (expr) (let-to-lambda expr)) expr)
         ; END OPTIONAL PROBLEM 2
         )))

; Some utility functions that you may find useful to implement for let-to-lambda

(define (zip pairs)
  (list 
    (map (lambda (pair) (car pair)) pairs)
    (map (lambda (pair) (cadr pair)) pairs))
  )

;; Append list2 elements to list1
;; scm> (append '(1 2 3) '(4 5 6))
;; (1 2 3 4 5 6)
(define (append list1 list2)
  (if (null? list1)
    list2
    (cons (car list1) (append (cdr list1) list2))
    )
  )