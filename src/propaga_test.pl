%%%
%
% Baltasar Dinis
%
% Tests the propaga/3 predicate
%
%%%

:- [proj].
:- ['../exemplos_puzzles'].

test(Test_number) :-
  puzzle(5_1, Puz),
  pos(Test_number, Pos),
  sol(Test_number, Sol),
  propaga(Puz, Pos, Posicoes),
  Sol = Posicoes.

pos(1, (1, 5)).
pos(2, (3, 1)).
pos(3, (1, 3)).

sol(1, [(1, 5), (2, 5), (3, 5), (4, 5)]).
sol(2, [(3, 1), (4, 1), (5, 1)]).
sol(3, [(1, 3)]).
