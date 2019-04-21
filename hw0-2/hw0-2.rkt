#lang racket

(require berkeley)
(provide (all-defined-out))

;Exercise 0
;Write 5 expressions whose values are the number ten:
;1. Atom

;2. Compound Expression (3 Atoms)

;3. Compound Expression (4 Atoms)

;4. Compound Expression (1 Atom and 2 subexpressions)

;5. Any Other Kind Expression


;Exercise 1
(define (second wd)
  (first (bf wd)))

;1. Define first-two
#|

Write a procedure first-two that takes a word as its argument,
returning a two-letter word containing the first two letters of the argument.

-> (first-two 'ambulatory)
'am

|#

(define (first-two wd)
  (word (first wd) (second wd)))

;;2. Define two-first
#|

Write a procedure two-first that takes two words as arguments,
returning a two-letter word containing the first letters of the two arguments.

-> (first-two 'ambulatory)
'am

|#

(define (two-first x y)
  (word (first x) (first y)))

;;3. Define two-first-sent
#|

Now write a procedure two-first-sent that takes a two-word sentence as argument,
returning a two-letter word containing the first letters of the two words.

-> (two-first-sent '(brian epstein))
'be

|#

(define (two-first-sent sent)
  (word (first (first sent)) (first (last sent))))

;Exercise 2 - Define teen?
#|

Write a predicate teen? that returns #t if its argument is between 13 and 19, inclusive.

-> (teen? 19)
#t
-> (teen? (/ 39 2))
#f

|#

(define (teen? num)
  (and (>= num 13) (<= num 19)))

;Exercise 3 - Define indef-article
#|

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
  (cond ((vowel? (first wd)) (sentence 'an wd))
        ((false? (vowel? (first wd))) (sentence 'a wd))))

;Exercise 4 - Define insert-and
(define (insert-and sent)
  ; your code here
  (error "Not yet implemented")
)

;Exercise 5 - Define query
(define (query sent)
  ; your code here
  (error "Not yet implemented")
)

;Exercise 6 - Define european-time and american-time
(define (european-time time)
  ; your code here
  (error "Not yet implemented")
)

(define (american-time time)
  ; your code here
  (error "Not yet implemented")
)

;Exercise 7 - Define describe-time
(define (describe-time secs)
  ; your code here
  (error "Not yet implemented")
)

;Exercise 8 - Explain why superlative doesnt work:
(define (superlative adjective word)
  (se (word adjective 'est) word))

#|

Explanation here.

|#