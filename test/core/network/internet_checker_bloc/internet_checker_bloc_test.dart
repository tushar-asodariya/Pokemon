import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:pokemon/core/network/internet_checker_bloc/internet_checker_cubit.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  late InternetCheckerCubit internetCheckerCubit;

  setUp(() {
    WidgetsFlutterBinding.ensureInitialized();

    internetCheckerCubit =
        InternetCheckerCubit(internetConnection: InternetConnection());
  });
  group('InternetCheckerCubit', () {
    test('initial state of InternetCheckerCubit is InternetLoading', () {
      expect(internetCheckerCubit.state, InternetLoading());
    });

    blocTest<InternetCheckerCubit, InternetState>(
        'the InternetCheckerCubit should emit a InternetConnected() when emitInternetConnected() is called',
        build: () => internetCheckerCubit,
        act: (cubit) => cubit.emitInternetConnected(),
        expect: ()=> [InternetConnected()]);

   

    blocTest<InternetCheckerCubit, InternetState>(
        'the InternetCheckerCubit should emit a InternetDisconnected() when emitInternetDisconnected() is called',
        build: () => internetCheckerCubit,
        act: (cubit) => cubit.emitInternetDisconnected(),
        expect: ()=> [InternetDisconnected()]);

   
    tearDown(() {
      internetCheckerCubit.close();
    });
  });
}
