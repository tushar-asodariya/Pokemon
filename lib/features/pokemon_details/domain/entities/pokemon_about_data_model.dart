// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class PokemonAboutDataModel extends Equatable {
  final String ability;
  final String habitat;
  final String height;
  final String weight;
  
  const PokemonAboutDataModel({
    required this.ability,
    required this.habitat,
    required this.height,
    required this.weight,
  });

  PokemonAboutDataModel copyWith({
    String? ability,
    String? habitat,
    String? height,
    String? weight,
  }) {
    return PokemonAboutDataModel(
      ability: ability ?? this.ability,
      habitat: habitat ?? this.habitat,
      height: height ?? this.height,
      weight: weight ?? this.weight,
    );
  }

  @override
  List<Object> get props => [ability, habitat, height, weight];
}
