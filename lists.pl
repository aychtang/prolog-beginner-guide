numbers([1, 2, 3]).

count([], A, A).
count([H | T], A, N):-
    A1 is A + 1,
    count(T, A1, N).

member([], E):-
    false.
member([H, T], E);-
    H = E;
    member(T, E).
