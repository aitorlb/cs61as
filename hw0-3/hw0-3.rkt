#lang racket

(require berkeley)
(provide (all-defined-out))

#|
Exercise 0 - The "Keep" Pattern

Write a procedure called numbers that takes a sentence as its argument and
returns another sentence containing only the numbers in the sentence.
You may find the number? predicate useful.

-> (numbers '(76 trombones and 110 cornets))
'(76 110)
|#

(define (numbers sent)
  (cond
    [(empty? sent) '()]
    [(number? (first sent)) (sentence (first sent) (numbers (bf sent)))]
    [else (sentence (numbers (bf sent)))]))

#|
Exercise 1 - Define describe-time

Write a new version of the describe-time procedure from Homework 0-2.
You only need to account for time periods up to a day.
Instead of returning a decimal number, it should behave like this:

-> (describe-time 22222)
'(6 HOURS 10 MINUTES 22 SECONDS)

-> (describe-time 550441)
'(6 DAYS 8 HOURS 54 MINUTES 1 SECONDS)
|#

(define (describe-time secs)
  (define day 86400)
  (define hour 3600)
  (define minute 60)
  (cond
    [(>= secs day) (sentence (quotient secs day) 'days (describe-time (remainder secs day)))]
    [(>= secs hour) (sentence (quotient secs hour) 'hours (describe-time (remainder secs hour)))]
    [(>= secs minute) (sentence (quotient secs minute) 'minutes (describe-time (remainder secs minute)))]
    [else (sentence secs 'seconds)]))

#|
Exercise 2 - Define remove-once

Write a procedure called remove-once that takes a word and sentence
as its argument and returns another sentence with the given word removed.
(If the given word appears more than once, it doesn't matter which one
is removed, as long as only one of them is.)
Here's an example of how the procedure remove-once should work:

-> (remove-once 'morning '(good morning good morning))
'(good good morning)
|#

(define (remove-once wd sent)
  (cond
    [(empty? sent) '()]
    [(and (equal? (first sent) wd) (not (member? wd (bf sent)))) (sentence (remove-once wd (bf sent)))]
    [else (sentence (first sent) (remove-once wd (bf sent)))]))

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