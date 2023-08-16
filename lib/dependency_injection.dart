import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:pokemon/core/network/interceptor/dio_internetconnection_request_retriever.dart';
import 'package:pokemon/features/all_pokemons/data/dataSources/pokemon_list_remote_data_source.dart';
import 'package:pokemon/features/all_pokemons/domain/repositories/pokemon_list_repository.dart';
import 'package:pokemon/features/all_pokemons/domain/usecases/get_pokemon_list.dart';
import 'package:pokemon/features/all_pokemons/presentation/blocs/pokemon_list_bloc/pokemon_list_bloc.dart';
import 'package:pokemon/features/pokemon_details/data/dataSources/pokemon_details_remote_data_source.dart';
import 'package:pokemon/features/pokemon_details/data/repositories/pokemon_details_repository_impl.dart';
import 'package:pokemon/features/pokemon_details/domain/repositories/pokemon_details_repository.dart';
import 'package:pokemon/features/pokemon_details/domain/usecases/get_pokemon_details.dart';
import 'package:pokemon/features/pokemon_details/domain/usecases/get_pokemon_species.dart';
import 'package:pokemon/features/pokemon_details/presentation/blocs/pokemon_detail_cubit/pokemon_detail_cubit.dart';
import 'package:pokemon/features/pokemon_details/presentation/blocs/pokemon_species_cubit/pokemon_species_cubit.dart';

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
  //Cubit
   getInstance.registerFactory(
    () => PokemonDetailCubit(
      getPokemonDetails: getInstance(),
    ),
  );
   getInstance.registerFactory(
    () => PokemonSpeciesCubit(
      getPokemonSpecies: getInstance(),
    ),
  );

  // Use cases
  getInstance.registerLazySingleton(() => GetPokemonList(
        pokemonListRepository: getInstance(),
      ));
  getInstance.registerLazySingleton(() => GetPokemonDetails(
        pokemonDetailsRepository: getInstance(),
      ));
  getInstance.registerLazySingleton(() => GetPokemonSpecies(
        pokemonDetailsRepository: getInstance(),
      ));

  // Repository
  getInstance.registerLazySingleton<PokemonListRepository>(
    () => PokemonListRepositoryImpl(
      pokemonListRemoteDataSource: getInstance(),
    ),
  );
  getInstance.registerLazySingleton<PokemonDetailsRepository>(
    () => PokemonDetailsRepositoryImpl(
      pokemonDetailsRemoteDataSource: getInstance(),
    ),
  );

  // Data sources
  getInstance.registerLazySingleton<PokemonListRemoteDataSource>(
    () => PokemonListRemoteDataSourceImpl(dioClient: getInstance()),
  );
  getInstance.registerLazySingleton<PokemonDetailsRemoteDataSource>(
    () => PokemonDetailsRemoteDataSourceImpl(dioClient: getInstance()),
  );


  //Core
  getInstance.registerLazySingleton(() => AppRouter());


  //! External
   getInstance.registerFactory(() => DioInternetRequestRetriever(
      dioClient: getInstance(),
      internetConnection: getInstance<InternetConnection>()));
  getInstance.registerLazySingleton(() => Dio());
  getInstance.registerLazySingleton(() => InternetConnection());
}
