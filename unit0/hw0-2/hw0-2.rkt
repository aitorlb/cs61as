#lang racket

(require berkeley)
(provide (all-defined-out))

;Exercise 1
(define (second wd)
  (first (bf wd)))

#|
1. Define first-two

Write a procedure first-two that takes a word as its argument,
returning a two-letter word containing the first two letters of the argument.

-> (first-two 'ambulatory)
'am
|#

(define (first-two wd)
  (word (first wd) (second wd)))

#|
2. Define two-first

Write a procedure two-first that takes two words as arguments,
returning a two-letter word containing the first letters of the two arguments.

-> (first-two 'ambulatory)
'am
|#

(define (two-first x y)
  (word (first x) (first y)))

#|
3. Define two-first-sent

Now write a procedure two-first-sent that takes a two-word sentence as argument,
returning a two-letter word containing the first letters of the two words.

-> (two-first-sent '(brian epstein))
'be
|#

(define (two-first-sent sent)
  (word (first (first sent)) (first (last sent))))

#|
Exercise 2 - Define teen?

Write a predicate teen? that returns #t if its argument is between 13 and 19, inclusive.

-> (teen? 19)
#t
-> (teen? (/ 39 2))
#f
|#

(define (teen? num)
  (and (>= num 13) (<= num 19)))

#|
Exercise 3 - Define indef-article

Write a procedure indef-article that takes in a word as its only argument and
returns a sentence. See examples below for how indef-article should work.
Remember that the indefinite article for anything that starts with a consonant
is "a", and the indefinite article for anything that starts with a vowel is "an".
You can ignore any edge cases.

-> (indef-article 'beetle)
'(a beetle)
-> (indef-article 'apple)
'(an apple)
|#

(define (vowel? letter)
  (member? letter 'aeiou))

(define (indef-article wd)
  (if (vowel? (first wd))
      (sentence 'an wd)
      (sentence 'a wd)))

#|
Exercise 4 - Define insert-and

Write a procedure insert-and that takes a sentence of items and returns a new
sentence with an and in the grammatically correct place.

-> (insert-and '(john bill wayne fred joey))
'(john bill wayne fred and joey)
|#

(define (insert-and sent)
  (sentence (butlast sent) 'and (last sent)))

#|
Exercise 5 - Define query

Write a procedure query that turns a statement into a question by swapping the
first two words and adding a question mark to the end of the last word.
You can ignore any edge cases.

-> (query '(you are experienced))
'(are you experienced?)
-> (query '(i should have known better))
'(should i have known better?)
-> (query '(you were there))
'(were you there?)
|#

(define (query sent)
 (sentence (first (bf sent)) (first sent) (bf (bf (bl sent))) (word (last sent) '?)))

#|
Exercise 6 - Define european-time and american-time

Write a procedure european-time to convert a time from American AM/PM notation into European 24-hour notation. Also, write american-time, which does the opposite.

-> (european-time '(8 am))
8
-> (european-time '(4 pm))
16
-> (european-time '(12 am))
0
-> (european-time '(12 pm))
12

-> (american-time 21)
'(9 pm)
-> (american-time 12)
'(12 pm)
|#

(define (european-time time)
  (define period (last time))
  (define hour (first time))
  (match period
        ['am (if (= hour 12) 0   hour)]
        ['pm (if (= hour 12) 12  (+ hour 12))]))

(define (american-time time)
  (cond [(= time 0) (sentence 12 'am)]
        [(< time 12) (sentence time 'am)]
        [(= time 12) (sentence 12 'pm)]
        [(> time 12) (sentence (- time 12) 'pm)]))

#|
Exercise 7 - Define describe-time

Write a procedure describe-time that takes a number of seconds as its argument and returns a more useful description of that amount of time. Assume that there are 365.25 days in a year. You only need to account for time periods up to a day.

-> (describe-time 45)
'(45 seconds)

-> (describe-time 930)
'(15.5 minutes)

-> (describe-time 63000)
'(17.5 hours)

-> (describe-time 518400)
'(6 days)
|#

(define (describe-time secs)
  (define day 86400.0)
  (define hour 3600.0)
  (define minute 60.0)
  (cond [(>= secs day) (sentence (/ secs day) 'days)]
        [(>= secs hour) (sentence (/ secs hour) 'hours)]
        [(>= secs minute) (sentence (/ secs minute) 'minutes)]
        [else (sentence secs 'seconds)]))

#|
Exercise 8 - Explain why superlative doesnt work:

The following program doesn't work. Why not? Fix it and explain why.

(define (superlative adjective word)
  (se (word adjective 'est) word))

This is how superlative should work:

-> (superlative 'dumb 'exercise)
'(dumbest exercise)
|#

(define (superlative adj wd)
  (se (word adj 'est) wd))

#|

Explanation here.

The identifier `word` is already bound to a procedure.
We need to use another name for the second argument.

|#