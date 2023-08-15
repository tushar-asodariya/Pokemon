part of 'internet_checker_cubit.dart';

@immutable
abstract class InternetState {
  bool showConnected = false;
}

class InternetLoading extends InternetState {}

class InternetConnected extends InternetState {}

class InternetDisconnected extends InternetState {
  @override
  set showConnected(bool _showConnected) {
    super.showConnected = _showConnected;
  }
}

