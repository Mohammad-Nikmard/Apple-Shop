import 'package:dartz/dartz.dart';

abstract class AuthenticationState {}

class AuthenticationInitState extends AuthenticationState {}

class AuthenticationLoadingState extends AuthenticationState {}

class AuthenticationLoginResponseState extends AuthenticationState {
  Either<String, String> loginMessage;

  AuthenticationLoginResponseState(this.loginMessage);
}

class AuthenticationRegisterResponseState extends AuthenticationState {
  Either<String, String> registerResponse;

  AuthenticationRegisterResponseState(this.registerResponse);
}
