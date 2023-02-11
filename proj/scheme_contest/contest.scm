;;; Scheme Recursive Art Contest Entry
;;;
;;; Please do not include your name or personal info in this file.
;;;
;;; Title: Koch snowflake
;;;
;;; Description:
;;;    A simple implementation of Koch snowflake.
;;;    May contain redundant recursions that need to be removed.
;;;    References: https://en.wikipedia.org/wiki/Koch_snowflake

(define (draw)
  (begin (penup)
         (goto -364 -210)
         (right 30)
         (color "blue")
         (pendown))
  (koch-snowflake 729 5)
  (exitonclick))

;; Draw Koch snowflake
(define (koch-snowflake x n)
  (define (edge-loop m)
    (if (= m 0)
        nil
        (begin (koch-edge x n)
               (right 120)
               (edge-loop (- m 1)))))
  (edge-loop 3))

;; Draw one edge of Koch snowflake
(define (koch-edge x n)
  (if (= n 0)
      (fd x)
      (begin (koch-edge (/ x 3) (- n 1))
             (left 60)
             (koch-edge (/ x 3) (- n 1))
             (right 120)
             (koch-edge (/ x 3) (- n 1))
             (left 60)
             (koch-edge (/ x 3) (- n 1)))))

; Please leave this last line alone.  You may add additional procedures above
; this line.
(draw)