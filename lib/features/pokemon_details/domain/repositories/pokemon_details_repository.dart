import 'package:dartz/dartz.dart';
import 'package:pokemon/core/errors/failure.dart';
import 'package:pokemon/features/pokemon_details/domain/entities/pokemon_details_data_model.dart';
import 'package:pokemon/features/pokemon_details/domain/entities/pokemon_species_data_model.dart';

abstract class PokemonDetailsRepository{

    Future<Either<Failure, PokemonDetailsDataModel>> getPokemonDetails(int pokemonId);
    Future<Either<Failure, PokemonSpeciesDataModel>> getPokemonSpeciesDetails(int pokemonId);

}