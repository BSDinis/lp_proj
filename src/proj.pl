%%% Baltasar Dinis 89416
%
% Projeto de LP
%
% Solucionador de problemas de termometros
%
%%%

%%%
% Predicados Auxiliares
%%%


%%%
%% propaga
%%%

%% propaga/3
% propaga(+Puz, +Pos, -Posicoes) is det
%
% inputs:
%   Puz: lista com 3 listas: termometros, totais das linhas
%        e totais das colunas.
%
%   Pos: posicao preencher (tuplo)
%
% output:
%   Posicoes: dado o puzzle Puz, preencher a posicao Pos implica 
%   		  preencher as posicoes em Posicoes
%%

propaga([Terms|_], Pos, Posicoes) :- propaga_simpl(Terms, Pos, Posicoes).

%% propaga_simpl/3
% propaga(+Terms, +Pos, -Posicoes) is det
%
% inputs:
%   Terms: lista de termometros
%
%   Pos: posicao preencher (tuplo)
%
% output:
%   Posicoes: dada a lista de termometros Terms, preencher a posicao Pos
%   		  implica preencher as posicoes em Posicoes
%%
  
propaga_simpl([Term|_], Pos, Posicoes) :-
  member(Pos, Term),
  !,
  preenche_term(Term, Pos, Posicoes).

propaga_simpl([Term|Terms], Pos, Posicoes) :-
  \+ member(Pos, Term),
  propaga_simpl(Terms, Pos, Posicoes).

%% preenche_term/3
% preenche_term(+Term, +Pos, -Posicoes) is det
%
% inputs:
%   Term: termometro a ser preenchido (lista de tuplos)
%
%   Pos: posicao preencher (tuplo)
%
% output:
%   Posicoes: dado o puzzle Puz, preencher as posicoes Pos implica 
%   		  preencher as posicoes em Posicoes
%%

preenche_term(Term, Pos, Posicoes) :- 
  preenche_term(Term, Pos, [], Posicoes);


%% preenche_term/4
% preenche_term(+Term, +Pos, ?Parc, -Posicoes) is det
%
% inputs:
%   Term: termometro a ser preenchido (lista de tuplos)
%
%   Pos: posicao preencher (tuplo)
%
% output:
%   Posicoes: dado o puzzle Puz, preencher as posicoes Pos implica 
%   		  preencher as posicoes em Posicoes
%
% Parc: acumulador
%%

preenche_term([], _, Parc, Parc).

preenche_term([Pos|_], Pos, Parc, Posicoes) :-
  sort([Pos|Parc], Posicoes), !.

preenche_term([H|T], Pos, Parc, Posicoes) :-
  H \= Pos,
  preenche_term(T, Pos, [H|Parc], Posicoes).


%%%
%% nao_altera_linha_anteriores
%%%

%% nao_altera_linhas_anteriores/3
% nao_altera_linhas_anteriores(+Posicoes, +L, +Ja_Preenchidas)
%
% inputs:
%   Posicoes: possivel preenchimento da linha L
%   Ja_Preenchidas: lista de posicoes ja preenchidas
%
% retorna falso se a lista de Posicoes causa conflitos com as posicoes
% ja preenchidas
%

nao_altera_linhas_ateriores([], L, Ja_Preenchidas).
nao_altera_linhas_ateriores([Pos|Posicoes], L, Ja_Preenchidas) :-



  


