import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:intl/intl.dart';
import 'package:pokemon/core/errors/exceptions.dart';
import 'package:pokemon/core/errors/failure.dart';
import 'package:pokemon/dependency_injection.dart';
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
import 'package:string_utils_extension/string_utils_extension.dart';

class PokemonDetailsRepositoryImpl extends PokemonDetailsRepository {
  final PokemonDetailsRemoteDataSource pokemonDetailsRemoteDataSource;

  PokemonDetailsRepositoryImpl({required this.pokemonDetailsRemoteDataSource});
  @override
  Future<Either<Failure, PokemonDetailsDataModel>> getPokemonDetails(
      int pokemonId) async {
    try {
      if (await getInstance<InternetConnection>().hasInternetAccess) {
        final PokemonDetailsRespModel remoteResponse =
            await pokemonDetailsRemoteDataSource.getPokemonDetails(pokemonId);

        PokemonDetailsDataModel pokemonDetailsDataModel =
            PokemonDetailsDataModel(
                pokemonId: pokemonId,
                aboutDataModel: getPokemonAboutDataFromResp(remoteResponse),
                movesDataModel: getPokemonMovesFromResp(remoteResponse),
                statsDataModel: getPokemonStatsFromResp(remoteResponse),
                typesDataModel: getPokemonTypesFromResp(remoteResponse));

        return Right(pokemonDetailsDataModel);
      } else {
        return Left(NoInternetFailure());
      }
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  List<PokemonMovesDataModel>? getPokemonMovesFromResp(
      PokemonDetailsRespModel remoteResponse) {
    List<PokemonMovesDataModel>? movesDataModel;
    if (remoteResponse.moves != null && remoteResponse.moves!.isNotEmpty) {
      for (var element in remoteResponse.moves!) {
        if (movesDataModel == null) {
          movesDataModel = [
            PokemonMovesDataModel(moves: element.move?.name ?? '')
          ];
        } else {
          movesDataModel
              .add(PokemonMovesDataModel(moves: element.move?.name ?? ''));
        }
      }
    }
    return movesDataModel;
  }

@override
  Future<Either<Failure, PokemonSpeciesDataModel>> getPokemonSpeciesDetails(
      int pokemonId) async {
    try {
      if (await getInstance<InternetConnection>().hasInternetAccess) {
        final PokemonSpeciesRespModel remoteResponse =
            await pokemonDetailsRemoteDataSource
                .getPokemonSpeciesDetails(pokemonId);
        List<FlavorTextEntries> flavourTextList =
            remoteResponse.flavorTextEntries != null &&
                    remoteResponse.flavorTextEntries!.isNotEmpty
                ? remoteResponse.flavorTextEntries!
                    .where((element) => element.language!.name == 'en')
                    .toList()
                : [];
        String description = remoteResponse.flavorTextEntries != null &&
                remoteResponse.flavorTextEntries!.isNotEmpty
            ? flavourTextList
                .map((e) => e.flavorText
                    .toString()
                    .replaceAll('\n', '')
                    .replaceAll('\f', ''))
                .toList()
                .join(' ')
            : '';
        description = description
            .split('.')
            .map((e) => toBeginningOfSentenceCase(e))
            .toList()
            .join('. ');
        String habitat = remoteResponse.habitat != null
            ? remoteResponse.habitat!.name.toString()
            : '';
        String pokemonColor = remoteResponse.color != null
            ? remoteResponse.color!.name.toString()
            : '';
        PokemonSpeciesDataModel pokemonSpeciesDataModel =
            PokemonSpeciesDataModel(
                pokemonId: pokemonId,
                description: description,
                pokemonHabitat: habitat,
                pokemonColor: pokemonColor);
        return Right(pokemonSpeciesDataModel);
      }
      else{
           return Left(NoInternetFailure());
      }
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  PokemonStatsDataModel? getPokemonStatsFromResp(
      PokemonDetailsRespModel remoteResponse) {
    PokemonStatsDataModel? pokemonStatsDataModel;
    if (remoteResponse.stats != null) {
      double hp = remoteResponse.stats!
              .firstWhere(
                  (Stats element) =>
                      element.stat != null && element.stat!.name == 'hp',
                  orElse: () => Stats(baseStat: 0))
              .baseStat!
              .toDouble() /
          100;
      double attack = remoteResponse.stats!
              .firstWhere(
                  (element) =>
                      element.stat != null && element.stat!.name == 'attack',
                  orElse: () => Stats(baseStat: 0))
              .baseStat!
              .toDouble() /
          100;
      double defence = remoteResponse.stats!
              .firstWhere(
                  (element) =>
                      element.stat != null && element.stat!.name == 'defense',
                  orElse: () => Stats(baseStat: 0))
              .baseStat!
              .toDouble() /
          100;
      double specialAttack = remoteResponse.stats!
              .firstWhere(
                  (element) =>
                      element.stat != null &&
                      element.stat!.name == 'special-attack',
                  orElse: () => Stats(baseStat: 0))
              .baseStat!
              .toDouble() /
          100;
      double specialDefence = remoteResponse.stats!
              .firstWhere(
                  (element) =>
                      element.stat != null &&
                      element.stat!.name == 'special-defense',
                  orElse: () => Stats(baseStat: 0))
              .baseStat!
              .toDouble() /
          100;
      double speed = remoteResponse.stats!
              .firstWhere(
                  (element) =>
                      element.stat != null && element.stat!.name == 'speed',
                  orElse: () => Stats(baseStat: 0))
              .baseStat!
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

  List<PokemonTypesData>? getPokemonTypesFromResp(
      PokemonDetailsRespModel remoteResponse) {
    List<PokemonTypesData>? typesDataModel;
    if (remoteResponse.types != null && remoteResponse.types!.isNotEmpty) {
      for (var element in remoteResponse.types!) {
        if (typesDataModel == null) {
          typesDataModel = [PokemonTypesData(type: element.type?.name ?? '')];
        } else {
          typesDataModel.add(PokemonTypesData(type: element.type?.name ?? ''));
        }
      }
    }
    return typesDataModel;
  }

  PokemonAboutDataModel getPokemonAboutDataFromResp(
      PokemonDetailsRespModel remoteResponse) {
    String abilities =
        remoteResponse.abilities != null && remoteResponse.abilities!.isNotEmpty
            ? remoteResponse.abilities!
                .map((e) => e.ability?.name.toString().toCapitalize() ?? '')
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
        ability: abilities, habitat: '', height: height, weight: weight, pokemonId: remoteResponse.id.toString());
  }

  }
