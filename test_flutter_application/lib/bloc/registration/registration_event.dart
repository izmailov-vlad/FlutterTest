abstract class RegistrationEvent {}

class RegisterEvent extends RegistrationEvent {
  String login;
  String password;
  RegisterEvent(this.login, this.password);
}
