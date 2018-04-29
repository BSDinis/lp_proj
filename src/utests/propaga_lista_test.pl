%%%
%
% Baltasar Dinis
%
% Tests the propaga_lista/3 predicate
%
%%%

:- ['../proj'].
:- ['../../exemplos_puzzles'].

test(Test_n) :-
  puzzle(5_1, Puz),
  lista(Test_n, L),
  propaga_lista(Puz, L, Propagada),
  sol(Test_n, Sol),
  write(Propagada), nl, write(Sol),
  Sol == Propagada.


lista(1, [(1,5), (3,1), (1,3)]).
lista(2, [(1,1), (1,4), (3,3), (3,4)]).
lista(3, [(5,2), (5,4), (4,4)]).
lista(4, []).
lista(5, [(1,1),(1,2),(1,3)]).

sol(1, L) :- sort([(1,5), (2,5), (3,5), (4,5), (3,1), (4,1), (5,1), (1,3)], L).
sol(2, L) :- sort([(1,1), (1,2), (1,3), (1,4), (3,3), (2,3), (3,4), (2,4), (1,4)], L).
sol(3, L) :- sort([(5,2), (4,2), (5,4), (5,3), (4,4),(3,4), (2,4), (1,4)], L).
sol(4, []).
sol(5, [(1,1),(1,2),(1,3)]).
