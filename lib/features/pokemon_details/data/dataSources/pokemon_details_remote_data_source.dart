import 'package:dio/dio.dart';
import 'package:pokemon/core/constants/api_path_constants.dart';
import 'package:pokemon/core/errors/exceptions.dart';
import 'package:pokemon/features/pokemon_details/data/models/pokemon_details_resp_model.dart';
import 'package:pokemon/features/pokemon_details/data/models/pokemon_species_resp_model.dart';

abstract class PokemonDetailsRemoteDataSource {
  Future<PokemonDetailsRespModel> getPokemonDetails(int pokemonId);
  Future<PokemonSpeciesRespModel> getPokemonSpeciesDetails(int pokemonId);
}

class PokemonDetailsRemoteDataSourceImpl
    extends PokemonDetailsRemoteDataSource {
  final Dio dioClient;

  PokemonDetailsRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<PokemonDetailsRespModel> getPokemonDetails(int pokemonId) async {
    final response = await dioClient.get(
      '${ApiPath.pokemonList}/$pokemonId',
    );

    if (response.statusCode == 200) {
      return PokemonDetailsRespModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<PokemonSpeciesRespModel> getPokemonSpeciesDetails(
      int pokemonId) async {
    final response = await dioClient.get(
      '${ApiPath.pokemonSpeciesDetails}/$pokemonId',
    );

    if (response.statusCode == 200) {
      return PokemonSpeciesRespModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }
}
