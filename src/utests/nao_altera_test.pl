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
  pos(Test_n, Posicoes),
  linh(Test_n, L),
  ja_preench(Test_n, Ja_Preenchidas),
  nao_altera_linhas_anteriores(Posicoes, L, Ja_Preenchidas).

pos(1, [(2, 4), (1, 4)]).
pos(2, [(2, 4), (1, 4)]).

linh(1, 2).
linh(2, 2).

ja_preench(1, [(1, 1), (1, 2), (1, 3)]).
ja_preench(2, [(1, 2), (1, 3), (1, 4)]).
