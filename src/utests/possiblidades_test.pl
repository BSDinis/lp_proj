%%%
%
% Baltasar Dinis
%
% Tests the possibilidades_linha/5 predicate
%
%%%

:- ['../proj'].
:- ['../../exemplos_puzzles'].

test(Test_n) :-
  puzzle(5_1, Puz),
  posic(Test_n, Posicoes_linha),
  total(Test_n, Total),
  preench(Test_n, Ja_Preenchidas),
  possibilidades_linha(Puz, Posicoes_linha, Total, Ja_Preenchidas, Possibilidades_L),
  sol(Test_n, Sol),
  write(Possibilidades_L), nl, write(Sol),
  Sol == Possibilidades_L.


posic(1, [(1, 1),(1, 2),(1, 3),(1, 4),(1, 5)]).
posic(2, [(2, 1),(2, 2),(2, 3),(2, 4),(2, 5)]).
posic(3, [(3, 1),(3, 2),(3, 3),(3, 4),(3, 5)]).

total(1, 3).
total(2, 1).
total(3, 1).

preench(1, []).
preench(2, [(1,1), (1,2), (1,3)]).
preench(3, [(1,2), (1,3), (1,4), (2,2)]).

sol(1, [[(1,1), (1,2), (1,3)], [(1,2), (1,3), (1,4)]]).
sol(2, [[(2, 2)]]).
sol(3, [[(2,2), (3,2)], [(3,1), (4,1), (5,1)]]).
