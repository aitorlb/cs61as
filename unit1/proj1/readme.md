# Project 1: ChatterBot

We expect this project to take about one week. It will be due by the Unit 1
deadline. You may not work on this project with another student, but feel free
to ask the staff for help.

In this project, you will create a variety of ChatterBots. A ChatterBot is a
function that takes in a sentence representing what a user said and outputs a
sentence, which is the ChatterBot's reply. Some ChatterBots will require no
arguments while others will require one or more. You will also be required to
create a general template for ChatterBots.

You will start from a simple ChatterBot and add features until you create a
simplified version of eliza, a Rogerian psychotherapist program. An example
of eliza can be found here: http://nlp-addiction.com/eliza/.

To run the autograder:
```bash
$ cd unit1/proj1
$ racket -tm grader.rkt -- chatterbot.rkt
```

## Part 1: babybot
There are many different types of ChatterBots that have varying levels of
difficulty. They will evolve as your programming skills evolve throughout
this project. Let's start with the simplest of them all!

Create a baby ChatterBot called babybot that repeats exactly what you say.
babybot will take in a sentence and output a sentence.

You can try interacting with your very simple bot by loading chatterbot.rkt
and calling the "interact" function. It takes in a bot, and starts a
conversation with them.

Example:
```racket
-> (interact babybot)
CB> hey there
hey there
CB> are you repeating everything I said?
are you repeating everything I said
CB> bye
okay
->
```

## Part 2: stupidbot-creator
Creating a ChatterBot one at a time is hard work, especially for stupid
ChatterBots. We need a procedure that makes it easy to create a lot of
ChatterBots. Write a procedure, stupidbot-creator, which takes in a sentence
called MOTTO and outputs a ChatterBot. The outputted ChatterBots will take in
one sentence and regardless of the input, this stupid ChatterBot will output
MOTTO.

Example:
```racket
-> (define dalek (stupidbot-creator '(exterminate!)))
-> (dalek '(I am the doctor!))
'(exterminate!)
-> (dalek '(doctor who?))
'(exterminate!)
-> (dalek '(bow ties are cool))
'(exterminate!)
```

## Part 3: matcherbot-creator
Sometimes, quality beats quantity. A ChatterBot that only repeats what you tell
it is a little useless. We need to give it a bit of an upgrade. Bots should
differ their output based on their input. It is important to remember that a
ChatterBot can only take in a sentence.
Write a procedure called matcherbot-creator that will take in a sentence,
PATTERN, and output a ChatterBot, OUT. The resulting ChatterBot OUT takes in a
sentence, SENT. If PATTERN is a part of SENT, the chatter-matcher should return
everything that follows the first appearence of PATTERN in SENT. If PATTERN is
not in SENT, return #f. If PATTERN is at the very end of the sentence, return
the empty sentence. If PATTERN is the empty sentence, return SENT.

Example:
```racket
-> (define cedric (matcherbot-creator '(hufflepuffs are great)))
-> (cedric '(hufflepuffs are great finders))
'(finders)
-> (cedric '(what the heck is a hufflepuff))
#f
-> (cedric '(slytherins hate hufflepuffs but hufflepuffs are great finders))
'(finders)
```

## Part 4: substitutebot-creator
In addition to being able to match parts of a sentence, a ChatterBot should
change the meaning of what it says depending on your input. Write a procedure
called substitutebot-creator that takes in two same-length sentences, FROM and
TO, and outputs a ChatterBot. The first item of FROM and TO are associated, as
are the second two items, the third, etc. The outputted ChatterBot will take in
a sentence, SENT, and output a new sentence where every word in SENT that is a
member of FROM is replaced with its corresponding word in TO. If FROM and TO
are empty sentences, the ChatterBot will simply return SENT

Example:
```racket
-> (define marions-vacay (substitutebot-creator '(indonesia winter noodles) '(texas summer steak)))
-> (marions-vacay '(I visited indonesia this winter and ate noodles))
(I visited texas this summer and ate steak)
```

## Part 5: switcherbot
To further mirror human conversation, our ChatterBot needs to be able to take
in statements and assign the facts to the right people. If I say '(I am reia),
the ChatterBot should not reply with '(I am reia), because it should be smart
enough to know that it is not also reia. This ChatterBot will switch perspective
by changing any sentence in first person to second person and vice versa.
switcherbot takes in a sentence SENT and outputs SENT with its viewpoint switched.

Rules:
- Every instance of 'you is replaced by 'me except at the beginning of the sentence, where it's replaced by 'I.
- Do not worry about contractions, compound sentences, or other grammatical edge cases.
- List of viewpoints:
  - me <-> you
  - I <-> you
  - am <-> are
  - was <-> were
  - my <-> your
  - yours <-> mine

Example:
```racket
-> (switcherbot '(you are reia but I am a bird))
(I am reia but you are a bird)
```

## Part 6: inquisitivebot
Therapists need to be able to ask questions. In our next step towards creating
eliza, we will create a new ChatterBot that really likes to ask questions. It
will take in a sentence SENT in the first person and rephrase it into a question
in the second person. The question mark should not be part of the last word. If
SENT is the empty sentence, inquisitivebot should return the empty sentence with
no question mark.

Example:
```racket
-> (inquisitivebot '(I am happy))
(you are happy ?)
-> (inquisitivebot '(I can see you))
(you can see me ?)
```

## Part 7: eliza
It's time to put eliza together. eliza is a simplified Rogerian psychotherapist.
It will respond to facts by repeating them and associating them to the correct
subject.

Here is a list of rules that eliza will comply to:
- eliza will reply '(hello there!) to any sentence where the first word is 'hello.
- It will reply to statements that contain '(I am) by:
  - removing '(I am) and anything before it from the beginning of the sentence
  - switching the perspective of everything after
  - prepending '(why are you) to the beginning of the sentence
- If you ask a question, i.e. any statement where the last word is '?, eliza  will reply with '(I can not answer your question.)
- If the empty sentence is entered, eliza should answer with (how can I help you ?).
- If any other statement is made, eliza should reply with the same statement except with its perspective switched.

Example:
```racket
-> (eliza '(hello))
(hello there!)
-> (eliza '(I am excited to finish unit 1))
(why are you excited to finish unit 1 ?)
-> (eliza '(you are happy to see me))
(I am happy to see you)
```

## Part 8: reactorbot-creator
Now, create procedure called reactorbot-creator that takes a ChatterBot BOT, a
sentence PAT, and a sentence OUT. This will output another ChatterBot that
works just like BOT except when PAT is in the input. When PAT is in the input,
return OUT.

Example:
```racket
-> (define stupidbot (stupidbot-creator '(I am Groot)))
-> (define groot (reactorbot-creator stupidbot '(no Groot youll die why are you doing this) '(WE are Groot)))
-> (groot '(whats up groot))
(I am Groot))
-> (groot '(no Groot youll die why are you doing this))
(WE are Groot)
```

## Part 9: replacerbot-creator
Next door to the reactorbot-creator lives a very similar creator called the
replacerbot-creator. The replacerbot-creator acts similarly to the
reactorbot-creator. It takes in a ChatterBot BOT, a sentence PAT, a sentence
BEFORE, a sentence AFTER and returns a new ChatterBot. This ChatterBot
should act the same as BOT, except when it finds PAT anywhere in the input sentence,
where it should:
- remove the first instance of PAT and everything before it from SENT
- prepend BEFORE to the beginning of SENT
- append AFTER to the end of SENT


Example:
```racket
-> (define stupidbot (stupidbot-creator '(thats nice)))
-> (define dadbot (replacerbot-creator stupidbot '(I am) '(hi) '(im dadbot)))
-> (dadbot '(youre pretty dumb))
'(thats nice)
-> (dadbot '(I am hungry))
'(hi hungry im dadbot)
```

## Part 10: exagerate
Write the procedure exaggerate that takes in a bot. BOT1 and a number N. It returns
a new bot, BOT. BOT takes in a sentence, and responds how BOT1 would except that
it prepends 'very' before any adjective in its response.
The bot inspects its output and repeats this process N times.

Example:
```racket
-> (define exaggerated-babybot1 (exaggerate babybot 1))
-> (exaggerated-babybot1 '(this soup is hot and tasty))
(this soup is very hot and very tasty)
```

In the file "chatterbot.rkt", we have defined the function adjective? that takes
in a word and returns #t if it is an adjective.

Example:
```racket
-> (adjective? 'hot)
#t
->(adjective? 'computer)
#f
```
