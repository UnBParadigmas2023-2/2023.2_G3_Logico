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