// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pokemon/core/errors/failure.dart';
import 'package:pokemon/core/usecases/usecases.dart';
import 'package:pokemon/features/pokemon_details/domain/entities/pokemon_species_data_model.dart';
import 'package:pokemon/features/pokemon_details/domain/repositories/pokemon_details_repository.dart';

class GetPokemonSpecies implements UseCase<PokemonSpeciesDataModel, Params>  {
  final PokemonDetailsRepository pokemonDetailsRepository;
  GetPokemonSpecies({
    required this.pokemonDetailsRepository,
  });

  @override
  Future<Either<Failure, PokemonSpeciesDataModel>> call(Params params) async{
       return await pokemonDetailsRepository.getPokemonSpeciesDetails(params.pokemonId);

  }
}

class Params extends Equatable {
  final int pokemonId;

  Params({required this.pokemonId});

  @override
  List<Object> get props => [pokemonId];
}
