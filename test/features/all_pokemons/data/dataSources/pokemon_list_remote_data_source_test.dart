import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pokemon/core/errors/exceptions.dart';
import 'package:pokemon/features/all_pokemons/data/dataSources/pokemon_list_remote_data_source.dart';

import 'package:pokemon/core/constants/api_path_constants.dart';
import '../../../../test_data/read_test_data_files.dart';
import 'pokemon_list_remote_data_source_test.mocks.dart';

import 'package:mockito/annotations.dart';

@GenerateMocks([dio.Dio])
void main() {
  late PokemonListRemoteDataSourceImpl pokemonListRemoteDataSourceImpl;
  late MockDio mockDioClient;
  late dio.RequestOptions requestOptions;
  setUp(() {
    mockDioClient = MockDio();
    pokemonListRemoteDataSourceImpl =
        PokemonListRemoteDataSourceImpl(dioClient: mockDioClient);
    requestOptions = dio.RequestOptions(
        path: ApiPath.pokemonList,
        queryParameters: tPokemonListReqModel.toJson(),
        headers: {
          'Content-Type': 'application/json',
        });
  });

  void setUpMockDioClientSuccess200() {
    when(mockDioClient.get(
      ApiPath.pokemonList,
      queryParameters: tPokemonListReqModel.toJson(),
    )).thenAnswer(
      (_) async => dio.Response(
          data: readTestData('pokemon_list_resp.json'),
          requestOptions: requestOptions,
          statusCode: 200),
    );
  }

  group('getPokemonList', () {
    test(
      'should perform a GET request on a URL with tPokemonListReqModel being the endpoint ',
      () async {
        //arrange
        setUpMockDioClientSuccess200();
        // act
        await pokemonListRemoteDataSourceImpl.getPokemonList(
            pokemonListReqParamsModel: tPokemonListReqModel);
        // assert
        verify(await mockDioClient.get(
          ApiPath.pokemonList,
          queryParameters: tPokemonListReqModel.toJson(),
        ));
      },
    );

    test(
      'should return PokemonListRespModel when the response code is 200 (success)',
      () async {
        //arrange
        setUpMockDioClientSuccess200();
        // act
        final result = await pokemonListRemoteDataSourceImpl.getPokemonList(
            pokemonListReqParamsModel: tPokemonListReqModel);
        // assert
        expect(result, equals(tPokemonListRespModel));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        when(mockDioClient.get(
          ApiPath.pokemonList,
          queryParameters: tPokemonListReqModel.toJson(),
        )).thenAnswer(
          (_) async => dio.Response(
              data: 'Something went South !',
              requestOptions: requestOptions,
              statusCode: 404),
        );
        // act 
        final call = pokemonListRemoteDataSourceImpl.getPokemonList;
        // assert
        expect(() => call(pokemonListReqParamsModel: tPokemonListReqModel),
            throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });
}
