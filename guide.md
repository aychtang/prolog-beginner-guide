## Guide to Prolog from the beginner:

### Intro

What is prolog anyway? It is a logic based programming language where you define a set of facts that live inside the program, and can build rules that operate upon those facts to work toward a goal.

The syntax for defining a fact, is to have the fact name followed by its relations followed by a `.`:

```
male(zeus).
female(mnemosyne).
female(clio).

parent(zeus, clio).
parent(mnemosyne, clio).
```

This block of code defines a few facts:

```
There is a male Zeus.
There is a female Mnemosyne.
There is a female Clio.

Zeus is the parent of Clio.
Mnemosyne is the parent of Clio.
```

When running this code with a Prolog interpreter we can then run some queries on this set of facts and look at some cool features of Prolog already:

You can execute a fact with arguments to see if the relation exists in the universe:
```
male(zeus). # true.
female(mnemosyne). # true.
female(zeus). # false.

parent(zeus, clio). # true.
parent(zeus, mnemosyne). # false.
```

You can also leave out an argument of a fact, to see if there are any valid substitutions:

```
male(X). # X = zeus.
female(X). # x = mnemosyne.

parent(X, clio). # X = zeus.
```