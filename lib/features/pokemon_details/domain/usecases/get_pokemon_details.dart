// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:pokemon/core/errors/failure.dart';
import 'package:pokemon/core/usecases/usecases.dart';
import 'package:pokemon/features/pokemon_details/domain/entities/pokemon_details_data_model.dart';
import 'package:pokemon/features/pokemon_details/domain/repositories/pokemon_details_repository.dart';

import 'get_pokemon_species.dart';

class GetPokemonDetails implements UseCase<PokemonDetailsDataModel, Params> {
  final PokemonDetailsRepository pokemonDetailsRepository;
  GetPokemonDetails({
    required this.pokemonDetailsRepository,
  });

  @override
  Future<Either<Failure, PokemonDetailsDataModel>> call(Params params) async {
    return await pokemonDetailsRepository.getPokemonDetails(params.pokemonId);
  }
}
