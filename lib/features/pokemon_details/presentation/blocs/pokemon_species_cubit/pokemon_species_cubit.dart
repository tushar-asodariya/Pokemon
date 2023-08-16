import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pokemon/core/errors/failure.dart';
import 'package:pokemon/features/pokemon_details/domain/entities/pokemon_species_data_model.dart';
import 'package:pokemon/features/pokemon_details/domain/usecases/get_pokemon_species.dart';

part 'pokemon_species_cubit_state.dart';

class PokemonSpeciesCubit extends Cubit<PokemonSpeciesCubitState> {
  final GetPokemonSpecies getPokemonSpecies;
  PokemonSpeciesCubit({required this.getPokemonSpecies}) : super(PokemonSpeciesCubitLoading());

   void emitGetPokemonSpecies(int pokemonId) async {
    emit(PokemonSpeciesCubitLoading());
    final repoResponse = await getPokemonSpecies(Params(pokemonId: pokemonId));
    emit(_eitherSuccessOrErrorState(repoResponse));
  }

  PokemonSpeciesCubitState _eitherSuccessOrErrorState(
    Either<Failure, PokemonSpeciesDataModel> failureOrTrivia,
  ) {
    return failureOrTrivia.fold(
      (failure) => PokemonSpeciesCubitError(errMsg: 'Something went wrong'),
      (success) {
        return PokemonSpeciesCubitSuccess(success);
      },
    );
  }
}
