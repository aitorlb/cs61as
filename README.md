# CS 61AS. The Structure and Interpretation of Computer Programs (Self-Paced)

>CS 61AS is an introductory computer science class at the University of California, Berkeley. We use course material derived from the classic textbook Structure and Interpretation of Computer Programs, as well as newer content developed here at Berkeley. Our primary programming languages are Racket and Scheme.

[Course website](https://berkeley-cs61as.github.io/index.html)

To install racket:
```console
sudo apt-get update
sudo apt-get install racket
```
To install necessary [support library](https://pkgs.racket-lang.org/package/berkeley):
```console
raco pkg install berkeley
```

To run the autograder:
```console
# From the parent directory
racket -tm grader.rkt -- example/example-tests.rkt example/example.rkt
# From a child directory
racket -tm ../grader.rkt -- example-tests.rkt example.rkt
```