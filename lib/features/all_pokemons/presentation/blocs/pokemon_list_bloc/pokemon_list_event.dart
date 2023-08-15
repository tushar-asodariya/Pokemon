import 'package:equatable/equatable.dart';
import 'package:pokemon/features/all_pokemons/data/models/pokemon_list_req_model.dart';

abstract class PokemonListEvent with EquatableMixin {}

class GetPokemonListEvent extends PokemonListEvent {  @override
  List<Object> get props => [];}

class GetPokemonListReTryEvent extends PokemonListEvent {
  @override
  List<Object> get props => [];
}
