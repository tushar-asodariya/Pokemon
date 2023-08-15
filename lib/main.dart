import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:pokemon/core/network/internet_checker_bloc/internet_checker_cubit.dart';
import 'package:pokemon/core/router/router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(PokemonApp(
    router: AppRouter(), internetConnection: InternetConnection(),));
}

class PokemonApp extends StatelessWidget {
  const PokemonApp(
      {required this.router, required this.internetConnection, super.key});

  final AppRouter router;
  final InternetConnection internetConnection;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetCheckerCubit>(
          create: (context) => InternetCheckerCubit(internetConnection: internetConnection),
        ),

      ],
      child: BlocListener<InternetCheckerCubit, InternetState>(
        listener: (context, state) {
          if (state is InternetConnected) {
            BotToast.showText(text: 'Internet Connected');
          }
          else if (state is InternetDisconnected) {
            BotToast.showText(text: 'Internet Disconnected');
          }
        },
        child: MaterialApp(
          title: 'Pokemon',
          builder: BotToastInit(),
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          onGenerateRoute: router.onGenerateRoute,
        ),
      ),
    );
  }
}

