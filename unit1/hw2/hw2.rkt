#lang racket

(require berkeley)
(provide (all-defined-out))

#|
Exercise 1 - Define substitute

Write a procedure substitute that takes three arguments: a sentence, an old word,
and a new word. It should return a copy of the sentence, but with every occurrence
of the old word replaced by the new word.

-> (substitute '(she loves you yeah yeah yeah) 'yeah 'maybe)
(she loves you maybe maybe maybe)
|#

(define (substitute sent old-word new-word)
  (cond
    [(empty? sent) '()]
    [(equal? (first sent) old-word) (se new-word (substitute (bf sent) old-word new-word))]
    [else (se (first sent) (substitute (bf sent) old-word new-word))]))

#|
Exercise 2 - Try out the expressions!

Type each of the following into Racket, and note the results. See if you can predict the results before letting Racket do the computation.

-> (lambda (x) (+ x 3))
#<procedure>

-> ((lambda (x) (+ x 3)) 7)
10

-> (define (make-adder num)
     (lambda (x) (+ x num)))
-> ((make-adder 3) 7)
10

-> (define plus3 (make-adder 3))
-> (plus3 7)
10

-> (define (square x) (* x x))
-> (square 5)
25

-> (define square (lambda (x) (* x x)))
-> (square 5)
25

-> (define (try f) (f 3 5))
-> (try +)
8

-> (try word)
'35
|#

#|
Exercise 3

Consider a function `g` for which the expression

((g) 1)

returns the value 3 when evaluated.

Determine how many arguments `g` has. In one word, also describe as best you can
the type of value returned by `g`.

Number of arguments: 1

Type of value returned: procedure.

|#

#|
Exercise 4 - Define f1, f2, f3, f4, and f5

For each of the following expressions, what must f be in order for the evaluation
of the expression to succeed, without causing an error? For each expression, give
a definition of f such that evaluating the expression will not cause an error, and
say what the expression's value will be, given your definition. To be clear, for
number one, define f1, for number 2, define f2, etc.

1. f1
2. (f2)
3. (f3 3)
4. ((f4))
5. (((f5)) 3)
|#

(define f1 1) ; a variable.

(define (f2) (+ 2 2)) ; a function that takes no arguments.

(define (f3 x) x + 3) ; a function that takes 1 argument.

(define (f4) (lambda () (+ 4 4))) ; a function returning a lambda taking no arguments.

(define (f5) (lambda () (lambda (x) (+ x 5))))
; a function returning a lambda taking no arguments returning another lambda that takes 1 argument.

#|
Exercise 5 - Try out the expressions

Find the values of the following expressions, where add1 is a primitive procedure
that adds one to its argument, and t is defined as follows:

(define (t f)
  (lambda (x) (f (f (f x)))) )

-> ((t add1) 0)
3

-> ((t (t add1)) 0)
9

-> (((t t) add1) 0)
27
|#

#|
Exercise 6 - Try out the expressions

Find the values of the following expressions where t is defined as in Exercise 5,
and s is defined as follows:

(define (s x)
  (+ 1 x))


-> ((t s) 0)
3

-> ((t (t s)) 0)
9

-> (((t t) s) 0)
27
|#

#|
Exercise 7 - Define make-tester

Write and test the make-tester procedure. Given a word w as its argument, make-tester
returns a procedure of one argument x that returns true if x is equal to w and false
otherwise.

-> ((make-tester 'hal) 'hal)
#t
-> ((make-tester 'hal) 'cs61a)
#f
-> (define sicp-author-and-astronomer? (make-tester 'gerry))
-> (sicp-author-and-astronomer? 'hal)
#f
-> (sicp-author-and-astronomer? 'gerry)
#t
|#

(define (make-tester wd)
  (lambda (w) (equal? w wd)))

; Exercise 8 - SICP exercises

; Complete SICP exercises 1.31a, 1.32a, 1.33, 1.40, 1.41, and 1.43.

; SICP 1.31a

(define (product term a next b)
  (if (> a b)
      1
      (* (term a) (product term (next a) next b))))

(define (identity x) x)

(define (next x) (+ x 1))

(define (factorial n)
  (product identity 1 next n))

(define (estimate-pi)
  (define (pi-term n)
    (if (odd? n)
        (/ (+ n 1) (+ n 2))
        (/ (+ n 2) (+ n 1))))
  (* 4.0 (product pi-term 1 next 1000)))

; SICP 1.32a

;; This is called my-accumulate so it doesn't conflict with Simply
;; Scheme's accumulate.
(define (my-accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a) (my-accumulate combiner null-value term (next a) next b))))

;; Write sum in terms of my-accumulate:
(define (sum-accum term a next b)
  (my-accumulate + 0 term a next b))

;; Write product in terms of my-accumulate:
(define (product-accum term a next b)
  (my-accumulate * 1 term a next b))

; SICP 1.33

(define (filtered-accumulate combiner null-value term a next b pred)
  (cond
    [(> a b) null-value]
    [(pred a) (combiner (term a) (filtered-accumulate combiner null-value term (next a) next b pred))]
    [else (filtered-accumulate combiner null-value term (next a) next b pred)]))

(define (sum-sq-prime a b)
  (filtered-accumulate + 0 square a next b prime?))

(define (rel-prime? x y)
  (= (gcd x y) 1))

(define (prod-of-some-numbers n)
  (filtered-accumulate * 1 identity 1 next (- n 1) (lambda (x) (rel-prime? x n))))

; SICP 1.40 - Define cubic

(define (cube x) (expt x 3))

(define (cubic a b c)
  (lambda (x) (+ (cube x) (* a (square x)) (* b x) c)))

; SICP 1.41 - Define double

(define (double proc)
  (lambda (x) (proc (proc x))))

; SICP 1.43 - Define repeated

; Already defined in Simply Scheme:
; (define (compose f g) (lambda (x) (f (g x))))

(define (my-repeated proc n)
  (my-accumulate compose identity (lambda (i) proc) 1 next n))

#|
; Exercise 9 - Define my-every

Last week you wrote procedure squares, that squared each number in its argument
sentence. Generalize this pattern to create a higher order procedure called
my-every that applies an arbitrary procedure, given as an argument, to each word
of an argument sentence.

-> (my-every square '(1 2 3 4))
(1 4 9 16)
-> (my-every first '(nowhere man))
(n m)
|#

(define (my-every proc sent)
  (if (empty? sent)
      '()
      (se (proc (first sent)) (my-every proc (bf sent)))))

#|
Exercise 10 - Try out the expressions

Using the higher order functions, our simply-scheme library provides its own
versions of the every function from the last exercise and the keep function shown
in our lessons. Get familiar with these by working these examples out before trying
them on the computer:

-> (every (lambda (letter) (word letter letter)) 'purple)
'(pp uu rr pp ll ee)


-> (every (lambda (number) (if (even? number) (word number number) number))
       '(781 5 76 909 24))
'(781 5 7676 909 2424)

-> (keep even? '(781 5 76 909 24))
'(76 24)

-> (keep (lambda (letter) (member? letter 'aeiou)) 'bookkeeper)
'ooeee

-> (keep (lambda (letter) (member? letter 'aeiou)) 'syzygy)
""

-> (keep (lambda (letter) (member? letter 'aeiou)) '(purple syzygy))
; Invalid arguments to MEMBER?:  purple aeiou

-> (keep (lambda (wd) (member? 'e wd)) '(purple syzygy))
'purple
|#