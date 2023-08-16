import 'package:dartz/dartz.dart';
import 'package:pokemon/core/errors/exceptions.dart';
import 'package:pokemon/core/errors/failure.dart';
import 'package:pokemon/features/pokemon_details/data/dataSources/pokemon_details_remote_data_source.dart';
import 'package:pokemon/features/pokemon_details/data/models/pokemon_details_resp_model.dart';
import 'package:pokemon/features/pokemon_details/data/models/pokemon_species_resp_model.dart';
import 'package:pokemon/features/pokemon_details/data/models/pokemon_stats_resp_model.dart';
import 'package:pokemon/features/pokemon_details/domain/entities/pokemon_about_data_model.dart';
import 'package:pokemon/features/pokemon_details/domain/entities/pokemon_details_data_model.dart';
import 'package:pokemon/features/pokemon_details/domain/entities/pokemon_moves_data_model.dart';
import 'package:pokemon/features/pokemon_details/domain/entities/pokemon_species_data_model.dart';
import 'package:pokemon/features/pokemon_details/domain/entities/pokemon_stats_data_model.dart';
import 'package:pokemon/features/pokemon_details/domain/entities/pokemon_types_data_model.dart';
import 'package:pokemon/features/pokemon_details/domain/repositories/pokemon_details_repository.dart';

class PokemonDetailsRepositoryImpl extends PokemonDetailsRepository {
  final PokemonDetailsRemoteDataSource pokemonDetailsRemoteDataSource;

  PokemonDetailsRepositoryImpl({required this.pokemonDetailsRemoteDataSource});
  @override
  Future<Either<Failure, PokemonDetailsDataModel>> getPokemonDetails(
      int pokemonId) async {
    try {
      final PokemonDetailsRespModel remoteResponse =
          await pokemonDetailsRemoteDataSource.getPokemonDetails(pokemonId);

      PokemonDetailsDataModel pokemonDetailsDataModel = PokemonDetailsDataModel(
          pokemonId: pokemonId,
          aboutDataModel: getPokemonAboutDataFromResp(remoteResponse),
          movesDataModel: getPokemonMovesFromResp(remoteResponse),
          statsDataModel: getPokemonStatsFromResp(remoteResponse),
          typesDataModel: getPokemonTypesFromResp(remoteResponse));

      return Right(pokemonDetailsDataModel);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  getPokemonMovesFromResp(PokemonDetailsRespModel remoteResponse) {
    String moves =
        remoteResponse.moves != null && remoteResponse.moves!.isNotEmpty
            ? remoteResponse.moves!.map((e) => e.move).toList().join(', ')
            : '';
    return PokemonMovesDataModel(moves: moves);
  }

  getPokemonStatsFromResp(PokemonDetailsRespModel remoteResponse) {
    PokemonStatsDataModel? pokemonStatsDataModel;
    if (remoteResponse.stats != null) {
      double hp = remoteResponse.stats!
              .firstWhere(
                  (Stats element) =>
                      element.stat != null && element.stat!.name == 'hp',
                  orElse: () => Stats(effort: 0))
              .effort!
              .toDouble() /
          100;
      double attack = remoteResponse.stats!
              .firstWhere(
                  (element) =>
                      element.stat != null && element.stat!.name == 'attack',
                  orElse: () => Stats(effort: 0))
              .effort!
              .toDouble() /
          100;
      double defence = remoteResponse.stats!
              .firstWhere(
                  (element) =>
                      element.stat != null && element.stat!.name == 'defense',
                  orElse: () => Stats(effort: 0))
              .effort!
              .toDouble() /
          100;
      double specialAttack = remoteResponse.stats!
              .firstWhere(
                  (element) =>
                      element.stat != null &&
                      element.stat!.name == 'special-attack',
                  orElse: () => Stats(effort: 0))
              .effort!
              .toDouble() /
          100;
      double specialDefence = remoteResponse.stats!
              .firstWhere(
                  (element) =>
                      element.stat != null &&
                      element.stat!.name == 'special-defense',
                  orElse: () => Stats(effort: 0))
              .effort!
              .toDouble() /
          100;
      double speed = remoteResponse.stats!
              .firstWhere(
                  (element) =>
                      element.stat != null && element.stat!.name == 'speed',
                  orElse: () => Stats(effort: 0))
              .effort!
              .toDouble() /
          100;
      pokemonStatsDataModel = PokemonStatsDataModel(
          hp: hp,
          attack: attack,
          defence: defence,
          specialAttack: specialAttack,
          specialDefence: specialDefence,
          speed: speed);
    }
    return pokemonStatsDataModel;
  }

  getPokemonTypesFromResp(PokemonDetailsRespModel remoteResponse) {
    PokemonTypesData? typesDataModel;
    if (remoteResponse.types != null && remoteResponse.types!.isNotEmpty) {
      String type = remoteResponse.types!
          .map((e) => e.type?.name.toString() ?? '')
          .toList()
          .join(', ');
      typesDataModel = PokemonTypesData(type: type);
    }
    return typesDataModel;
  }

  getPokemonAboutDataFromResp(PokemonDetailsRespModel remoteResponse) {
    String abilities =
        remoteResponse.abilities != null && remoteResponse.abilities!.isNotEmpty
            ? remoteResponse.abilities!
                .map((e) => e.ability?.name.toString() ?? '')
                .toList()
                .join(', ')
            : '';
    String height = remoteResponse.height != null
        ? (remoteResponse.height!.toDouble() / 10).toString()
        : '';
    String weight = remoteResponse.weight != null
        ? (remoteResponse.weight!.toDouble() / 10).toString()
        : '';
    return PokemonAboutDataModel(
        ability: abilities, habitat: '', height: height, weight: weight);
  }

  @override
  Future<Either<Failure, PokemonSpeciesDataModel>> getPokemonSpeciesDetails(
      int pokemonId) async {
    try {
      final PokemonSpeciesRespModel remoteResponse =
          await pokemonDetailsRemoteDataSource
              .getPokemonSpeciesDetails(pokemonId);
      String description = remoteResponse.flavorTextEntries!=null && remoteResponse.flavorTextEntries!.isNotEmpty?
       remoteResponse.flavorTextEntries!
          .map((e) => e.flavorText.toString())
          .toList()
          .join(' '): '';
          String habitat = remoteResponse.habitat!=null ? remoteResponse.habitat!.name.toString():'';
          String pokemonColor = remoteResponse.color!=null ? remoteResponse.color!.name.toString():'';
      PokemonSpeciesDataModel pokemonSpeciesDataModel = PokemonSpeciesDataModel(
        pokemonId: pokemonId,
        description: description,
        pokemonHabitat: habitat,
        pokemonColor: pokemonColor
      );
      return Right(pokemonSpeciesDataModel);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
