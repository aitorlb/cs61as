#lang racket

(require berkeley)
(provide (all-defined-out))

#|
Exercise 1 - Define dupls-removed

Write a procedure dupls-removed that, given a sentence as input, returns the
result of removing duplicate words from the sentence. This problem uses recursion.

-> (dupls-removed '(a b c a e d e b))
'(c a d e b)

-> (dupls-removed '(a b c))
'(a b c)

-> (dupls-removed '(a a a a b a a))
'(b a)
|#

(define (dupls-removed sent)
  (cond
    [(empty? sent) '()]
    [(member? (first sent) (bf sent)) (se (dupls-removed (bf sent)))]
    [else (se (first sent) (dupls-removed (bf sent)))]))

#|
Exercise 2 - Define count-word

Write a procedure count-word that takes a sentence and a word as arguments and
outputs the number of occurences of the input word in the sentence.

-> (count-word '(i really really like 61as) 'really)
2
-> (count-word '(i lambda racket) 'love)
0
|#

(define (count-word sent wd)
  (define (count-word-aux sent wd counter)
    (cond
      [(empty? sent) counter]
      [(equal? (first sent) wd) (count-word-aux (bf sent) wd (+ 1 counter))]
      [else (count-word-aux (bf sent) wd counter)]))
  (count-word-aux sent wd 0))

#|
Exercise 3

Explain what would happen if you used new-if (from Lab 0) instead of if in the
pigl procedure.

Here is the definition of pigl and new-if from previous lab:
|#

(define (pigl wd)
  (if (pl-done? wd)
      (word wd 'ay)
      (pigl (word (bf wd) (first wd)))))

(define (pl-done? wd)
  (vowel? (first wd)))

(define (vowel? letter)
  (member? letter '(a e i o u)))

(define (new-if test then-case else-case)
  (if test
    then-case
    else-case))

#|
Your explanation here

In Scheme, Applicative Order is used for evaluation of expressions rather than
Normal Order. In applicative order, ALL the arguments to procedures are evaluated
when the procedure is applied (when the function is called). Because of that,
if we use `new-if` in a recursive function, the program will never stop evaluating
the arguments given to `new-if` as at least one of them is calling itself and
feeding again the same arguments to `new-if`. Because our `new-if` is a NORMAL
procedure and is following the Scheme's general rule of evaluation, it's simply not
suitable for the job, not like `if`, which is a SPECIAL form, and has its own
particular evaluation rule.
|#

; Exercise 4 - Define squares

(define (squares sent)
  ; Your code here
  (error "Not yet implemented")
)

; Exercise 5 - Define switch

(define (switch sent)
  ; Your code here
  (error "Not yet implemented")
)

; Exercise 6 - Define ordered?

(define (ordered? sent)
  ; Your code here
  (error "Not yet implemented")
)

; Exercise 7 - Define ends-e

(define (ends-e sent)
  ; Your code here
  (error "Not yet implemented")
)

; Exercise 8

#|

Your explanation here

|#