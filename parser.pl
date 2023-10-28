:- use_module(library(http/json)).

% Defina os operadores dinâmicos para os fatos dinâmicos
:- dynamic pokemon/12.
:- dynamic evolucao/3.
:- dynamic taxa_crescimento/2.
:- dynamic habitat/2.

ler_e_inserir_pokemons(Arquivo) :-
    open(Arquivo, read, Stream),
    json_read_dict(Stream, JSON),
    close(Stream),
    inserir_pokemons(JSON).

inserir_pokemons([]).
inserir_pokemons([Pokemon | Resto]) :-
    inserir_pokemon(Pokemon),
    inserir_pokemons(Resto).

empty_list([]).

inserir_pokemon(Pokemon) :-
    Nome = Pokemon.name,
    ID = Pokemon.id,
    Cor = Pokemon.color.name,
    IsLendario = Pokemon.isLegendary,
    IsMitico = Pokemon.isMythical,
    Habitat = Pokemon.habitat.name,
    Forma = Pokemon.shape.name,
    arg(1, Pokemon.types, T1),
    Type01 = T1.type.name,

    arg(2, Pokemon.types, Type2),
    (\+empty_list(Type2) ->
        arg(1, Type2, T2),
        Type02 = T2.type.name
    ;
        Type02 = ''
    ),
    (\+empty_list(Pokemon.evolvesTo) ->
        arg(1, Pokemon.evolvesTo, E1),
        HasEvolveChain = 1,
        Evo1 = E1.species.name,
        (empty_list(E1.evolves_to) ->
            Evo2 = ''
        ;
            arg(1, E1.evolves_to, Ea2),
            Evo2 = Ea2.species.name
        )
    ;
        HasEvolveChain = 0,
        Evo1 = '',
        Evo2 = ''
    ),
    assertz(pokemon(ID, Nome, Cor, IsLendario, IsMitico, Habitat, Forma, HasEvolveChain, Evo1, Evo2, Type01, Type02)).

main :-
    retractall(pokemon(_, _, _, _, _, _, _, _, _, _, _, _)),          % Limpa todos os fatos dinâmicos
    ler_e_inserir_pokemons('pokemons_list.json').

listar_pokemons(PokemonList) :-
    findall([ID, Nome, Cor, IsLendario, IsMitico, Habitat, Forma, HasEvolveChain, Evo1, Evo2, Type01, Type02],
        pokemon(ID, Nome, Cor, IsLendario, IsMitico, Habitat, Forma, HasEvolveChain, Evo1, Evo2, Type01, Type02),
        PokemonList).
