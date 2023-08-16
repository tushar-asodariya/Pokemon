// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class PokemonAboutDataModel extends Equatable {
  final String ability;
  final String habitat;
  final String height;
  final String weight;
  final String pokemonId;
  const PokemonAboutDataModel({
    required this.ability,
    required this.habitat,
    required this.height,
    required this.weight,
    required this.pokemonId,
  });

  PokemonAboutDataModel copyWith({
    String? ability,
    String? habitat,
    String? height,
    String? weight,
    String? pokemonId,
  }) {
    return PokemonAboutDataModel(
      ability: ability ?? this.ability,
      habitat: habitat ?? this.habitat,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      pokemonId: pokemonId ?? this.pokemonId,
    );
  }

  @override
  List<Object> get props => [ability, habitat, height, weight, pokemonId];
}
