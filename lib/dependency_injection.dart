import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:pokemon/core/network/interceptor/dio_internetconnection_request_retriever.dart';
import 'package:pokemon/core/network/internet_checker_bloc/internet_checker_cubit.dart';
import 'package:pokemon/features/all_pokemons/data/dataSources/pokemon_list_remote_data_source.dart';
import 'package:pokemon/features/all_pokemons/domain/repositories/pokemon_list_repository.dart';
import 'package:pokemon/features/all_pokemons/domain/usecases/get_pokemon_list.dart';
import 'package:pokemon/features/all_pokemons/presentation/blocs/pokemon_list_bloc/pokemon_list_bloc.dart';

import 'core/router/router.dart';
import 'features/all_pokemons/data/repositories/pokemon_list_repository_impl.dart';

final getInstance = GetIt.instance;

Future<void> init() async {
  //! Features - Pokemon List
  // Bloc
  getInstance.registerFactory(
    () => PokemonListBloc(
      getPokemonList: getInstance(),
    ),
  );

  // Use cases
  getInstance.registerLazySingleton(() => GetPokemonList(
        pokemonListRepository: getInstance(),
      ));

  // Repository
  getInstance.registerLazySingleton<PokemonListRepository>(
    () => PokemonListRepositoryImpl(
      pokemonListRemoteDataSource: getInstance(),
    ),
  );

  // Data sources
  getInstance.registerLazySingleton<PokemonListRemoteDataSource>(
    () => PokemonListRemoteDataSourceImpl(dioClient: getInstance()),
  );

  //Core
  getInstance.registerLazySingleton(() => AppRouter());
  getInstance.registerFactory(
    () => InternetCheckerCubit(
      internetConnection: getInstance(),
    ),
  );

  //! External
   getInstance.registerFactory(() => DioInternetRequestRetriever(
      dioClient: getInstance(),
      internetConnection: getInstance<InternetConnection>()));
  getInstance.registerLazySingleton(() => Dio());
  getInstance.registerLazySingleton(() => InternetConnection());
}
