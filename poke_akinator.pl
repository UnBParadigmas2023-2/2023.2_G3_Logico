:- dynamic dois_tipos/1.
:- dynamic pokemon/1.
:- dynamic cor/2.
:- dynamic tipo/2.
:- dynamic forma/2.
:- dynamic inicial/1.
:- dynamic lendario/1.
:- dynamic mitico/1.
:- dynamic evolui_para/2.
:- dynamic tem_cadeia_evo/1.
:- dynamic cadeia_tres_estags/1.
:- dynamic primeiro_estagio/1.
:- dynamic segundo_estagio/1.
:- dynamic terceiro_estagio/1.

pokemon(bulbasaur).
pokemon(ivysaur).
pokemon(venasaur).
pokemon(charmander).
pokemon(charmeleon).
pokemon(charizard).
pokemon(ponita).
pokemon(rapidash).
pokemon(mewtwo).

cor(bulbasaur, green).
cor(ivysaur, green).
cor(venasaur, green).
cor(charmander, orange).
cor(charmeleon, orange).
cor(charizard, orange).
cor(ponita, white).
cor(rapidash, white).
cor(mewtwo, white).

tipo(bulbasaur, grass).
tipo(ivysaur, grass).
tipo(venasaur, grass).
tipo(bulbasaur, poison).
tipo(ivysaur, poison).
tipo(venasaur, poison).
tipo(charmander, fire).
tipo(charmeleon, fire).
tipo(charizard, fire).
tipo(charizard, flying).
tipo(ponita, fire).
tipo(rapidash, fire).
tipo(mewtwo, psychic).

forma(bulbasaur, quadruped).
forma(ivysaur, quadruped).
forma(venasaur, quadruped).
forma(charmander, bipede).
forma(charmeleon, bipede).
forma(charizard, bipede).
forma(ponita, quadruped).
forma(rapidash, quadruped).
forma(mewtwo, bipede).

inicial(bulbasaur).
inicial(ivysaur).
inicial(venasaur).
inicial(charmander).
inicial(charmeleon).
inicial(charizard).

lendario(mewtwo).

evolui_para(bulbasaur, ivysaur).
evolui_para(ivysaur, venasaur).
evolui_para(charmander, charmeleon).
evolui_para(charmeleon, charizard).
evolui_para(ponita, rapidash).


% QUESTIONS DE EVO
tem_cadeia_evo(P) :- evolui_para(_,P);evolui_para(P,_).

cadeia_tres_estags(P) :- 
    tem_cadeia_evo(P),
    (
        (evolui_para(P, X), evolui_para(X, _));
        (evolui_para(_, X), evolui_para(X, P));
        (evolui_para(_, P), evolui_para(P, _))
    ).

primeiro_estagio(P) :- tem_cadeia_evo(P),\+ evolui_para(_,P).
terceiro_estagio(P) :- tem_cadeia_evo(P),evolui_para(X,P),evolui_para(_,X),!.
segundo_estagio(P) :- tem_cadeia_evo(P),\+ primeiro_estagio(P),\+ terceiro_estagio(P),!.

dois_tipos(P) :- tipo(P,T1),tipo(P,T2),T1\==T2.


% FILTROS
multiplas_opcoes :- findall(P,pokemon(P),L),
                    length(L,N),
                    N > 1.
multiplas_opcoes(Caracteristica, Valor) :-
    findall(P, (pokemon(P), call(Caracteristica, P, Valor)), Ocorrencias),
    length(Ocorrencias, N),
    N > 1.

conta_instancia_valor(cor, Valor, Count) :-
    findall(P, (pokemon(P), cor(P, Valor)), Cores),
    length(Cores, Count).

valor_mais_comun(cor, Valor) :-
    findall(Count-Valor, (cor(_, Valor), conta_instancia_valor(cor, Valor, Count)), Counts),
    keysort(Counts, SortedCounts),
    reverse(SortedCounts, [MostCommonCount-Valor | _]),
    conta_instancia_valor(cor, Valor, MostCommonCount).


conta_instancia_valor(tipo, Valor, Count) :-
    findall(P, (pokemon(P), tipo(P, Valor)), Tipos),
    length(Tipos, Count).

valor_mais_comun(tipo, Valor) :-
    findall(Count-Valor, (tipo(_, Valor), conta_instancia_valor(tipo, Valor, Count)), Counts),
    keysort(Counts, SortedCounts),
    reverse(SortedCounts, [MostCommonCount-Valor | _]),
    conta_instancia_valor(tipo, Valor, MostCommonCount).

conta_instancia_valor(forma, Valor, Count) :-
    findall(P, (pokemon(P), forma(P, Valor)), Formas),
    length(Formas, Count).

valor_mais_comun(forma, Valor) :-
    findall(Count-Valor, (forma(_, Valor), conta_instancia_valor(forma, Valor, Count)), Counts),
    keysort(Counts, SortedCounts),
    reverse(SortedCounts, [MostCommonCount-Valor | _]),
    conta_instancia_valor(forma, Valor, MostCommonCount).


% REMOÇOES
limpa_base :- 
    retract(pokemon(_)),
    retract(inicial(_)),
    retract(lendario(_)),
    retract(tipo(_,_)),
    retract(cor(_,_)),
    retract(forma(_,_)),
    retract(evolui_para(_,_)).


remove_pokemon_com(Caracteristica) :- findall(_,remove_pokemon_com1(Caracteristica),_), length(_, 0).
remove_pokemon_com(Caracteristica, Valor) :- findall(_,remove_pokemon_com1(Caracteristica, Valor),_), length(_, 0).

remove_pokemon_com1(Caracteristica, Valor) :-
    call(Caracteristica, P, Valor),
    pokemon(P),
    retract(pokemon(P)).

remove_pokemon_com1(Caracteristica) :-
    call(Caracteristica, P),
    pokemon(P),
    retract(pokemon(P)).    


remove_pokemon_sem(Caracteristica) :- findall(_,remove_pokemon_sem1(Caracteristica),_), length(_, 0).
remove_pokemon_sem(Caracteristica, Valor) :- findall(_,remove_pokemon_sem1(Caracteristica, Valor),_), length(_, 0).

remove_pokemon_sem1(Caracteristica, Valor) :-
    pokemon(P),
    \+ call(Caracteristica, P, Valor),
    retract(pokemon(P)).

remove_pokemon_sem1(Caracteristica) :-
    pokemon(P),
    \+ call(Caracteristica, P),
    retract(pokemon(P)).


% JOGO
jogo(n) :- write('Obrigado por participar!'), nl, !.

jogo :-	write('Bem vindo ao Poke Akinator!!!'), nl,
		write('Pense em um pokemon da 1a geração e tentaremos adivinha-lo!'), nl,
		write('Pensou?? Então vamos nessa...'), nl,
		questionamento,
 		write('Quer jogar de novo s/n?'), nl, 
		read(Resposta),
		jogo(Resposta).

jogo(s) :- jogo.

% - evo
    % - 3 estags
        % - 2 tipos
            % - estag
                % - tipo
                    % - outros
        % - 1 tipo
            % - estag
                % - forma
                    % - inicial/tipo
    % - 2 estags
        % - 1 tipo
            % - estag
                % - forma
                    % - outros
        % - 2 tipos
% - dont evo
    % - 1 tipo
        % - tipo
            % - outros
    % - 2 tipos
        % - tipo
            % - lendario

questionamento :- 
    caracterista(tem_cadeia_evo),
    caracterista(dois_tipos),
    adivinha.

caracterista(inicial) :- write('É um pokemon inicial s/n? (contando com as evoluções)'),
                        nl,
                        read(Resposta),
                        tem_caracteristica(Resposta, inicial).

caracterista(tem_cadeia_evo) :- write('O pokemon pertence a uma cadeia evolutiva s/n?'),
                                nl,
                                read(Resposta),
                                tem_caracteristica(Resposta, tem_cadeia_evo),
                                (Resposta = 's' ->
                                    caracterista(cadeia_tres_estags)
                                ;
                                    true
                                ).

caracterista(cadeia_tres_estags) :- write('Essa cadeia de evolução possui três estágios de evolução s/n?'),
                                nl,
                                read(Resposta),
                                tem_caracteristica(Resposta, cadeia_tres_estags),
                                (Resposta = 's' ->
                                    caracterista(terceiro_estagio)
                                ;
                                    caracterista(primeiro_estagio)
                                ).

caracterista(terceiro_estagio) :- write('Esse pokemon é o último estágio da cadeia s/n?'),
                                nl,
                                read(Resposta),
                                tem_caracteristica(Resposta, terceiro_estagio),
                                (Resposta = 'n' ->
                                    caracterista(primeiro_estagio)
                                ;
                                    true
                                ).

caracterista(primeiro_estagio) :- write('Esse pokemon é o primeiro estágio da cadeia s/n?'),
                                nl,
                                read(Resposta),
                                tem_caracteristica(Resposta, primeiro_estagio).

caracterista(dois_tipos) :- write('Esse pokemon possui 2 tipos s/n?'),
                                nl,
                                read(Resposta),
                                tem_caracteristica(Resposta, dois_tipos),
                                (Resposta = 'n' ->
                                    caracterista(forma)
                                ;
                                    caracterista(tipo)
                                ).

caracterista(tipo) :- valor_mais_comun(tipo, V),
                    format('O pokemon é do tipo ~w??', [V]),
                    nl,
                    read(Resposta),
                    tem_caracteristica(Resposta, tipo, V).

caracterista(cor) :- valor_mais_comun(cor, V),
                    format('O pokemon é da cor ~w??', [V]),
                    nl,
                    read(Resposta),
                    tem_caracteristica(Resposta, cor, V).

caracteristica(forma) :- valor_mais_comun(forma, V),
                    format('O pokemon é ~w??', [V]),
                    nl,
                    read(Resposta),
                    tem_caracteristica(Resposta, forma, V).


tem_caracteristica('s', Caracterista, Valor) :- remove_pokemon_sem(Caracterista, Valor).
tem_caracteristica('s', Caracterista) :- remove_pokemon_sem(Caracterista).
tem_caracteristica('n', Caracterista, Valor) :- remove_pokemon_com(Caracterista, Valor).
tem_caracteristica('n', Caracterista) :- remove_pokemon_com(Caracterista).

adivinha :- 
    write('Achamos essas possibilidades:'),
    nl,
    findall(P,pokemon(P),L),
    lista(L).  % This line prints the list

lista([]).
lista([H|T]) :-
    write(H), 
    nl,
    lista(T).

% adivinha :- write('Poxa, não conseguimos adivinhar...'), nl, !.