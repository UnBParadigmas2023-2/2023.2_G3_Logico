:- use_module(library(http/json)).

% Defina os operadores dinâmicos para os fatos dinâmicos
:- dynamic pokemon/6.
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

inserir_pokemon(Pokemon) :-
    Nome = Pokemon.name,
    ID = Pokemon.id,
    Cor = Pokemon.color.name,
    Altura = Pokemon.height,
    Peso = Pokemon.weight,
    IsLendario = Pokemon.isLegendary,
    
    % Insere os fatos no banco de dados
    assertz(pokemon(Nome, ID, Cor, Altura, Peso, IsLendario)),
    processar_evolucoes(Nome, Pokemon.evolvesTo),
    TaxaCrescimento = Pokemon.growthRate.name,
    Habitat = Pokemon.habitat.name,
    assertz(taxa_crescimento(Nome, TaxaCrescimento)),
    assertz(habitat(Nome, Habitat)),
    processar_tipos(Nome, Pokemon.types),
    processar_stats(Nome, Pokemon.stats).

processar_evolucoes(_, []).
processar_evolucoes(PokemonNome, [Evolucao | Resto]) :-
    assertz(evolucao(PokemonNome, Evolucao.species.name, Evolucao.evolution_details)),
    processar_evolucoes(PokemonNome, Resto).

processar_tipos(_, []).
processar_tipos(PokemonNome, [Tipo | Resto]) :-
    assertz(tipo(PokemonNome, Tipo.type.name)),
    processar_tipos(PokemonNome, Resto).

processar_stats(_, []).
processar_stats(PokemonNome, [Stat | Resto]) :-
    assertz(estatistica(PokemonNome, Stat.base_stat, Stat.stat.name)),
    processar_stats(PokemonNome, Resto).


main :-
    retractall(pokemon(_, _, _, _, _, _)),          % Limpa todos os fatos dinâmicos
    retractall(evolucao(_, _, _)),
    retractall(taxa_crescimento(_, _)),
    retractall(habitat(_, _)),
    retractall(tipo(_, _)),
    retractall(estatistica(_, _, _)),
    ler_e_inserir_pokemons('pokemons.json'),
    listar_pokemons.

listar_pokemons :-
    findall([Nome, ID, Cor, Altura, Peso, IsLendario, Evolucao, TaxaCrescimento, Habitat, Tipos, Stats],
            (pokemon(Nome, ID, Cor, Altura, Peso, IsLendario),
             evolucao(Nome, Evolucao, _),
             taxa_crescimento(Nome, TaxaCrescimento),
             habitat(Nome, Habitat),
             findall(Tipo, tipo(Nome, Tipo), Tipos),
             findall([BaseStat, StatName], estatistica(Nome, BaseStat, StatName), Stats)),
            PokemonList),
    print_pokemons(PokemonList).

print_pokemons([]).
print_pokemons([[Nome, ID, Cor, Altura, Peso, IsLendario, Evolucao, TaxaCrescimento, Habitat, Tipos, Stats] | Resto]) :-
    write('Nome: '), write(Nome), nl,
    write('ID: '), write(ID), nl,
    write('Cor: '), write(Cor), nl,
    write('Altura: '), write(Altura), nl,
    write('Peso: '), write(Peso), nl,
    write('Lendário: '), write(IsLendario), nl,
    write('Evolução: '), write(Evolucao), nl,
    write('Taxa de Crescimento: '), write(TaxaCrescimento), nl,
    write('Habitat: '), write(Habitat), nl,
    write('Tipos: '), write(Tipos), nl,
    write('Stats: '), write(Stats), nl, nl,
    print_pokemons(Resto).





