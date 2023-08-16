part of 'pokemon_species_cubit.dart';

sealed class PokemonSpeciesCubitState with EquatableMixin {
  PokemonSpeciesCubitState();
  PokemonSpeciesDataModel pokemonSpeciesDataModel =
      // ignore: prefer_const_constructors, prefer_const_literals_to_create_immutables
      PokemonSpeciesDataModel(pokemonId: -1);

  @override
  List<Object> get props => [];
}

final class PokemonSpeciesCubitLoading extends PokemonSpeciesCubitState {}

final class PokemonSpeciesCubitSuccess extends PokemonSpeciesCubitState {
  PokemonSpeciesCubitSuccess(PokemonSpeciesDataModel newData) {
    pokemonSpeciesDataModel = pokemonSpeciesDataModel.copyWith(
      pokemonId: newData.pokemonId,
      pokemonColor: newData.pokemonColor,
      description: newData.description,
      habitat: newData.pokemonHabitat,
    );
  }
}

final class PokemonSpeciesCubitError extends PokemonSpeciesCubitState {
   final String errMsg;
  PokemonSpeciesCubitError({required this.errMsg});
}
