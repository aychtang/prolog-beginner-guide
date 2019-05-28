:- use_module(library(clpfd)).
:- initialization main.

equals(T, A, A) :-
    format("PASS: \"~w\" ~n", [T]).

equals(T, A, B) :-
    format("FAILED: \"~w\" - expected ~w and got ~w ~n", [T, A, B]).

square(N, R) :-
    R #= N * N.

main :-
    square(4, A), equals('square of 4 is 16', A, 16),
    square(B, 16), equals('sqrt of 16 is 4', B, 4),
    halt.
