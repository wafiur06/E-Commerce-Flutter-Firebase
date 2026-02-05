part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  List<Object?> get props => [
    emailController,
    passwordController,
  ];
}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailed extends LoginState {
  final String message;

  LoginFailed(this.message);
}

class LogOutSuccess extends LoginState {}

class LogOutFailed extends LoginState {
  final String message;

  LogOutFailed({required this.message});

  @override
  List<Object?> get props => [message];
}
