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
    [(>= secs day) (se (quotient secs day) 'days (describe-time (remainder secs day)))]
    [(>= secs hour) (se (quotient secs hour) 'hours (describe-time (remainder secs hour)))]
    [(>= secs minute) (se (quotient secs minute) 'minutes (describe-time (remainder secs minute)))]
    [else (se secs 'seconds)]))

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
    [(and (equal? (first sent) wd) (not (member? wd (bf sent)))) (se (remove-once wd (bf sent)))]
    [else (se (first sent) (remove-once wd (bf sent)))]))

#|
Exercise 3 - Define differences

Write the procedure differences, which takes a sentence of numbers as its argument
and returns a sentence containing the differences between adjacent elements.
(The length of the returned sentence is one less than that of the argument.)

-> (differences '(4 23 9 87 6 12))
'(19 -14 78 -81 6)
|#

(define (differences nums)
  (if (empty? (bf nums))
    '()
    (se (- (first (bf nums)) (first nums)) (differences (bf nums)))))

#|
Exercise 4 - Define location

Write a procedure called location that takes two arguments, a word and a sentence.
It should return a number indicating where in the sentence that word can be found.
If the word isn't in the sentence, return #f. If the word appears more than once,
return the location of the first appearance.

-> (location 'me '(you never give me your money))
4
-> (location 'i '(you never give me your money))
#f
-> (location 'the '(the fork and the spoon))
1
|#

(define (location-aux wd sent counter)
  (cond
    [(empty? sent) #f]
    [(equal? (first sent) wd) counter]
    [else (location-aux wd (bf sent) (+ 1 counter))]))

(define (location wd sent)
  (location-aux wd sent 1))

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