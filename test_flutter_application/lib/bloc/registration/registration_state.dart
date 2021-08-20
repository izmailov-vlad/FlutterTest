import 'package:test_flutter_application/models/user.dart';

abstract class RegistrationState {}

class RegistrationErrorState extends RegistrationState {}

class RegistrationSuccessState extends RegistrationState {}

class RegistrationLoadingState extends RegistrationState {}


// List<User> loadedUser;
//   UserLoadedState({required this.loadedUser});