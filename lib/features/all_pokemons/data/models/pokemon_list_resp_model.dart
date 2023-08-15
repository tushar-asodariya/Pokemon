import 'package:equatable/equatable.dart';
import 'package:pokemon/features/all_pokemons/domain/entities/pokemon_name_data_model.dart';
import 'pokemon_name_resp_model.dart';

class PokemonListRespModel extends PokemonListDataModel with EquatableMixin {
  int count;
  String next;
  String previous;
  List<PokemonNameRespModel> results;

  PokemonListRespModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  }) : super(next: next, previous: previous, pokemonNameList: results);

  @override
  List<Object?> get props => [count, next, previous, results];

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'next': next,
      'previous': previous,
      'results': results,
    };
  }

  factory PokemonListRespModel.fromJson(Map<String, dynamic> json) {
    return PokemonListRespModel(
      count: json['count'] as int,
      next: json['next'] as String,
      previous: json['previous'] as String,
      results: (json['results'] as List<dynamic>)
          .map((e) => PokemonNameRespModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
