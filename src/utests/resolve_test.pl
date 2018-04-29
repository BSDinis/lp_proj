%%%
%
% Baltasar Dinis
%
% Tests the nao_altera_linhas_anteriores/3 predicate
%
%%%

:- ['../proj'].
:- ['exemplos_puzzles'].

test(Test_n) :-
  find_puz(Test_n, Puz),
  sol(Test_n, Sol),
  resolve(Puz, Solucao),
  write(Sol), nl, write(Solucao),
  Sol == Solucao.

find_puz(1, Puz) :- puzzle(4_1, Puz).
find_puz(2, Puz) :- puzzle(5_1, Puz).
find_puz(3, Puz) :- puzzle(6_1, Puz).
find_puz(4, Puz) :- puzzle(7_1, Puz).

sol(1, Sol) :- solucao(4_1, Sol).
sol(2, Sol) :- solucao(5_1, Sol).
sol(3, Sol) :- solucao(6_1, Sol).
sol(4, Sol) :- solucao(7_1, Sol).

