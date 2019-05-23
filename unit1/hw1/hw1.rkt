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

#|
Exercise 4 - Define squares

Write a procedure squares that takes a sentence of numbers as its argument and
returns a sentence of the squares of the numbers.

-> (squares '(1 2 3))
(1 4 9)
|#

(define (squares sent)
  (if (empty? sent)
    '()
    (se (square (first sent)) (squares (bf sent)))))

#|
Exercise 5 - Define switch

Write a procedure switch that takes a sentence as its argument and returns a
sentence in which every instance of the words I or me is replaced by you, while
every instance of you is replaced by me except at the beginning of the sentence,
where it's replaced by I. (The word I is the only word that should be capitalized.)

Write a helper function that just handles the general case of the problem—that is,
your helper shouldn't worry about the "except at the beginning of the sentence"
part. Then write switch using that helper function and handle the special case in
the body of switch.

-> (switch '(you told me that I should wake you up))
(I told you that you should wake me up)
|#

(define (switch-word wd)
  (case wd
    ['I 'you]
    ['me 'you]
    ['you 'me]
    [else wd]))

(define (switch-aux sent)
  (if (empty? sent)
    '()
    (se (switch-word (first sent)) (switch-aux (bf sent)))))

(define (switch sent)
  (if (equal? (first sent) 'you)
    (se 'I (switch-aux (bf sent)))
    (se (switch-word (first sent)) (switch-aux (bf sent)))))

#|
Exercise 6 - Define ordered?

Write a predicate ordered? that takes a sentence of numbers as its argument and
returns #t if the numbers are in ascending order, or #f otherwise.

-> (ordered? '(1 2 3))
#t
-> (ordered? '(2 1 3))
#f
-> (ordered? '(2))
#t
|#


(define (ordered? sent)
  (cond
    [(< (count sent) 2) #t]
    [(> (first sent) (first (bf sent))) #f]
    [else (ordered? (bf sent))]))

#|
Exercise 7 - Define ends-e

Write a procedure ends-e that takes a sentence as its argument and returns a
sentence containing only those words that end in the letter E.

-> (ends-e '(please put the salami above the blue elephant))
(please the above the blue)
|#

(define (ends-e sent)
  (cond
    [(empty? sent) '()]
    [(equal? (last (first sent)) 'e) (se (first sent) (ends-e (bf sent)))]
    [else (se (ends-e (bf sent)))]))

#|
Exercise 8

Most versions of Lisp provide `and` and `or` procedures like the ones we've seen.
In principle, there is no reason why these can't be ordinary procedures,
but some versions of Lisp make them special forms.

Suppose, for example, we evaluate `(or (= x 0) (= y 0) (= z 0))`. If `or` is an
ordinary procedure, all three argument expressions will be evaluated before `or`
is invoked. But if the variable `x` has the value 0, we know that the entire
expression has to be true regardless of the values of `y` and `z`. A Lisp interpreter
in which `or` is a special form can evaluate the arguments one by one until either
a true one is found or it runs out of arguments.

Devise a test that will tell you whether Racket's `and` and `or` are special forms
or ordinary functions. This is a somewhat tricky problem, but it'll get you
thinking about the evaluation process more deeply. Why might it be advantageous
for an interpreter to treat `or` as a special form and evaluate its arguments one
at a time? Can you think of reasons why it might be advantageous to treat `or` as
an ordinary function?

Your explanation here

A couple of tests could be:

-> (or (= 0 0) (= "0" 0))
If `or` is a special form, it will return #t and the second argument won't be
evaluated, or else it would raise a `contract violation` error.

-> (and (= 1 0) (= "1" 0))
If `and` is a special form, it will return #f and the second argument won't be
evaluated, or else it would raise a `contract violation` error.

Treating them as special forms allows for short-circuit evaluation, which can
avoid run-time errors as we have seen.

|#