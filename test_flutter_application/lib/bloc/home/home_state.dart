import 'package:test_flutter_application/models/user.dart';

abstract class HomePageState {}

class HomePageRefreshingState extends HomePageState {}

class HomePageRefreshedState extends HomePageState {
  List<User> loadedUser;
  HomePageRefreshedState({required this.loadedUser});
}

class HomePageLogoutingState extends HomePageState {}

class HomePageLogoutedState extends HomePageState {}

class HomePageErrorState extends HomePageState {}
