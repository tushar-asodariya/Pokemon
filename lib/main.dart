import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/core/router/router.dart';
import 'package:pokemon/features/all_pokemons/presentation/blocs/pokemon_list_bloc/pokemon_list_bloc.dart';
import 'package:pokemon/features/pokemon_details/domain/usecases/get_pokemon_details.dart';
import 'package:pokemon/features/pokemon_details/domain/usecases/get_pokemon_species.dart';
import 'package:pokemon/features/pokemon_details/presentation/blocs/pokemon_detail_cubit/pokemon_detail_cubit.dart';
import 'package:pokemon/features/pokemon_details/presentation/blocs/pokemon_species_cubit/pokemon_species_cubit.dart';
import 'core/network/interceptor/pretty_dio_logger.dart';
import 'dependency_injection.dart' as di;

import 'core/network/interceptor/retry_interceptor.dart';
import 'features/all_pokemons/presentation/blocs/pokemon_list_bloc/pokemon_list_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  Dio dioClient = di.getInstance<Dio>();
  //to retry pending api calls when internet gets available again
  dioClient.interceptors.add(
    RetryOnInternetChangeInterceptor(
        internetRequestRetriever: di.getInstance()),
  );
  if (kDebugMode) {
    dioClient.interceptors.addAll([
      RetryOnInternetChangeInterceptor(
          internetRequestRetriever: di.getInstance()),
      PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90)
    ]);
  }
  runApp(const PokemonApp());
}

class PokemonApp extends StatelessWidget {
  const PokemonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
       
        BlocProvider<PokemonListBloc>(
            create: (context) =>
                di.getInstance<PokemonListBloc>()..add(GetPokemonListEvent())),
        BlocProvider<PokemonDetailCubit>(
          create: (context) => PokemonDetailCubit(
              getPokemonDetails: di.getInstance<GetPokemonDetails>()),
        ),
        BlocProvider<PokemonSpeciesCubit>(
          create: (context) => PokemonSpeciesCubit(
              getPokemonSpecies: di.getInstance<GetPokemonSpecies>()),
        ),
      ],
      child: MaterialApp(
        title: 'Pokemon',
        builder: BotToastInit(),
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        navigatorObservers: [BotToastNavigatorObserver()],
        onGenerateRoute: di.getInstance<AppRouter>().onGenerateRoute,
      ),
    );
  }
}
