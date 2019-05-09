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
    [(number? (first sent)) (se (first sent) (numbers (bf sent)))]
    [else (se (numbers (bf sent)))]))

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

#|
Exercise 5 - Define initials

Write a procedure initials that takes a sentence as its argument and returns a sentence of the first letters in each of the sentence's words.

-> (initials '(if i needed someone))
'(i i n s)
|#

(define (initials sent)
  (if (empty? sent)
    '()
    (se (first (first sent)) (initials (bf sent)))))

#|
Exercise 6 - Define copies

Write a procedure copies that takes a number and a word as arguments and returns
a sentence containing that many copies of the given word.

-> (copies 8 'spam)
'(spam spam spam spam spam spam spam spam)
|#

(define (copies num wd)
  (if (= num 0)
    '()
    (se wd (copies (- num 1) wd))))

#|
Exercise 7 - Define gpa

Write a GPA procedure. It should take a sentence of grades as its argument and
return the corresponding grade point average.

Hint: write a helper procedure called base-grade that takes a grade as argument
and returns 0, 1, 2, 3, or 4, and another helper procedure called grade-modifier
that returns −.33, 0, or .33, depending on whether the grade has a minus, a plus,
or neither.

-> (gpa '(A A+ B+ B))
3.67
|#

(define (base-grade grade)
  (case (first grade)
    [("A") 4]
    [("B") 3]
    [("C") 2]
    [("D") 1]
    [("F") 0]))

(define (grade-modifier grade)
  (case (bf grade)
    [("") 0]
    [(+) 0.33]
    [(-) -0.33]))

(define (total-points grades)
 (if (empty? grades)
   0
   (+ (+ (base-grade (first grades)) (grade-modifier (first grades)))
      (total-points (bf grades)))))

(define (gpa grades)
 (/ (total-points grades) (count grades)))

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