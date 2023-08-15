import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

part 'internet_checker_state.dart';

class InternetCheckerCubit extends Cubit<InternetState>{
  InternetCheckerCubit({required this.internetConnection}) : super(InternetLoading()){
    internetConnectionStreamSubscription = monitorInternetConnection();
  }

  final InternetConnection internetConnection;
  late StreamSubscription internetConnectionStreamSubscription;
  void emitInternetConnected() => emit(InternetConnected());
  void emitInternetDisconnected() => emit(InternetDisconnected());
  bool showConnected = false;
  StreamSubscription<InternetStatus> monitorInternetConnection(){
    return  internetConnection.onStatusChange.listen((event) {
      switch(event){
        case InternetStatus.connected:
          if(showConnected) {
            emitInternetConnected();
          }
          break;
        case InternetStatus.disconnected:
          showConnected = true;
          emitInternetDisconnected();
          break;
      }
    });
  }

  @override
  Future<void> close() async  {
    internetConnectionStreamSubscription.cancel();
    super.close();
  }

}