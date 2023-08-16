import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pokemon/core/errors/failure.dart';
import 'package:pokemon/features/pokemon_details/domain/entities/pokemon_details_data_model.dart';
import 'package:pokemon/features/pokemon_details/domain/usecases/get_pokemon_details.dart';
import 'package:pokemon/features/pokemon_details/domain/usecases/get_pokemon_species.dart';

part 'pokemon_detail_cubit_state.dart';

class PokemonDetailCubit extends Cubit<PokemonDetailCubitState> {
  final GetPokemonDetails getPokemonDetails;
  PokemonDetailCubit({required this.getPokemonDetails})
      : super(PokemonDetailCubitLoading());

  void emitGetPokemonDetails(int pokemonId) async {
    emit(PokemonDetailCubitLoading());
    final repoResponse = await getPokemonDetails(Params(pokemonId: pokemonId));
    emit(_eitherSuccessOrErrorState(repoResponse));
  }

  PokemonDetailCubitState _eitherSuccessOrErrorState(
    Either<Failure, PokemonDetailsDataModel> failureOrTrivia,
  ) {
    return failureOrTrivia.fold(
      (failure) {
        String errorMsg = 'Something went wrong';
        if (failure is NoInternetFailure) {
          errorMsg = 'No Internet Connection';
        }
        return PokemonDetailCubitError(errMsg: errorMsg);
      },
      (success) {
        return PokemonDetailCubitSuccess(success);
      },
    );
  }
}
