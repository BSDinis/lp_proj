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
% nao_altera_linhas_anteriores(?Posicoes, +L, +Ja_Preenchidas)
%
% inputs:
%   Posicoes: possivel preenchimento da linha L, com a propagacao ja feita
%   Ja_Preenchidas: lista de posicoes ja preenchidas
%
% retorna falso se a lista de Posicoes causa conflitos com as posicoes
% ja preenchidas
%

nao_altera_linhas_anteriores([], _, _).
nao_altera_linhas_anteriores([(I, J)|Posicoes], L, Ja_Preenchidas) :-
  I < L,
  member((I, J), Ja_Preenchidas),
  nao_altera_linhas_anteriores(Posicoes, L, Ja_Preenchidas).

nao_altera_linhas_anteriores([(I, _)|Posicoes], L, Ja_Preenchidas) :-
  I >= L,
  nao_altera_linhas_anteriores(Posicoes, L, Ja_Preenchidas).


%% verifica_parcial/4
% verifica_parcial(+Puz, +Ja_Preenchidas, +Dim, ?Poss) 
%
% inputs:
%   Puz: puzzle
%   Ja_Preenchidas: posicoes preenchidas anteriormente
%   Dim: dimensao do puzzle
%   Poss: possibilidade para preencher a lista
%
% retorna falso se preencher uma linha com Poss faz com que se exceda o 
% total de uma das colunas
%
    
verifica_parcial([_, _, Tot_cols], Ja_Preenchidas, _, Poss) :- 
  append(Ja_Preenchidas, Poss, Conjunta),
  verifica_parcial(Tot_cols, Conjunta, 1).

%% verifica_parcial/3
% verifica_parcial(+Tot_cols, +Posicoes, +Col)
%
% inputs:
%   Tot_cols: totais por coluna
%   Posicoes: lista de posicoes (hipoteticamente) preenchidas
%   Col: coluna a testar de momento
%
% e aplicado recursivamente ate a lista Tot_cols ficar vazia

verifica_parcial([], _, _).
verifica_parcial([Tot|Tots], Posicoes, Col) :-
  verifica_parcial_coluna(Col, Tot, Posicoes),
  Next_Col is Col + 1,
  verifica_parcial(Tots, Posicoes, Next_Col).

%% verifica_parcial_coluna/3
% verifica_parcial_coluna(+Col, +Tot_col, +Posicoes)
%
% inputs:
%   Col: coluna a testar
%   Tot_col: maximo de posicoes preenchidas da coluna Col
%   Posicoes: lista de posicoes (hipoteticamente) preenchidas
%
% retorna falso se a solucao parcial para o puzzle dada por Posicoes 
% exceder o total da linha Col
% 

verifica_parcial_coluna(Col, Tot_col, Posicoes) :-
  soma_coluna(Col, Posicoes, Soma),
  Soma =< Tot_col.
  
%% soma_coluna/3
% soma_coluna(+Col, +Posicoes, -Soma) is det
%
% inputs:
%   Col: coluna a somar
%   Posicoes: posicoes (hipoteticamente) preenchidas
%
% output:
%   Soma: soma de posicoes cuja coluna e col
%%

soma_coluna(_, [], 0).

soma_coluna(Col, [(_, Col)|Pos], Soma) :-
  soma_coluna(Col, Pos, Parc_Soma),
  Soma is Parc_Soma + 1.

soma_coluna(Col, [(_, J)|Pos], Soma) :-
  J \= Col,
  soma_coluna(Col, Pos, Soma).





  


