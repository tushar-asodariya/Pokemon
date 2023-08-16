import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon/features/all_pokemons/data/models/pokemon_list_resp_model.dart';
import 'package:pokemon/features/all_pokemons/domain/entities/pokemon_name_data_model.dart';

import '../../../../test_data/read_test_data_files.dart';

void main(){

  test('should be a sub-class of PokemonListDataModel', ()async{
    expect(tPokemonListRespModel, isA<PokemonListDataModel>());
  });

  group('fromJson', () {
    test(
      'should return a valid model when the JSON is passed',
          () async {
        // arrange
        final Map<String, dynamic> jsonMap =
        json.decode(readTestData('pokemon_list_resp.json'));
        // act
        final result = PokemonListRespModel.fromJson(jsonMap);
        // assert
        expect(result, tPokemonListRespModel);
      },
    );

  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
          () async {
        // act
        final result = tPokemonListRespModel.toJson();
        // assert
        final expectedMap ={
          "count": 1281,
          "next": "https://pokeapi.co/api/v2/pokemon?offset=13&limit=10",
          "previous": "https://pokeapi.co/api/v2/pokemon?offset=0&limit=3",
          "results": [
            {
              "name": "charmander",
              "url": "https://pokeapi.co/api/v2/pokemon/4/"
            },
            {
              "name": "charmeleon",
              "url": "https://pokeapi.co/api/v2/pokemon/5/"
            },
            {
              "name": "charizard",
              "url": "https://pokeapi.co/api/v2/pokemon/6/"
            }

          ]
        };
        expect(result, expectedMap);
      },
    );
  });

}