part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}
final class LoginLoadingstate extends LoginState {}
final class LoginSuccesstate extends LoginState {}
final class Loginerrorstate extends LoginState {
   final msg;
  Loginerrorstate(this.msg);

}
