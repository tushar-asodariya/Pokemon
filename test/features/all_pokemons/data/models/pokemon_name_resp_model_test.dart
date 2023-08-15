import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon/features/all_pokemons/data/models/pokemon_name_resp_model.dart';
import 'package:pokemon/features/all_pokemons/domain/entities/pokemon_name_data_model.dart';

import '../../../../test_data/read_test_data_files.dart';

void main(){

  final PokemonNameRespModel tpokemonNameRespModel = PokemonNameRespModel(name: 'charmander', url: 'https://pokeapi.co/api/v2/pokemon/4/');

  test('should  be a sub-class of PokemonNameDataModel', ()async{

    expect(tpokemonNameRespModel, isA<PokemonNameDataModel>() );
  });

  group('fromJson', () {
    test(
      'should return a valid model when the JSON is passed',
          () async {
        // arrange
        final Map<String, dynamic> jsonMap =
        json.decode(readTestData('pokemon_name.json'));
        // act
        final result = PokemonNameRespModel.fromJson(jsonMap);
        // assert
        expect(result, tpokemonNameRespModel);
      },
    );

  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
          () async {
        // act
        final result = tpokemonNameRespModel.toJson();
        // assert
        final expectedMap = {
          "name": "charmander",
          "url": 'https://pokeapi.co/api/v2/pokemon/4/',
        };
        expect(result, expectedMap);
      },
    );
  });

}