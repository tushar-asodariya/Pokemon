// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class PokemonMovesDataModel extends Equatable {
  final String moves;
  const PokemonMovesDataModel({
    required this.moves,
  });

  PokemonMovesDataModel copyWith({
    String? moves,
  }) {
    return PokemonMovesDataModel(
      moves: moves ?? this.moves,
    );
  }

  @override
  List<Object> get props => [moves];
}
