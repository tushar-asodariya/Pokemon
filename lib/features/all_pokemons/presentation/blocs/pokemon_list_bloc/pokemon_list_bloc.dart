import 'package:bloc_concurrency/bloc_concurrency.dart';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:pokemon/core/constants/app_constants.dart';
import 'package:pokemon/core/errors/failure.dart';
import 'package:pokemon/features/all_pokemons/data/models/pokemon_list_req_model.dart';
import 'package:pokemon/features/all_pokemons/domain/entities/pokemon_name_data_model.dart';
import 'package:pokemon/features/all_pokemons/domain/usecases/get_pokemon_list.dart';
import 'package:pokemon/features/all_pokemons/presentation/blocs/pokemon_list_bloc/pokemon_list_event.dart';
import 'package:pokemon/features/all_pokemons/presentation/blocs/pokemon_list_bloc/pokemon_list_state.dart';
import 'package:stream_transform/stream_transform.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class PokemonListBloc extends Bloc<PokemonListEvent, PokemonListState> {
  final GetPokemonList getPokemonList;
  PokemonListReqModel pokemonListReqModel =
      PokemonListReqModel(limit: pokemonPageLimit, offset: 0);
  PokemonListBloc({required this.getPokemonList})
      : super(PokemonListLoading()) {
    on<PokemonListEvent>(
      _onPostFetched,
    );
    // transformer: throttleDroppable(throttleDuration));
  }

  Future<void> _onPostFetched(
    PokemonListEvent event,
    Emitter<PokemonListState> emit,
  ) async {
    try {
      if (event is GetPokemonListReTryEvent) {
        emit(PokemonListLoading());
      }
      if (event is GetMorePokemonListEvent) {
        emit(PokemonListLoadingMore());
      }
      final Either<Failure, PokemonListDataModel> pokemonApiResults =
          await getPokemonList(pokemonListReqModel);
      emit(_eitherSuccessOrErrorState(
        pokemonApiResults,
      ));
    } catch (e) {
      emit(PokemonListError(errMsg: e.toString()));
    }
  }

  PokemonListState _eitherSuccessOrErrorState(
    Either<Failure, PokemonListDataModel> failureOrTrivia,
  ) {
    return failureOrTrivia.fold(
      (failure) {
        String errorMsg = 'Something went wrong';
        if (failure is NoInternetFailure) {
          errorMsg = 'No Internet Connection';
        }
        return PokemonListError(errMsg: errorMsg);
      },
      (success) {
        return PokemonListSuccess(newData: success);
      },
    );
  }
}
