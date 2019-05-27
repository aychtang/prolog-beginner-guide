
## Guide to Prolog from the beginner:

# Table of Contents
1. [Intro](#intro)
2. [Facts](#facts)
    1. [Querying Facts](#querying-facts)
    2. [Substitution](#substitution)
3. [Rules](#rules)
    1. [Combining fact checks](#combining-fact-checks)
    2. [Comparing fact checks with different arguments](#comparing-fact-checks-with-different-arguments)
    3. [Composing fact checks](#composing-fact-checks)
    4. [Finding all solutions to a rule](#finding-all-solutions-to-a-rule)
4. [Using SWI-Prolog](#using-swi-prolog)
5. [Lists](#lists)
    1. [Recursion with lists](#recursion-with-lists)

Intro
======

What is prolog anyway? It is a logic based programming language where you define a set of facts that live inside the program, and can build rules that operate upon those facts to work toward a goal.

Facts:
======
The syntax for defining a fact, is to have the fact name followed by its relations followed by a `.`:

```
male(zeus).
female(mnemosyne).
female(clio).

parent(zeus, clio).
parent(mnemosyne, clio).
```

This block of code then is defining a few facts within the universe of the program:

```
There is a male Zeus.
There is a female Mnemosyne.
There is a female Clio.

Zeus is the parent of Clio.
Mnemosyne is the parent of Clio.
```

#### Querying facts:
When running this code with a Prolog interpreter we can then run some queries on this set of facts and look at some cool features of Prolog already:

You can execute a fact with arguments to see if the relation exists in the universe:
```
male(zeus). % true.
female(mnemosyne). % true.
female(zeus). % false.

parent(zeus, clio). % true.
parent(zeus, mnemosyne). % false.
```

#### Substitution:
You can also leave out an argument of a fact, to see if there are any valid substitutions:

```
male(X). % X = zeus.
female(X). % x = mnemosyne.

parent(X, clio). % X = zeus.
```

Rules
======
You can write rules which use or combine facts together to work toward a goal.


#### Combining fact checks

Let's say we want to find who the mother of a certain person is within our universe, and we wanted to do that through the interface `mother(parent, child)`. We could of course simply add a new fact into the universe, which declares the mother relationships that exist, however we can reduce the number of facts we have to declare by writing facts that can be possibly computed from existing relationships into these rules.

We can logically define a mother to be a parent of a child, who is also the female parent.

Expressed as a Prolog rule that would look something like this:
```
mother(P, C):-
    parent(P, C),
    female(P).

mother(X, clio). % X = mnemosyne.
```

Given an argument `P` and `C`, where the fact holds `parent(P, C)` and the fact holds `female(P)`. We can define that `P` to be the mother of `C`.


#### Comparing fact checks with different arguments

Clio was also given many sisters, so let's add one of them into our universe:

```
male(zeus).
female(mnemosyne).
female(clio).
female(euterpe).

parent(zeus, clio).
parent(mnemosyne, clio).
parent(zeus, euterpe).
parent(mnemosyne, euterpe).
```

How can we define a rule to check if Clio is a sibling of Euterpe?

We could say if they each have the same mother, then they are siblings. Expressed in Prolog this would look something like:
```
is_sibling(C1, C2):-
    mother(X, C1),
    mother(X, C2).

is_sibling(clio, euterpe). % true.
```
Given arguments `X`, `C1`, and `C2` if `mother(X, _)` holds true for both `C1` and `C2`, we can define `C1` and `C2` to be siblings.

#### Composing fact checks

Something missing from the `is_sibling` code above, would be siblings that share a father but not the mother, so we would have to make an adjustment to write a better version of the rule.

```
father(P, C):-
    parent(P, C),
    male(P).

is_sibling(C1, C2):-
    mother(X, C1), mother(X, C2);
    father(X, C1), father(X, C2).
```

Here we add the `father(P, C)` rule which was not yet defined, and also use it in `is_sibling`. The `;` symbol denotes a logical OR, so either the expression before it or after it has to hold true.

### Finding all solutions to a rule

By default in SWI-Prolog implementation, when you find the solution to a substitution in a rule, it returns the first valid result. A useful query to make would be to find all possible solutions to a substitution, for example what if I wanted to find all the parents of a person within our universe. To do that we can use the builtin `forall/3`.

`findall/3` takes three arguments `findall(Object, Goal, List)`.

```
findall(X, parent(X, clio), PS). # PS = [ zeus, mnemonsyne ]
```

By extension if we wanted to find all children of a person, we would be able to use findall with the arguments of parent swapped around.

```
findall(X, parent(zeus, X), CS). # CS = [ clio, euterpe ]
```

Using SWI-Prolog
======
The standard usage for `swipl` will be to load a file, it will then allow you to execute commands in a Prolog REPL environment. I've left a full program of the family tree code in the file `godfamily.pl`. Here is how you can load the file using `swipl`, execute a query, and then close the REPL.

```
$ swipl -l godfamily.pl

Welcome to SWI-Prolog (threaded, 64 bits, version 8.0.2)
SWI-Prolog comes with ABSOLUTELY NO WARRANTY. This is free software.
Please run ?- license. for legal details.
For online help and background, visit http://www.swi-prolog.org
For built-in help, use ?- help(Topic). or ?- apropos(Word).

?- findall(X, parent(zeus, X), CS).
CS = [clio, euterpe, thalia, melpomeni, terpsichore, erato, polymnia, ourania, calliope].

?- halt.

$
```

Lists
======

The returned value assigned to `CS` from the the command we executed in `swipl` is a list. We can tell it's a list since this is true:

```
is_list([clio, euterpe, thalia, melpomeni, terpsichore, erato, polymnia, ourania, calliope]) % true
```

#### Recursion with lists

Lists can be represented and unified as the head and tail of the list. You can define a parameter that takes a list type as `[head | tail]` where `head` will be the first element of the list, and `tail` will be the remaining elements of the list.

In order to recurse a list in prolog you must first define the base case to ensure it terminates, and then you can write the recusive logic in another rule definition that has `head` or `tail` values.

```
% First define the base case:
count([], A, A).

% Then write the recursive function:
count([H | T], A, C):-
    A1 is A + 1,
    count(T, A1, C).

count([1, 2, 3], S) # S = 3.
```

