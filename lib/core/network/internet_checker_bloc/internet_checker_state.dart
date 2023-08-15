part of 'internet_checker_cubit.dart';

abstract class InternetState{
  bool showConnected = false;
}

class InternetLoading extends InternetState with EquatableMixin {
  @override
  List<Object?> get props => [showConnected];
}

class InternetConnected extends InternetState with EquatableMixin {
  @override
  List<Object?> get props => [showConnected];
}

class InternetDisconnected extends InternetState with EquatableMixin {
  @override
  set showConnected(bool showConnected) {
    super.showConnected = showConnected;
  }
  @override
  List<Object?> get props => [showConnected];
}

