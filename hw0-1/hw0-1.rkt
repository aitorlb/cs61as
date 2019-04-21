#lang racket

;; A line starting with a semicolon is a "comment".  You write
;; comments in order to explain in English what your code does, and
;; Racket knows to ignore comments since they aren't part of the
;; program.

;; This tells Racket that you want to use words and sentences (which
;; are disabled by default).
(require (planet dyoo/simply-scheme))

;; This tells Racket that it should "know" about all the functions you
;; define in this file.  (Don't worry about this for now.)
(provide (all-defined-out))

;; Exercise 0 - Introduce yourself

#|

This is a comment that spans multiple lines.

1) What is your name?

2) What is your major?

3) Are you a returning student? (i.e. Did you take 61AS last semester?)

4) What made you to take 61AS?

5) Tell us interesting things about yourself.

|#

;; Make a followup on the "Hello World!" post on Piazza introducing yourself.


;; Exercise 1 - Define sum-of-squares
#|

Using square, define a procedure sum-of-squares that takes two arguments and
returns the sum of the squares of the two arguments:

-> (sum-of-squares 3 4)
25

|#

(define (square x) (* x x))

(define (sum-of-squares x y)
	(+ (square x) (square y)))

;; Exercise 2a - Define can-drive

#|

write a procedure can-drive that takes the age of a person as an argument.
If the age is below 16, return the sentence '(Not yet).
Otherwise, return the sentence '(Good to go)

-> (can-drive 16)
'(Good to go)

|#


(define (can-drive age)
	(if (< age 16)
		'(Not yet)
		'(Good to go)))


;; Exercise 2b - Define fizzbuzz
#|

Write a procedure fizzbuzz that takes a number and outputs the word 'fizz if
the number is divisible by 3, 'buzz if it's divisible by 5, 'fizzbuzz if it's
divisible by both 3 and 5, and otherwise, the number itself.
You may find the function remainder useful.

|#

(define (divisible? big small)
	(= (remainder big small) 0))

(define (fizzbuzz x)
  (cond ((and (divisible? x 3) (divisible? x 5)) 'fizzbuzz)
        ((divisible? x 3) 'fizz)
        ((divisible? x 5) 'buzz)
  			(else x)))

;; Exercise 3 - Why did the Walrus cross the Serengeti?

#|
Your answer here


|#

;; Exercise 4 - new-if vs if

#|
Your answer here

|#
