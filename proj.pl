% 89416 Baltasar Azevedo e Silva Dinis 
% Projeto LP
%
% Puzzles Termometros

%importa puzzles exemplos
:- [exemplos_puzzles].




% propaga(Puz, Pos, Posicoes)
%
% preencher Pos implica preencher todos os elementos de Posicoes
%
% dependencias:
% * propaga_aux
% * term
%   ** term_aux, isin

propaga(Puz, Pos, Posicoes) :-
  term(Puz, Pos, Term),
  propaga_aux(Pos, Term, Posicoes).

% constroi a lista de posicoes a preencher
propaga_aux(Pos, [Pos|_], [Pos]).
propaga_aux(Pos, [H|T], [H|Tail]) :- propaga_aux(Pos, T, Tail).


% term(Puz, Pos, Term)
%
% a posicao Pos esta no termometro Term

term([Terms|_], Pos, Term) :- term_aux(Terms, Pos, Term).

% se o termometro da cabeça da lista contem a posicao Pos, e o resultado
term_aux([Term|_], Pos, Term) :- isin(Pos, Term).
% senao, procura no resto da lista
term_aux([_|T], Pos, Term) :- term_aux(T, Pos, Term).
% senao existir, retorna falso

% se esta na cabeça retorna,
% senao, procura no resto da lista
isin(Pos, [Pos|_]).
isin(Pos, [H|T]) :- 
  \+ Pos == H,
  isin(Pos, T).
