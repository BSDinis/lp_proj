%%%
%
% Baltasar Dinis
%
% Tests the nao_altera_linhas_anteriores/3 predicate
%
%%%

:- ['../proj'].
:- ['exemplos_puzzles'].

test(Test_number) :-
  puzzle(5_1, Puz),
  preench(Test_number, Ja_Preenchidas),
  Dim is 5,
  poss(Test_number, Possibilidades),
  verifica_parcial(Puz, Ja_Preenchidas, Dim, Possibilidades).


preench(1, []).
preench(2, []).
preench(3, [(1,1), (1,2), (1,3)]).

poss(1, [(1,1), (1,2), (1,3)]).
poss(2, [(1,2), (1,3), (1,5), (2,5), (3,5), (4,5)]).
poss(3, [(2,3)]).

