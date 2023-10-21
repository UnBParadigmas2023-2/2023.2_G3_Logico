:- use_module(library(http/http_open)).
:- use_module(library(http/http_client)).
:- use_module(library(http/json)).

remove_char(Input, Target, Output) :-
    atom_codes(Input, CodeList),
    exclude(=(Target), CodeList, ResultList),
    atom_codes(Output, ResultList).

url_concat(Url, Position, URL) :-
    atom_number(Num, Position),
    atom_concat(Url, Num, URL).

string_atom(String, Atom) :-
    string_codes(String, ListCodes),
    atom_codes(Atom, ListCodes).

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
    json_write(current_output, Pokemon, [width(0)]).