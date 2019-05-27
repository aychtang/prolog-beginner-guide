
## Guide to Prolog from the beginner:

### Intro

What is prolog anyway? It is a logic based programming language where you define a set of facts that live inside the program, and can build rules that operate upon those facts to work toward a goal.

#### Facts:
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
male(zeus). # true.
female(mnemosyne). # true.
female(zeus). # false.

parent(zeus, clio). # true.
parent(zeus, mnemosyne). # false.
```

#### Substitution:
You can also leave out an argument of a fact, to see if there are any valid substitutions:

```
male(X). # X = zeus.
female(X). # x = mnemosyne.

parent(X, clio). # X = zeus.
```

### Writing rules
You can write rules with use or combine facts together to work toward a goal.

Let's say we want to find who the mother of a certain person is within our universe, and we wanted to do that through the interface `mother(parent, child)`. We could of course simply add a new fact into the universe, which declares the mother relationships that exist, however we can reduce the number of facts we have to declare by writing facts that can be possibly computed from existing relationships into these rules.

We can logically define a mother to be a parent of a child, who is also the female parent.

Expressed as a Prolog rule that would look something like this:
```
mother(P, C):-
    parent(P, C),
    female(P).

mother(X, clio). # X = mnemosyne.
```

Given an argument `P` and `C`, where the fact holds `parent(P, C)` and the fact holds `female(P)`. We can define that `P` to be the mother of `C`.
