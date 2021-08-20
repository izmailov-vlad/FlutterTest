import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_application/bloc/user/registration_event.dart';
import 'package:test_flutter_application/bloc/user/registration_state.dart';
import 'package:test_flutter_application/models/user.dart';
import 'package:test_flutter_application/services/user_repository.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc(this.userRepository) : super(UserEmptyState());

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is UserLoadEvent) {
      yield UserLoadingState();
      try {
        final List<User> _loadedUserList = await userRepository.getAllUsers();
        yield UserLoadedState(loadedUser: _loadedUserList);
      } catch (e) {
        print(e.toString());
        yield UserErrorState();
      }
    } else if (event is UserClearEvent) {
      yield UserEmptyState();
    }
  }
}
