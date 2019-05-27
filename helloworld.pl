hello_world :-
    write('hello world!'),
    nl.

main :-
    hello_world,
    halt.

:- initialization main.
