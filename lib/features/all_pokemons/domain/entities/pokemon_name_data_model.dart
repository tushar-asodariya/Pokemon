// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class PokemonListDataModel extends Equatable {
  final String? next;
  final String? previous;
  final List<PokemonNameDataModel> pokemonNameList;

  const PokemonListDataModel(
      {required this.next, required this.previous, required this.pokemonNameList});

  @override
  List<Object?> get props => [next, previous, pokemonNameList];

  PokemonListDataModel copyWith({
    String? next,
    String? previous,
    List<PokemonNameDataModel>? pokemonNameList,
  }) {
    return PokemonListDataModel(
      next: next ?? this.next,
     previous: previous ?? this.previous,
     pokemonNameList: pokemonNameList ?? this.pokemonNameList,
    );
  }

}


class PokemonNameDataModel extends Equatable {
  final String? name;
  final String? url;

  const PokemonNameDataModel({required this.name, required this.url});

  @override
  List<Object?> get props => [name, url];

  PokemonNameDataModel copyWith({
    String? name,
    String? url,
  }) {
    return PokemonNameDataModel(
      name: name ?? this.name,
      url: url ?? this.url,
    );
  }
}
