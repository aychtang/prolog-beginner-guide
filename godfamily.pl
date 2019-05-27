male(zeus).

female(mnemosyne).
female(clio).
female(euterpe).
female(thalia).
female(melpomeni).
female(terpsichore).
female(erato).
female(polymnia).
female(ourania).
female(calliope).

parent(zeus, clio).
parent(zeus, euterpe).
parent(zeus, thalia).
parent(zeus, melpomeni).
parent(zeus, terpsichore).
parent(zeus, erato).
parent(zeus, polymnia).
parent(zeus, ourania).
parent(zeus, calliope).
parent(mnemosyne, clio).
parent(mnemosyne, euterpe).
parent(mnemosyne, thalia).
parent(mnemosyne, melpomeni).
parent(mnemosyne, terpsichore).
parent(mnemosyne, erato).
parent(mnemosyne, polymnia).
parent(mnemosyne, ourania).
parent(mnemosyne, calliope).

father(P, C):-
    parent(P,C),
    male(P).

mother(P, C):-
    parent(P, C),
    female(P).

is_sibling(C1, C2):-
    mother(X, C1), mother(X, C2), C1\=C2;
    father(X, C1), father(X, C2), C1\=C2.
