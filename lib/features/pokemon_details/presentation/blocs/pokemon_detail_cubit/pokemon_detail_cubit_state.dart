part of 'pokemon_detail_cubit.dart';

sealed class PokemonDetailCubitState with EquatableMixin {
  PokemonDetailCubitState();
  PokemonDetailsDataModel pokemonDetailsDataModel =
      // ignore: prefer_const_constructors, prefer_const_literals_to_create_immutables
      PokemonDetailsDataModel(pokemonId: -1);

  @override
  List<Object> get props => [pokemonDetailsDataModel];
}

final class PokemonDetailCubitLoading extends PokemonDetailCubitState {}

final class PokemonDetailCubitSuccess extends PokemonDetailCubitState {
  PokemonDetailCubitSuccess(PokemonDetailsDataModel newData) {
    pokemonDetailsDataModel = pokemonDetailsDataModel.copyWith(
      pokemonId: newData.pokemonId,
      aboutDataModel: newData.aboutDataModel,
      statsDataModel: newData.statsDataModel,
      movesDataModel: newData.movesDataModel,
      typesDataModel: newData.typesDataModel,
    );
  }
}

final class PokemonDetailCubitError extends PokemonDetailCubitState {
   final String errMsg;
  PokemonDetailCubitError({required this.errMsg});
}
