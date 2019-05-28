:- use_module(library(clpfd)).
:- initialization main.

equals(T, A, A) :-
    format("PASS: \"~w\" ~n", [T]).

equals(T, A, B) :-
    format("FAILED: \"~w\" - expected ~w and got ~w ~n", [T, A, B]).

sqrt(N, R) :-
    R #= N * N.

main :-
    sqrt(4, A), equals('sqrt of 4 is 16', A, 16),
    sqrt(B, 16), equals('Inverse sqrt of 16 is 4', B, 4),
    halt.
