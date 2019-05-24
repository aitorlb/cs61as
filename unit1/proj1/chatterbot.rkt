#lang racket

(require (planet dyoo/simply-scheme))
(provide (all-defined-out))

;;Begin Project 1
(require "adjectives.rkt")

;;Below is some procedures to help you out. Dont worry about what it says or does.
;;Questions are below.

(define (want-exit? line)
  (or (member? 'exit line) (member? 'quit line) (member? 'bye line)))

(define (print-sentence sent)
  (for-each (lambda (x) (display x) (display " "))
            sent)
  (newline))

(define (interact bot)
  (define (helper)
    (display "CB> ") (flush-output)
    (let ([line (read-line)])
      (unless (want-exit? line)
        (print-sentence (bot line))
        (helper))))
  (read-line)
  (helper))

(define (chatter bot1 bot2 start iterations)
  (define (helper b1 b2 sent i)
    (when (< i iterations)
          (display "bot ") (display (add1 (remainder i 2))) (display ": ")
          (let ((out (b1 sent)))
            (print-sentence out)
            (helper b2 b1 out (add1 i)))))
  (display "start: ") (print-sentence start)
  (helper bot1 bot2 start 0))

;;; Checks if a given word is an adjective or not
;;; Requires adjectives.scm to be loaded beforehand
(define adjective?
  (let ((hash (make-hash)))
    (for-each (lambda (adj)
		(hash-set! hash adj #t))
	      adjectives)
    (lambda (wd) (hash-ref hash wd #f))))


;; Begin Questions:
;;Q1 - babybot
(define (babybot sent) sent)

;;Q2 - stupidbot-creator
(define (stupidbot-creator motto)
 (lambda (sent) motto))

;;Q3 - matcherbot-creator
(define (matcherbot-creator pattern)
  (define (matcherbot sent)
    (cond
      [(empty? pattern) sent]
      [(and (member (first pattern) sent) (list-prefix? pattern (member (first pattern) sent))) (list-tail (member (first pattern) sent) (length pattern))]
      [else #f]))
  matcherbot)


;;Q4 - substitutebot-creator
(define (substitutebot-creator from to) ;; assumes the sentences are of equal length.
  (define (substitute sent old-words new-words) ;; from hw2-ex1
    (cond
      [(empty? old-words) sent]
      [(empty? sent) '()]
      [(equal? (first sent) (first old-words)) (se (first new-words) (substitute (bf sent) (bf old-words) (bf new-words)))]
      [else (se (first sent) (substitute (bf sent) old-words new-words))]))
  (lambda (sent) (substitute sent from to)))

;;Q5 - switcherbot
(define (switcherbot sent)
  (define (switch sent) ;; from hw1-ex5
    (define (switch-word wd) ;; word mapping
      (case wd
        ['I 'you]
        ['me 'you]
        ['you 'me]
        ['am 'are]
        ['are 'am]
        ['was 'were]
        ['were 'was]
        ['my 'your]
        ['your 'my]
        ['mine 'yours]
        ['yours 'mine]
        [else wd]))
    (define (switch-aux sent) ;; handles general case
      (if (empty? sent)
          '()
          (se (switch-word (first sent)) (switch-aux (bf sent)))))
    (if (equal? (first sent) 'you) ;; handles special case at beginning of the sentence
        (se 'I (switch-aux (bf sent)))
        (se (switch-word (first sent)) (switch-aux (bf sent)))))
  (switch sent))

;;Q6 - inquisitivebot
(define (inquisitivebot sent)
  (if (empty? sent)
      sent
      (se (switcherbot sent) '?)))

;;Q7 - eliza
(define (eliza sent)
  (define i-am-sent ((matcherbot-creator '(I am)) sent))
  (cond
    [(empty? sent) '(how can I help you ?)]
    [(equal? (first sent) 'hello) '(hello there!)]
    [(equal? (last sent) '?) '(I can not answer your question.)]
    [(not (false? i-am-sent)) (se '(why are you) (inquisitivebot i-am-sent))]
    [else (switcherbot sent)]))

;;Q8 - reactorbot-creator
  (define (reactorbot-creator bot pat out)
    ;;insert your answer here
    (error "not yet implemented")
  )

;;Q9 - replacerbot-creator
  (define (replacerbot-creator bot pat before after)
    ;;insert your answer here
    (error "not yet implemented")
  )

;;Q10 - exagerate
  (define (exaggerate bot n)
    ;;insert your answer here
    (error "not yet implemented")
  )

;;REMEMBER TO ADD YOUR OWN TESTS TO GRADER.RKT!
;;END OF PROJECT 1