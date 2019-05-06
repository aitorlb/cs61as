#lang racket

(require berkeley)
(provide (all-defined-out))

#|
Exercise 0 - The "Keep" Pattern

Write a procedure called numbers that takes a sentence as its argument and returns another sentence containing only the numbers in the sentence. You may find the number? predicate useful.

-> (numbers '(76 trombones and 110 cornets))
'(76 110)
|#

(define (numbers sent)
  (cond [(empty? sent) '()]
		[(number? (first sent)) (sentence (first sent) (numbers (bf sent)))]
		[else (sentence (numbers (bf sent)))]))

#|
Exercise 1 - Define describe-time

Write a new version of the describe-time procedure from Homework 0-2. You only need to account for time periods up to a day. Instead of returning a decimal number, it should behave like this:

-> (describe-time 22222)
'(6 HOURS 10 MINUTES 22 SECONDS)

-> (describe-time 550441)
'(6 DAYS 8 HOURS 54 MINUTES 1 SECONDS)
|#

(define (describe-time secs)
  ; your code here
 (error "Not yet implemented")
)

; Exercise 2 - Define remove-once
(define (remove-once wd sent)
  ; your code here
 (error "Not yet implemented")
)

; Exercise 3 - Define differences
(define (differences nums)
  ;your code here
 (error "Not yet implemented")
)

; Exercise 4 - Define location
(define (location small big)
  ; your code here
 (error "Not yet implemented")
)

; Exercise 5 - Define initials
(define (initials sent)
  ; your code here
 (error "Not yet implemented")
)

; Exercise 6 - Define copies
(define (copies num wd)
  ; your code here
 (error "Not yet implemented")
)

; Exercise 7 - Define gpa
(define (gpa grades)
  ; your code here
 (error "Not yet implemented")
)

; Exercise 8 - Define repeat-words
(define (repeat-words sent)
  ; your code here
 (error "Not yet implemented")
)

; Exercise 9 - Define same-shape?
(define (same-shape? sent1 sent2)
  ; your code here
 (error "Not yet implemented")
)