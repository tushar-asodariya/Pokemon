// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:pokemon/features/pokemon_details/domain/entities/pokemon_about_data_model.dart';
import 'package:pokemon/features/pokemon_details/domain/entities/pokemon_moves_data_model.dart';
import 'package:pokemon/features/pokemon_details/domain/entities/pokemon_stats_data_model.dart';
import 'package:pokemon/features/pokemon_details/domain/entities/pokemon_types_data_model.dart';

class PokemonDetailsDataModel extends Equatable {
  final int pokemonId;
  final PokemonAboutDataModel? aboutDataModel;
  final PokemonStatsDataModel? statsDataModel;
  final List<PokemonMovesDataModel>? movesDataModel;
  final List<PokemonTypesData>? typesDataModel;
  const PokemonDetailsDataModel({
    required this.pokemonId,
     this.aboutDataModel,
     this.statsDataModel,
     this.movesDataModel,
     this.typesDataModel,
  });

  PokemonDetailsDataModel copyWith({
    int? pokemonId,
    PokemonAboutDataModel? aboutDataModel,
    PokemonStatsDataModel? statsDataModel,
    List<PokemonMovesDataModel>? movesDataModel,
    List<PokemonTypesData>? typesDataModel,
  }) {
    return PokemonDetailsDataModel(
      pokemonId: pokemonId ?? this.pokemonId,
      aboutDataModel: aboutDataModel ?? this.aboutDataModel,
      statsDataModel: statsDataModel ?? this.statsDataModel,
      movesDataModel: movesDataModel ?? this.movesDataModel,
      typesDataModel: typesDataModel ?? this.typesDataModel,
    );
  }

  @override
  List<Object> get props {
    return [
     
      pokemonId,
      
    ];
  }
}
