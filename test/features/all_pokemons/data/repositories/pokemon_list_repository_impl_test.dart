import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon/features/all_pokemons/data/dataSources/pokemon_list_remote_data_source.dart';
import 'package:pokemon/features/all_pokemons/data/repositories/pokemon_list_repository_impl.dart';

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

}