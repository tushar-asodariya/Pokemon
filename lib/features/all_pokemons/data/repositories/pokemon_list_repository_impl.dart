import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:pokemon/core/errors/exceptions.dart';
import 'package:pokemon/core/errors/failure.dart';
import 'package:pokemon/dependency_injection.dart';
import 'package:pokemon/features/all_pokemons/data/dataSources/pokemon_list_remote_data_source.dart';
import 'package:pokemon/features/all_pokemons/data/models/pokemon_list_req_model.dart';
import 'package:pokemon/features/all_pokemons/domain/entities/pokemon_name_data_model.dart';
import 'package:pokemon/features/all_pokemons/domain/repositories/pokemon_list_repository.dart';

class PokemonListRepositoryImpl implements PokemonListRepository {
  final PokemonListRemoteDataSource pokemonListRemoteDataSource;

  PokemonListRepositoryImpl({required this.pokemonListRemoteDataSource});

  @override
  Future<Either<Failure, PokemonListDataModel>> getPokemonList(
      PokemonListReqModel pokemonListReqParamsModel) async {
    try {
      if (await getInstance<InternetConnection>().hasInternetAccess) {
        final remoteResponse = await pokemonListRemoteDataSource.getPokemonList(
            pokemonListReqParamsModel: pokemonListReqParamsModel);
        return Right(remoteResponse);
      } else {
        return Left(NoInternetFailure());
      }
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
