import 'package:equatable/equatable.dart';

abstract class PokemonListEvent with EquatableMixin {
 
  
}

class GetPokemonListEvent extends PokemonListEvent {

  @override
  List<Object> get props => [];
}
class GetMorePokemonListEvent extends PokemonListEvent {

  @override
  List<Object> get props => [];
}

class GetPokemonListReTryEvent extends PokemonListEvent {
  @override
  List<Object> get props => [];
}
