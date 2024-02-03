abstract class AuthenticationEvent {}

class AuthenticationLoginEvent extends AuthenticationEvent {
  String username;
  String password;

  AuthenticationLoginEvent(this.username, this.password);
}

class AuthenticationRegisterEvent extends AuthenticationEvent {
  String username;
  String password;
  String passwordConfirm;

  AuthenticationRegisterEvent(
      this.username, this.password, this.passwordConfirm);
}
