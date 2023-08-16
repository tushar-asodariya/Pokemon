class Abilities {
  Ability? ability;
  bool? isHidden;
  int? slot;

  Abilities({ ability,  isHidden,  slot});

  Abilities.fromJson(Map<String, dynamic> json) {
    ability =
        json['ability'] != null ?  Ability.fromJson(json['ability']) : null;
    isHidden = json['is_hidden'];
    slot = json['slot'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if ( ability != null) {
      data['ability'] =  ability!.toJson();
    }
    data['is_hidden'] =  isHidden;
    data['slot'] =  slot;
    return data;
  }
}

class Ability {
  String? name;
  String? url;

  Ability({ name,  url});

  Ability.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] =  name;
    data['url'] =  url;
    return data;
  }
}