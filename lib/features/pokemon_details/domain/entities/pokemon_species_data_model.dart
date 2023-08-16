// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class PokemonSpeciesDataModel extends Equatable {
  final int pokemonId;
  final String? pokemonColor;
  final String? description;
  final String? pokemonHabitat;
  const PokemonSpeciesDataModel({
    required this.pokemonId,
    this.pokemonColor,
    this.description,
    this.pokemonHabitat,
  });

  PokemonSpeciesDataModel copyWith({
    int? pokemonId,
    String? pokemonColor,
    String? description,
    String? habitat,
  }) {
    return PokemonSpeciesDataModel(
      pokemonId: pokemonId ?? this.pokemonId,
      pokemonColor: pokemonColor ?? this.pokemonColor,
      description: description ?? this.description,
      pokemonHabitat: habitat ?? pokemonHabitat,
    );
  }

  @override
  List<Object> get props => [
        pokemonId,
      ];
}
