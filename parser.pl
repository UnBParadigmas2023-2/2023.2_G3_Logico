% Arquivo 'parser.pl'
:- use_module(library(http/json)).

read_json_file(File, Json) :-
    open(File, read, Stream),
    json_read_dict(Stream, Json),
    close(Stream).

process_json([], _).
process_json([Pokemon|Rest], JSONData) :-
    Name = Pokemon.name,
    Type = Pokemon.type,
    Level = Pokemon.level,
    assertz(pokemon(Name, Type, Level)),
    process_json(Rest, JSONData).

% Leitura do arquivo e processamento
read_json_file('test.json', JSONData).
process_json(JSONData, JSONData).

