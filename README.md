# Akinator de Pokémon

**Disciplina**: FGA0210 - PARADIGMAS DE PROGRAMAÇÃO - T01 <br>
**Nro do Grupo**: 03<br>
**Paradigma**: Lógico<br>

## Alunos

| Matrícula  | Aluno                             |
| ---------- | --------------------------------- |
| 19/0010606 | Artur de Sousa Vieira             |
| 19/0024950 | Arthur de Melo Garcia             |
| 19/0011424 | Carlos Eduardo Miranda Roriz      |
| 17/0032591 | Edvan Barreira Gomes Júnior       |
| 19/0109963 | João Victor Teixeira Batista      |
| 19/0112123 | Lucas Gabriel Sousa Camargo Paiva |
| 20/0023411 | Luíza Esteves dos Santos          |
| 16/0141842 | Philipe Rosa Serafim              |

## Sobre 
<!-- Descreva o seu projeto em linhas gerais. 
Use referências, links, que permitam conhecer um pouco mais sobre o projeto.
Capriche nessa seção, pois ela é a primeira a ser lida pelos interessados no projeto. -->

O PokeAkinator é um software de advinhação de Pokemon da primeira geração. A cada rodada, a aplicação faz uma pergunta a respeito de alguma característica do monstrinho em questão (cuja a resposta sempre deve ser 'sim' ou 'não'), até que encontre algum que seja compatível com a descrição. Na primeira geração existem 151 Pokemon diferentes, com cores, formas, tipos e diversas outras característica que fazem cada um deles uma combinação única, então para descobrir qual deles é o escolhido, a aplicação tenta dividí-los em grupos, dessa forma a cada rodada uma grande quantidade deles pode ser removida de uma vez, permitindo chegar na resposta de maneira eficiente. Abaixo temos alguns exemplos de como os monstrinhos são agrupados. 

* Pokemon que não evoluem: ![nao_evoluem](https://github.com/UnBParadigmas2023-2/2023.2_G3_Logico/assets/54152857/6f6f5917-1151-4703-8f47-2590585fdef7)
* Pokemon que evoluem, possuem dois estágios de evolução e apenas um tipo: ![evoluem-dois_estagios-1tipo](https://github.com/UnBParadigmas2023-2/2023.2_G3_Logico/assets/54152857/5058a655-e57f-4b51-a119-7a1eb5958e99)
* Pokemon que evoluem, possuem dois estágios de evolução e dois tipos: ![evoluem-dois_estagios-2tipos](https://github.com/UnBParadigmas2023-2/2023.2_G3_Logico/assets/54152857/4be85280-9cf6-42ad-b85e-fb09a81af88d)
* Pokemon que evoluem, possuem mais de dois estágios de evolução e apenas um tipo: ![evoluem-mais_de_dois-1tipo](https://github.com/UnBParadigmas2023-2/2023.2_G3_Logico/assets/54152857/58fb9f50-c059-449e-b9d6-85d4257c24bc)
* Pokemon que evoluem, possuem mais de dois estágios de evolução e dois tipos: ![evoluem-mais_de_dois-2tipos](https://github.com/UnBParadigmas2023-2/2023.2_G3_Logico/assets/54152857/6dc5af38-4c82-4b95-b80b-39787827a2e7)

Todas as informações dos pokemons, incluindo tipos, evoluções e outros foram coletadas na [PokeApi](https://pokeapi.co/). 

A lista de Pokemons iniciais pode ser encontrada nesse link: [Pokemons da primeira geração](https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_index_number_(Generation_I))

## Screenshots
Adicione 2 ou mais screenshots do projeto em termos de interface e/ou funcionamento.

## Instalação 
**Linguagens**: Prolog<br>
**Tecnologias**: Prolog<br>
Descreva os pré-requisitos para rodar o seu projeto e os comandos necessários.
Insira um manual ou um script para auxiliar ainda mais.
Gifs animados e outras ilustrações são bem-vindos!

## Uso 
<!-- Explique como usar seu projeto.
Procure ilustrar em passos, com apoio de telas do software, seja com base na interface gráfica, seja com base no terminal.
Nessa seção, deve-se revelar de forma clara sobre o funcionamento do software. -->

## Vídeo
Adicione 1 ou mais vídeos com a execução do projeto.
Procure: 
(i) Introduzir o projeto;
(ii) Mostrar passo a passo o código, explicando-o, e deixando claro o que é de terceiros, e o que é contribuição real da equipe;
(iii) Apresentar particularidades do Paradigma, da Linguagem, e das Tecnologias, e
(iV) Apresentar lições aprendidas, contribuições, pendências, e ideias para trabalhos futuros.
OBS: TODOS DEVEM PARTICIPAR, CONFERINDO PONTOS DE VISTA.
TEMPO: +/- 15min

## Participações
<!-- Apresente, brevemente, como cada membro do grupo contribuiu para o projeto. -->
|Nome do Membro | Contribuição | Significância da Contribuição para o Projeto (Excelente/Boa/Regular/Ruim/Nula) |
| -- | -- | -- |
| Artur de Sousa Vieira  |  Ajuda com o funcionamento teórico da aplicação, definição das perguntas e redigir documentação | Boa |
| Arthur de Melo Garcia             | | |
| Carlos Eduardo Miranda Roriz      | | |
| Edvan Barreira Gomes Júnior       | Ajuda no desenvolvimento do parser, documentação, resolução de problemas e desenvolvimento da lógica de dedução | Excelente |
| João Victor Teixeira Batista      | Desenvolvimento das principais funcionalidades da lógica de dedução | Excelente |
| Lucas Gabriel Sousa Camargo Paiva | Ajuda no desenvolvimento do parser e resolução de problemas | Excelente  |
| Luíza Esteves dos Santos          | Desenvolvimento do parser, documentação e resolução de problemas | Excelente  |
| Philipe Rosa Serafim              | Desenvolvimento do extractor, ajuda no desenvolvimento do parser, documentação, resolução de problemas e desenvolvimento da lógica de dedução | Excelente |

## Outros 
<!-- Quaisquer outras informações sobre o projeto podem ser descritas aqui. Não esqueça, entretanto, de informar sobre:
(i) Lições Aprendidas;
(ii) Percepções;
(iii) Contribuições e Fragilidades, e
(iV) Trabalhos Futuros. -->

### Lições Aprendidas
- Paradigma Lógico: O grupo teve a compreensão de aplicação do paradigma lógico na programação de uma aplicação com foco em dedução lógica.

- Prolog: Para a aplicação do paradigma lógico o grupo aprendeu a linguagem Prolog, que foi usada para a programação da aplicação.

- Trabalho em equipe: A colaboração tanto na concepção teórica da aplicação quanto a implementação foi de supra importância para o sucesso da entrega.


### Percepções
Assim como na entrega anterior, o grupo tendeu a focar em questões conceituais antes do funcionamento com o paradigma, entretanto desta vez a ideia veio partindo do paradigma primeiro, o que foi melhor para a adaptação da ideia para a linguagem.

### Contribuições e Fragilidades
O grupo conseguiu aplicar bem o paradigma na aplicação, mostrando que para problemas de lógioca a linguagem é muito eficaz e direta. Assim foi implementado de maneira interessate um problema já conhecido por todos, baseado no Akinator, utilizando uma linguagem nova.

Já em fragilidades, o grupo teve maior dificuldade na distribuição das atividades, visto que sendo uma linguagem em que o trabalho conjunto é mais difícil do que outras linguagens, acabou que o trabalho ficou mais concentrado em pessoas específicas na hora da implementação, ainda que houvesse uma maior contribuição na parte de concepção.

### Trabalhos Futuros
- Interface gráfica: Anda que o funcionamento da aplicação seja conceitualmente e funcionalmente adequada, ainda é uma grande área de continuação a implementação de uma interface gráfica para a melhor interação com o usuário.

- Outras gerações: Além disso sempre há a possíbilidade de expanção da base de dados dos pokemons, podendo usar várias outras gerações separada ou conjuntamente.

## Fontes
- Api de base para o projeto: https://pokeapi.co/
- Documentação do Prolog: https://www.swi-prolog.org/pldoc/doc_for?object=manual
