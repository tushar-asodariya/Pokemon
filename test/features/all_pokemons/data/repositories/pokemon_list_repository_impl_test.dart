import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pokemon/core/errors/exceptions.dart';
import 'package:pokemon/core/errors/failure.dart';
import 'package:pokemon/features/all_pokemons/data/dataSources/pokemon_list_remote_data_source.dart';
import 'package:pokemon/features/all_pokemons/data/models/pokemon_list_req_model.dart';
import 'package:pokemon/features/all_pokemons/data/models/pokemon_list_resp_model.dart';
import 'package:pokemon/features/all_pokemons/data/models/pokemon_name_resp_model.dart';
import 'package:pokemon/features/all_pokemons/data/repositories/pokemon_list_repository_impl.dart';

import '../../../../test_data/read_test_data_files.dart';
import 'pokemon_list_repository_impl_test.mocks.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([PokemonListRemoteDataSource])

void main(){
  late PokemonListRepositoryImpl repository;
  late MockPokemonListRemoteDataSource mockRemoteDataSource;


  setUp(() {
    mockRemoteDataSource = MockPokemonListRemoteDataSource();

    repository = PokemonListRepositoryImpl(
      pokemonListRemoteDataSource : mockRemoteDataSource,

    );
  });


  group('test api calls response and failure', (){
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

    test(
      'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getPokemonList(pokemonListReqParamsModel : tPokemonListReqModel))
            .thenThrow(ServerException());
        // act
        final result = await repository.getPokemonList(tPokemonListReqModel);
        // assert
        verify(mockRemoteDataSource.getPokemonList(pokemonListReqParamsModel : tPokemonListReqModel));

        expect(result, equals(Left(ServerFailure())));
      },
    );
  });
}