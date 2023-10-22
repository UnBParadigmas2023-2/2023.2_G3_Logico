:- use_module(library(http/http_open)).
:- use_module(library(http/http_client)).
:- use_module(library(http/json)).

url_concat(Url, Position, URL) :-
    atom_number(Num, Position),
    atom_concat(Url, Num, URL).

request_http(URL, JSONResponse) :-
    http_open(URL, InStream, []),
    json_read_dict(InStream, JSONResponse),
    close(InStream).

get_pokemon(Position, JSONResponse) :-
    url_concat('https://pokeapi.co/api/v2/pokemon/', Position, URL),
    request_http(URL, JSONResponse).

get_species(Position, JSONResponse) :-
    url_concat('https://pokeapi.co/api/v2/pokemon-species/', Position, URL),
    request_http(URL, JSONResponse).

get_evolutions(Position, JSONResponse) :-
    url_concat('https://pokeapi.co/api/v2/pokemon-species/', Position, URL),
    request_http(URL, JSON),
    request_http(JSON.evolution_chain.url, JSONResponse).

json_object(Position, Object) :-
    get_pokemon(Position, Pokemon),
    get_species(Position, Species),
    get_evolutions(Position, EvolutionChain),
    Object = Pokemon{
      name: Pokemon.name,
      id: Pokemon.id,
      types: Pokemon.types,
      height: Pokemon.height,
      weight: Pokemon.weight,
      forms: Pokemon.forms,
      stats: Pokemon.stats,
      color: Species.color,
      growthRate: Species.growth_rate,
      habitat: Species.habitat,
      shape: Species.shape,
      isLegendary: Species.is_legendary,
      isMythical: Species.is_mythical,
      isBaby: Species.is_baby,
      evolvesTo: EvolutionChain.chain.evolves_to
    }.

imprime_pokemon(Position) :-
    json_object(Position, Pokemon),
    json_write(current_output, Pokemon, [width(1)]).

get_n_pokemons(1, Stream):-
    json_object(1, Pokemon),
    json_write_dict(Stream, Pokemon).

get_n_pokemons(N, Stream):-
    N >= 1,
    json_object(N, Pokemon),
    json_write_dict(Stream, Pokemon),
    writeln(Stream, ','),
    N1 is N - 1,
    get_n_pokemons(N1, Stream).

json_to_file(File, N) :-
    open(File, write, Stream),
    write(Stream, '['),
    get_n_pokemons(N, Stream),
    write(Stream, ']'),
    close(Stream).
