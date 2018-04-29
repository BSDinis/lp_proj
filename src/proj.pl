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


%% possibilidades_linha/5
% possibilidades_linha(+Puz, +Posicoes_linha, 
%                        +Total, +Ja_Preenchidas, -Possibildades_L)
%
% inputs:
%   Puz: puzzle
%   Posicoes_linha: posicoes da linha L
%   Total: total de posicoes a preencher na linha L
%   Ja_Preenchidas: posicoes ja preenchidas por linhas anteriores
% 
% output:
%   Possibilidades_L: lista ordenada das possibilidades para 
%   preencher a linha L
%

possibilidades_linha(Puz, Posicoes_linha, Total, Ja_Preenchidas, Possibilidades_L) :-
  findall(Poss, gera_possibilidade(Puz, Posicoes_linha, Total, Ja_Preenchidas, Poss), Aux),
  sort(Aux, Possibilidades_L).


%% gera_possibilidade/5
% gera_possibilidade(+Puz, +Posicoes_linha, +Total, +Ja_Preenchidas, -Poss)
%
% inputs:
%   Puz: puzzle
%   Posicoes_linha: posicoes da linha em questao
%   Total: posicoes a preencher na linha em questao
%   Ja_Preenchidas: posicoes ja preenchidas,
%
% output:
%   Poss: uma possibilidade de preencher a linha em questao
%
% condicoes:
%   comprimento de Poss == Total
%
%   Pos pertence a Poss => propaga(Puz, Pos, Posicoes), Posicoes subconjunto Poss
%     - garantida por construcao
%     
%   propriedade_1:
%     Pos pertence a Poss, Pos nao pertence a Posicoes_linha => Pos pertence a Ja_Preenchidas
%
%   propriedade_2:
%     Pos pertence a Ja_Preenchidas, Pos pertence a Posicoes_linha => Pos pertence a Poss
%
%   verifica_parcial(Puz, Ja_Preenchidas, Dim, Poss).

gera_possibilidade(Puz, Posicoes_linha, Total, Ja_Preenchidas, Poss) :-
  combinacao(Posicoes_linha, Aux),
  propaga_lista(Puz, Aux, Poss),
  length(Poss, Total),
  propriedade_1(Posicoes_linha, Ja_Preenchidas, Poss),
  propriedade_2(Posicoes_linha, Ja_Preenchidas, Poss),
  dim_puz(Puz, Dim),
  verifica_parcial(Puz, Ja_Preenchidas, Dim, Poss).


%% combinacao/2
% combinacao(+L1, -L2)
%
% input:
%   L1: lista de elementos
%
% output:
%   L2: combinacao dos elementos de L1.
%
% Faz uso do nao determinismo para computar L2.


combinacao([], []).
combinacao([_|T], T2) :- combinacao(T, T2).
combinacao([H|T], [H|T2]) :- combinacao(T, T2).

%% propaga_lista/3
% propaga_lista(+Puz, +L, -Propagada)
%
% input:
%   Puz: puzzle
%   L: lista
%
% output:
%   Propagada: lista onde estão unidas todas as propagacoes, ie
%
%   Pos pertence a Propagada => propaga(Puz, Pos, Posicoes), Posicoes subconjunto de Propagada

propaga_lista(_, [], []).

propaga_lista(Puz, [Pos|Resto], Propagada) :-
  propaga(Puz, Pos, Posicoes),
  propaga_lista(Puz, Resto, Parc),
  append(Posicoes, Parc, Aux),
  sort(Aux, Propagada).


%% propriedade_1/3
% propriedade_1(+L1, +L2, +L3)
%
% verifica se a seguinte propriedade se verifica:
%   X pertence a L3, X nao pertence a L1 => Pos pertence a L2
%   equiv: L3 \ L1 subconjunto de L2

propriedade_1(L1, L2, L3) :-
  subtract(L3, L1, Res),
  subset(Res, L2).

%% propriedade_2/3
% propriedade_2(+L1, +L2, +L3)
%
% verifica se a seguinte propriedade se verifica
%   X pertence a L1, X pertence a L2 => X pertence a L3
%   equiv: L1 intersc. L2 subconjunto de L3

propriedade_2(L1, L2, L3) :-
  intersection(L1, L2, Res),
  subset(Res, L3).


%% dim_puz/2
% dim_puz(+Puz, -Dim)
%
% input: puzzle
%
% output: dimensao do puzzle (== comprimento da ultima lista)
dim_puz([_, _|L], Dim) :-
  length(L, Dim).
