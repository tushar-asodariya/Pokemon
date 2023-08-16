import 'package:pokemon/features/pokemon_details/data/models/pokemon_abilites_resp_model.dart';

class Moves {
  Ability? move;

  Moves({move, versionGroupDetails});

  Moves.fromJson(Map<String, dynamic> json) {
    move = json['move'] != null ? Ability.fromJson(json['move']) : null;
   
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (move != null) {
      data['move'] = move!.toJson();
    }
  
    return data;
  }
}

