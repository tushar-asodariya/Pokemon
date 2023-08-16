import 'package:pokemon/features/pokemon_details/data/models/pokemon_abilites_resp_model.dart';

class Types {
  int? slot;
  Ability? type;

  Types({ slot,  type});

  Types.fromJson(Map<String, dynamic> json) {
    slot = json['slot'];
    type = json['type'] != null ?  Ability.fromJson(json['type']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =   <String, dynamic>{};
    data['slot'] =  slot;
    if ( type != null) {
      data['type'] =  type!.toJson();
    }
    return data;
  }
}
