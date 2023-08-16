// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class PokemonStatsDataModel extends Equatable {
  final double hp;
  final double attack;
  final double defence;
  final double specialAttack;
  final double specialDefence;
  final double speed;
  const PokemonStatsDataModel({
    required this.hp,
    required this.attack,
    required this.defence,
    required this.specialAttack,
    required this.specialDefence,
    required this.speed,
  });
  

  @override
  List<Object> get props {
    return [
      hp,
      attack,
      defence,
      specialAttack,
      specialDefence,
      speed,
    ];
  }

  PokemonStatsDataModel copyWith({
    double? hp,
    double? attack,
    double? defence,
    double? specialAttack,
    double? specialDefence,
    double? speed,
  }) {
    return PokemonStatsDataModel(
      hp: hp ?? this.hp,
      attack: attack ?? this.attack,
      defence: defence ?? this.defence,
      specialAttack: specialAttack ?? this.specialAttack,
      specialDefence: specialDefence ?? this.specialDefence,
      speed: speed ?? this.speed,
    );
  }
}
