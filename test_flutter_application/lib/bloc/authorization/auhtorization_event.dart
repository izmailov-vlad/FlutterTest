abstract class AuthorizationEvent {}

class AuthorizeEvent extends AuthorizationEvent {
  String login;
  String password;
  AuthorizeEvent({required this.login, required this.password});
}
