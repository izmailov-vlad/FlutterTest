abstract class SplashEvent {}

class CheckUserEvent extends SplashEvent {
  String login;
  String password;
  CheckUserEvent({required this.login, required this.password});
}
