import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pokemon/features/all_pokemons/data/dataSources/pokemon_list_remote_data_source.dart';
import 'package:pokemon/features/all_pokemons/data/models/pokemon_list_req_model.dart';
import 'package:pokemon/features/all_pokemons/data/models/pokemon_list_resp_model.dart';
import 'package:pokemon/features/all_pokemons/data/models/pokemon_name_resp_model.dart';
import 'package:pokemon/features/all_pokemons/data/repositories/pokemon_list_repository_impl.dart';
import 'package:mockito/annotations.dart';

import 'pokemon_list_repository_impl_test.mocks.dart';

@GenerateMocks([PokemonListRemoteDataSource])

void main(){
  PokemonListRepositoryImpl repository;
  MockPokemonListRemoteDataSource mockRemoteDataSource;


  setUp(() {
    mockRemoteDataSource = MockPokemonListRemoteDataSource();

    repository = PokemonListRepositoryImpl(
      pokemonListRemoteDataSourceImpl : mockRemoteDataSource,

    );
  });

  final PokemonListReqModel tPokemonListReqModel = PokemonListReqModel(limit: 10, offset: 3);
  final PokemonNameRespModel pokemonNameRespModel = PokemonNameRespModel(name: 'charmander', url: 'https://pokeapi.co/api/v2/pokemon/4/');
  final PokemonNameRespModel pokemonNameRespModel2 = PokemonNameRespModel(name: 'charmeleon', url: 'https://pokeapi.co/api/v2/pokemon/5/');
  final PokemonNameRespModel pokemonNameRespModel3 = PokemonNameRespModel(name: 'charizard', url: 'https://pokeapi.co/api/v2/pokemon/6/');

  final tPokemonListRespModel = PokemonListRespModel(count: 1281,
      next: 'https://pokeapi.co/api/v2/pokemon?offset=13&limit=10',
      previous: 'https://pokeapi.co/api/v2/pokemon?offset=0&limit=3',
      results: [pokemonNameRespModel,pokemonNameRespModel2, pokemonNameRespModel3 ]);

  test(
    'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getPokemonList(pokemonListReqParamsModel : tPokemonListReqModel))
          .thenAnswer((_) async => tPokemonListRespModel);
      // act
      final result = await repository.getPokemonList(tPokemonListReqModel);
      // assert
      verify(mockRemoteDataSource.getPokemonList(pokemonListReqParamsModel : tPokemonListReqModel));
      expect(result, equals(Right(tPokemonListRespModel)));
    },
  );

}