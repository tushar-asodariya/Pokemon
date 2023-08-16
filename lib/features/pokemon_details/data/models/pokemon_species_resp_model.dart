import 'package:pokemon/features/pokemon_details/domain/entities/pokemon_species_data_model.dart';

class PokemonSpeciesRespModel extends PokemonSpeciesDataModel {
  Color? color;
  List<FlavorTextEntries>? flavorTextEntries;
  Color? habitat;
  int? id;
  

  PokemonSpeciesRespModel(
      {
      color,
      flavorTextEntries,
      habitat,
      id,
   }) : super(pokemonId: id);

  PokemonSpeciesRespModel.fromJson(Map<String, dynamic> json) :super(pokemonId: json['id'] ){
 
    color = json['color'] != null ? Color.fromJson(json['color']) : null;
  
    if (json['flavor_text_entries'] != null) {
      flavorTextEntries = <FlavorTextEntries>[];
      json['flavor_text_entries'].forEach((v) {
        flavorTextEntries!.add(FlavorTextEntries.fromJson(v));
      });
    }
   
    id = json['id'];
   
    habitat =
        json['habitat'] != null ? Color.fromJson(json['habitat']) : null;
   
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
   
    if (color != null) {
      data['color'] = color!.toJson();
    }
   
    if (flavorTextEntries != null) {
      data['flavor_text_entries'] =
          flavorTextEntries!.map((v) => v.toJson()).toList();
    }
    
    if (habitat != null) {
      data['habitat'] = habitat!.toJson();
    }
    
    data['id'] = id;
   
   
   
    return data;
  }
}

class Color {
  String? name;
  String? url;

  Color({name, url});

  Color.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['url'] = url;
    return data;
  }
}


class FlavorTextEntries {
  String? flavorText;
  Color? language;
  Color? version;

  FlavorTextEntries({flavorText, language, version});

  FlavorTextEntries.fromJson(Map<String, dynamic> json) {
    flavorText = json['flavor_text'];
    language =
        json['language'] != null ? Color.fromJson(json['language']) : null;
    version =
        json['version'] != null ? Color.fromJson(json['version']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['flavor_text'] = flavorText;
    if (language != null) {
      data['language'] = language!.toJson();
    }
    if (version != null) {
      data['version'] = version!.toJson();
    }
    return data;
  }
}
