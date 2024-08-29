part of 'main_cubit.dart';

@immutable
abstract class MainState {}

class MainInitial extends MainState {}

class MainLoading extends MainState {}

class MainLoaded extends MainState {

}

class MainError extends MainState {
  final String message;

  MainError(this.message);
}
