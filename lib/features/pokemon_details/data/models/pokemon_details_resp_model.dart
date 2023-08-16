import 'package:pokemon/features/pokemon_details/data/models/pokemon_abilites_resp_model.dart';
import 'package:pokemon/features/pokemon_details/data/models/pokemon_moves_resp_model.dart';
import 'package:pokemon/features/pokemon_details/data/models/pokemon_stats_resp_model.dart';
import 'package:pokemon/features/pokemon_details/data/models/pokemon_types_resp_model.dart';
import 'package:pokemon/features/pokemon_details/domain/entities/pokemon_details_data_model.dart';

// ignore: must_be_immutable
class PokemonDetailsRespModel extends PokemonDetailsDataModel {
  List<Abilities>? abilities;
  int? height;
  int? id;
  List<Moves>? moves;
  String? name;
  int? order;
  List<Stats>? stats;
  List<Types>? types;
  int? weight;

  PokemonDetailsRespModel(
      {abilities,
      height,
      id,
      moves,
      name,
      order,
      stats,
      types,
      weight}) : super(pokemonId: id);

  PokemonDetailsRespModel.fromJson(Map<String, dynamic> json):super(pokemonId: json['id'] ) {
    if (json['abilities'] != null) {
      abilities = <Abilities>[];
      json['abilities'].forEach((v) {
        abilities!.add( Abilities.fromJson(v));
      });
    }
   
   
  
    height = json['height'];
   
    id = json['id'];
   
    if (json['moves'] != null) {
      moves = <Moves>[];
      json['moves'].forEach((v) {
        moves!.add( Moves.fromJson(v));
      });
    }
    name = json['name'];
    order = json['order'];
   
   
    if (json['stats'] != null) {
      stats = <Stats>[];
      json['stats'].forEach((v) {
        stats!.add( Stats.fromJson(v));
      });
    }
    if (json['types'] != null) {
      types = <Types>[];
      json['types'].forEach((v) {
        types!.add( Types.fromJson(v));
      });
    }
    weight = json['weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (abilities != null) {
      data['abilities'] = abilities!.map((v) => v.toJson()).toList();
    }
    
    data['height'] = height;
  
    data['id'] = id;
   
    if (moves != null) {
      data['moves'] = moves!.map((v) => v.toJson()).toList();
    }
    data['name'] = name;
    data['order'] = order;
    
    if (stats != null) {
      data['stats'] = stats!.map((v) => v.toJson()).toList();
    }
    if (types != null) {
      data['types'] = types!.map((v) => v.toJson()).toList();
    }
    data['weight'] = weight;
    return data;
  }
}




