import 'package:equatable/equatable.dart';
import 'package:pokemon/core/constants/app_constants.dart';
import 'package:pokemon/features/all_pokemons/data/models/pokemon_list_req_model.dart';
import 'package:pokemon/features/all_pokemons/domain/entities/pokemon_name_data_model.dart';

abstract class PokemonListState with EquatableMixin {
  PokemonListReqModel pokemonListReqModel =
      PokemonListReqModel(limit: pokemonPageLimit, offset: 0);
  PokemonListDataModel pokemonListDataModel =
      // ignore: prefer_const_constructors, prefer_const_literals_to_create_immutables
      PokemonListDataModel(next: null, previous: null, pokemonNameList: []);
}

class PokemonListLoading extends PokemonListState {
  @override
  List<Object?> get props => [pokemonListDataModel, pokemonListReqModel];
}

class PokemonListSuccess extends PokemonListState {
  PokemonListSuccess({required PokemonListDataModel newData}) {
    pokemonListDataModel = pokemonListDataModel.copyWith(
        next: newData.next,
        previous: newData.previous,
        pokemonNameList: newData.pokemonNameList);
  }
  @override
  List<Object?> get props => [pokemonListDataModel, pokemonListReqModel];
}

class PokemonListError extends PokemonListState {
  final String errMsg;
  PokemonListError({required this.errMsg});
  @override
  List<Object?> get props => [pokemonListDataModel, pokemonListReqModel];
}
