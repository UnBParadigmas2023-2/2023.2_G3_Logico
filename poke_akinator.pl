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
    ),!.

primeiro_estagio(P) :- tem_cadeia_evo(P),\+ evolui_para(_,P).
terceiro_estagio(P) :- tem_cadeia_evo(P),evolui_para(X,P),evolui_para(_,X),!.
segundo_estagio(P) :- tem_cadeia_evo(P),\+ primeiro_estagio(P),\+ terceiro_estagio(P),!.

dois_tipos(P) :- findall(T,tipo(P,T),L),length(L,N),N > 1.


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



jogo(n) :- write('Obrigado por participar!'), nl, !.

jogo :-	write('Bem vindo ao Poke Akinator!!!'), nl,
		write('Pense em um pokemon da 1a geração e tentaremos adivinha-lo!'), nl,
		write('Pensou?? Então vamos nessa...'), nl,
		questionamento,
 		write('Quer jogar de novo s/n?'), nl, 
		read(Resposta),
		jogo(Resposta).

jogo(s) :- jogo.

questionamento :- 
    caracterista(inicial),
    adivinha.

caracterista(inicial) :- write('É um pokemon inicial s/n? (contando com as evoluções)'), nl, read(Resposta), tem_caracteristica(Resposta, inicial).

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