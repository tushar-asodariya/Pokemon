import 'package:equatable/equatable.dart';

class PokemonListDataModel extends Equatable {
  final String? next;
  final String? previous;
  final List<PokemonNameDataModel> pokemonNameList;

  const PokemonListDataModel(
      {required this.next, required this.previous, required this.pokemonNameList});

  @override
  List<Object?> get props => [next, previous, pokemonNameList];
}


class PokemonNameDataModel extends Equatable {
  final String? name;
  final String? url;

  const PokemonNameDataModel({required this.name, required this.url});

  @override
  List<Object?> get props => [name, url];
}