// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class PokemonTypesData extends Equatable {
  final String type;
 const PokemonTypesData({
    required this.type,
  });
  

  @override
  List<Object> get props => [type, ];

  PokemonTypesData copyWith({
    String? type,
  }) {
    return PokemonTypesData(
      type: type ?? this.type,
    );
  }
}
