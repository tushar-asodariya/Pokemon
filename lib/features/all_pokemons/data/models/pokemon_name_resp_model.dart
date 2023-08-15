import 'package:equatable/equatable.dart';
import 'package:pokemon/features/all_pokemons/domain/entities/pokemon_name_data_model.dart';

class PokemonNameRespModel extends PokemonNameDataModel with EquatableMixin {
  String name;
  String url;

  PokemonNameRespModel({
    required this.name,
    required this.url,
  }) : super(name: name, url: url);

  @override
  List<Object?> get props => [name, url];

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
    };
  }

  factory PokemonNameRespModel.fromJson(Map<String, dynamic> json) {
    return PokemonNameRespModel(
      name: json['name'] as String,
      url: json['url'] as String,
    );
  }
}
