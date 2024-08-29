part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}
final class LodingHomestate extends HomeState {}
final class errorHomestate extends HomeState {
  String msg ;
  errorHomestate(this.msg);

}
final class succesHomestat extends HomeState {}
