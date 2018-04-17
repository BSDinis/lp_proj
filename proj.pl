% 89416 Baltasar Azevedo e Silva Dinis 
% Projeto LP
%
% Puzzles Termometros

%importa puzzles exemplos
:- [exemplos_puzzles].



%------------------------ propaga(Puz, Pos, Posicoes) ------------------------%
% preencher Pos implica preencher todos os elementos de Posicoes
%
% dependencias:
% * propaga_aux
% * term
%   ** term_aux, isin

propaga(Puz, Pos, Posicoes) :-
  term(Puz, Pos, Term),
  propaga_aux(Pos, Term, Unsorted),
  sort(Unsorted, Posicoes).

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



%---------- nao_altera_linhas_anteriores(Posicoes, J, Ja_Preenchidas) ---------%
% Se preenchermos a linha L com Posicoes, todas as posicoes da lista que pertencem
% a linhas anteriores a L pertencem a Ja_Preenchidas
%
% dependencias: isin

nao_altera_linhas_anteriores([], _, _).
nao_altera_linhas_anteriores([(I, J)|T], N, Ja_Preenchidas) :-
  I < N,
  isin((I, J), Ja_Preenchidas),
  nao_altera_linhas_anteriores(T, N, Ja_Preenchidas).

nao_altera_linhas_anteriores([(I, _)|T], N, Ja_Preenchidas) :-
  I >= N,
  nao_altera_linhas_anteriores(T, N, Ja_Preenchidas).


%---------- verifica_parcial(Puz, Ja_Preenchidas, Dim, Poss) ---------%
% Dado o puzzle: Puz; com dimensao: Dim
% Dada a lista de posições ja preenchidas: Ja_Preenchidas
% Dada a lista de possibilidades a preencher para a linha N: Poss
%
% dependencias: 
%   * total_col, sub_total_col, col
%     ** elemento_k

verifica_parcial(_, _, _, []).
verifica_parcial(Puz, Ja_Preenchidas, Dim, [H|T]) :-
  col(H, J),
  total_col(Puz, J, Total),
  sub_total_col(J, Ja_Preenchidas, SubTotal),
  Parc is SubTotal + 1,
  Parc =< Total,
  verifica_parcial(Puz, Ja_Preenchidas, Dim, T).

% extrai do puzzle o total da linha J
total_col([_, _, Totais_Colunas], J, Total) :-
  length(Totais_Colunas, Dim),
  J =< Dim,
  elemento_k(Totais_Colunas, J, Total).

% calcula o sub_total da coluna J, dada a lista de posicoes preenchidas
sub_total_col(_, [], 0).
sub_total_col(J, [H|T], STotal) :- 
  col(H, JPos),
  JPos == J,
  sub_total_col(J, T, Parc),
  STotal is Parc + 1.

sub_total_col(J, [H|T], STotal) :- 
  col(H, JPos),
  JPos \= J,
  sub_total_col(J, T, Parc),
  STotal is Parc.
  
% extrai do puzzle o total da linha I
total_lin([_, Totais_Linhas, _], I, Total) :-
  length(Totais_Linhas, Dim),
  I =< Dim,
  elemento_k(Totais_Linhas, I, Total).




%---------- funcoes auxiliares -----------%
% isin(Termo, Lista)
% se esta na cabeça retorna,
% senao, procura no resto da lista
isin(Termo, [Termo|_]).
isin(Termo, [H|T]) :- 
  Termo \= H,
  isin(Termo, T).

% linha(Posicao, Linha): encontra a linha (1o elemento) de um tuplo
linha((I, _), I). 

% col(Posicao, Coluna): encontra a coluna (2o elemento) de um tuplo
col((_, J), J). 

% elemento_k(Lista, Pos, El): encontra o elemento da Lista na posicao Pos 
elemento_k([El|_], 1, El).
elemento_k([_|T], Pos, El) :-
  Pos > 1,
  NPos is Pos -1,
  elemento_k(T, NPos, El).

% encontra a dimensão do puzzle
% Dim Puzzle[Pos, Linhas, Colunas] = Dim Linhas
dim([_, Linhas, _], Len) :- length(Linhas, Len).


