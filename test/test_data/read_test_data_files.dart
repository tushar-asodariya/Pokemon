import 'dart:io';

import 'package:pokemon/features/all_pokemons/data/models/pokemon_list_req_model.dart';
import 'package:pokemon/features/all_pokemons/data/models/pokemon_list_resp_model.dart';
import 'package:pokemon/features/all_pokemons/data/models/pokemon_name_resp_model.dart';


final PokemonListReqModel tPokemonListReqModel = PokemonListReqModel(limit: 10, offset: 3);
final PokemonNameRespModel pokemonNameRespModel = PokemonNameRespModel(name: 'charmander', url: 'https://pokeapi.co/api/v2/pokemon/4/');
final PokemonNameRespModel pokemonNameRespModel2 = PokemonNameRespModel(name: 'charmeleon', url: 'https://pokeapi.co/api/v2/pokemon/5/');
final PokemonNameRespModel pokemonNameRespModel3 = PokemonNameRespModel(name: 'charizard', url: 'https://pokeapi.co/api/v2/pokemon/6/');

final tPokemonListRespModel = PokemonListRespModel(count: 1281,
    next: 'https://pokeapi.co/api/v2/pokemon?offset=13&limit=10',
    previous: 'https://pokeapi.co/api/v2/pokemon?offset=0&limit=3',
    results: [pokemonNameRespModel,pokemonNameRespModel2, pokemonNameRespModel3 ]);

String readTestData(String name) => File('test/test_data/$name').readAsStringSync();
