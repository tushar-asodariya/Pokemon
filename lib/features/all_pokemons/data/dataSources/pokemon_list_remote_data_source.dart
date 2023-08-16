// ignore: unused_import
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pokemon/core/constants/api_path_constants.dart';
import 'package:pokemon/core/errors/exceptions.dart';
import 'package:pokemon/features/all_pokemons/data/models/pokemon_list_req_model.dart';
import 'package:pokemon/features/all_pokemons/data/models/pokemon_list_resp_model.dart';

abstract class PokemonListRemoteDataSource{
  Future<PokemonListRespModel> getPokemonList({required PokemonListReqModel pokemonListReqParamsModel});
}


class PokemonListRemoteDataSourceImpl extends PokemonListRemoteDataSource{
  final Dio dioClient;
  PokemonListRemoteDataSourceImpl({required this.dioClient});
  @override
  Future<PokemonListRespModel> getPokemonList({required PokemonListReqModel pokemonListReqParamsModel}) async{
    final response = await dioClient.get(
      ApiPath.pokemonList,
      queryParameters: pokemonListReqParamsModel.toJson()
    );

    if (response.statusCode == 200) {
      return PokemonListRespModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }

}