import 'package:dartz/dartz.dart';
import 'package:pokemon/core/errors/exceptions.dart';
import 'package:pokemon/core/errors/failure.dart';
import 'package:pokemon/features/all_pokemons/data/dataSources/pokemon_list_remote_data_source.dart';
import 'package:pokemon/features/all_pokemons/data/models/pokemon_list_req_model.dart';
import 'package:pokemon/features/all_pokemons/domain/entities/pokemon_name_data_model.dart';
import 'package:pokemon/features/all_pokemons/domain/repositories/pokemon_list_repository.dart';

class PokemonListRepositoryImpl implements PokemonListRepository{
  final PokemonListRemoteDataSource pokemonListRemoteDataSource;


  PokemonListRepositoryImpl({required this.pokemonListRemoteDataSource});

  @override
  Future<Either<Failure, PokemonListDataModel>> getPokemonList(PokemonListReqModel pokemonListReqParamsModel)
  async {
    try{
      final remoteResponse = await pokemonListRemoteDataSource.getPokemonList(pokemonListReqParamsModel: pokemonListReqParamsModel);
      return Right(remoteResponse);

    }on ServerException {
      return Left(ServerFailure())  ;
    }
  }

}