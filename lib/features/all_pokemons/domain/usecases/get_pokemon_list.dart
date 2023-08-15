import 'package:dartz/dartz.dart';
import 'package:pokemon/core/errors/failure.dart';
import 'package:pokemon/core/usecases/usecases.dart';
import 'package:pokemon/features/all_pokemons/data/models/pokemon_list_req_model.dart';
import 'package:pokemon/features/all_pokemons/data/models/pokemon_list_resp_model.dart';
import 'package:pokemon/features/all_pokemons/domain/entities/pokemon_name_data_model.dart';
import 'package:pokemon/features/all_pokemons/domain/repositories/pokemon_list_repository.dart';

class GetPokemonList extends UseCase<PokemonListDataModel,PokemonListReqModel>{
  final PokemonListRepository pokemonListRepository;

  GetPokemonList({required this.pokemonListRepository});

  @override
  Future<Either<Failure, PokemonListDataModel>> call(PokemonListReqModel params) async{
    return await pokemonListRepository.getPokemonList(params);

  }



}