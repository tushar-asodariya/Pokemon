import 'package:equatable/equatable.dart';

class PokemonListReqModel with EquatableMixin {
  int limit;
  int offset;

  PokemonListReqModel({
    required this.limit,
    required this.offset,
  });

  @override
  List<Object?> get props => [limit, offset];

  Map<String, dynamic> toJson() {
    return {
      'limit': limit,
      'offset': offset,
    };
  }

  factory PokemonListReqModel.fromJson(Map<String, dynamic> json) {
    return PokemonListReqModel(
      limit: json['limit'] as int,
      offset: json['offset'] as int,
    );
  }
}
