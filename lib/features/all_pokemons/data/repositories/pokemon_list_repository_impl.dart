import 'package:dartz/dartz.dart';
import 'package:pokemon/core/errors/failure.dart';
import 'package:pokemon/features/all_pokemons/data/models/pokemon_list_req_model.dart';
import 'package:pokemon/features/all_pokemons/domain/entities/pokemon_name_data_model.dart';
import 'package:pokemon/features/all_pokemons/domain/repositories/pokemon_list_repository.dart';

class PokemonListRepositoryImpl implements PokemonListRepository{
  @override
  Future<Either<Failure, PokemonListDataModel>> getPokemonList(PokemonListReqModel pokemonListReqParamsModel) {
    // TODO: implement getPokemonList
    throw UnimplementedError();
  }

}