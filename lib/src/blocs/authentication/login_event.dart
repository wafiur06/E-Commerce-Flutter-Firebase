part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class RequestGoogleLogin extends LoginEvent{}

class RequestFacebookLogin extends LoginEvent{}

class RequestTwitterLogin extends LoginEvent{}

class RequestSignOut extends LoginEvent{}

class RequestEmailLogin extends LoginEvent{
  final String email;
  final String password;
  final bool isRememberMe;

  RequestEmailLogin({
    required this.email,
    required this.password,
    required this.isRememberMe ,
  });

  @override
  List<Object?> get props => [email, password, isRememberMe];
}