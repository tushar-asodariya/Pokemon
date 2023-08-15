import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:pokemon/core/network/interceptor/dio_internetconnection_request_retriever.dart';
import 'package:pokemon/core/network/internet_checker_bloc/internet_checker_cubit.dart';
import 'package:pokemon/core/router/router.dart';
import 'package:pokemon/features/all_pokemons/domain/usecases/get_pokemon_list.dart';
import 'package:pokemon/features/all_pokemons/presentation/blocs/pokemon_list_bloc/pokemon_list_bloc.dart';
import 'package:pokemon/pokemon_blocs_observer.dart';
import 'core/network/interceptor/pretty_dio_logger.dart';
import 'dependency_injection.dart' as di;

import 'core/network/interceptor/retry_interceptor.dart';
import 'features/all_pokemons/presentation/blocs/pokemon_list_bloc/pokemon_list_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  Bloc.observer = const PokemonAllBlocObserver();

  Dio dioClient = di.getInstance<Dio>();
  //to retry pending api calls when internet gets available again
  dioClient.interceptors.addAll([
    RetryOnInternetChangeInterceptor(
        internetRequestRetriever: di.getInstance()),
    Logging(),
    PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90)
  ]);
  runApp(const PokemonApp());
}

class PokemonApp extends StatelessWidget {
  const PokemonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetCheckerCubit>(
          create: (context) => InternetCheckerCubit(
              internetConnection: di.getInstance<InternetConnection>()),
        ),
        BlocProvider<PokemonListBloc>(
            create: (context) => di.getInstance<PokemonListBloc>()..add(GetPokemonListEvent()))
      ],
      child: BlocListener<InternetCheckerCubit, InternetState>(
        listener: (context, state) {
          if (state is InternetConnected) {
            BotToast.showText(text: 'Internet Connected');
          } else if (state is InternetDisconnected) {
            BotToast.showText(text: 'Internet Disconnected');
          }
        },
        child: MaterialApp(
          title: 'Pokemon',
          builder: BotToastInit(),
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          onGenerateRoute: di.getInstance<AppRouter>().onGenerateRoute,
        ),
      ),
    );
  }
}
