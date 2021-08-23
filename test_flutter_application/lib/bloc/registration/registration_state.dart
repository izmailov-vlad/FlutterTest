abstract class RegistrationState {}

class RegistrationErrorState extends RegistrationState {}

class RegistrationWaitingState extends RegistrationState {}

class RegistrationSuccessState extends RegistrationState {}

class RegistrationLoadingState extends RegistrationState {}


// List<User> loadedUser;
//   UserLoadedState({required this.loadedUser});