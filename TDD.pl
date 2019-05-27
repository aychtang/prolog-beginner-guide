:- initialization main.

equals(T, A, A) :-
    format("PASS: \"~w\" ~n", [T]).

equals(T, A, B) :-
    format("FAILED: \"~w\" - expected ~w and got ~w ~n", [T, A, B]).

main :-
    equals("One equals one", 1, 1),
    equals("Two equals two", 2, 2),
    equals("Three equals three", 3, 2),
    halt.
