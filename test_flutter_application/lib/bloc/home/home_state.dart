import 'package:test_flutter_application/models/user.dart';
import 'package:test_flutter_application/view/home_page.dart';

abstract class HomePageState {}

class HomePageRefreshingState extends HomePageState {}

class HomePageRefreshedState extends HomePageState {
  bool isSearching;
  List<User> loadedUser;
  HomePageRefreshedState({required this.loadedUser, required this.isSearching});
}

class HomePageSearchingButtonPressedState extends HomePageState {}

class HomePageLogoutingState extends HomePageState {}

class HomePageLogoutSuccessState extends HomePageState {}

class HomePageErrorState extends HomePageState {}
