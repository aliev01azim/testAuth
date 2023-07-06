part of 'internet_cubit.dart';

@immutable
abstract class InternetState {}

class InternetLoadingState extends InternetState {}

class InternetConnectedState extends InternetState {}

class InternetDisconnectedState extends InternetState {}
