import 'package:apple_shop/BLoC/authentication/authentication_event.dart';
import 'package:apple_shop/BLoC/authentication/authentication_state.dart';
import 'package:apple_shop/data/repository/authnetication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final IAuthenticationRepository _authenticationRepository;
  AuthenticationBloc(this._authenticationRepository)
      : super(AuthenticationInitState()) {
    on<AuthenticationLoginEvent>(
      (event, emit) async {
        emit(AuthenticationLoadingState());
        var loginResponse = await _authenticationRepository.login(
            event.username, event.password);
        emit(AuthenticationLoginResponseState(loginResponse));
      },
    );

    on<AuthenticationRegisterEvent>(
      (event, emit) async {
        emit(AuthenticationLoadingState());
        var registerResponse = await _authenticationRepository.register(
            event.username, event.password, event.passwordConfirm);
        emit(AuthenticationRegisterResponseState(registerResponse));
      },
    );
  }
}
