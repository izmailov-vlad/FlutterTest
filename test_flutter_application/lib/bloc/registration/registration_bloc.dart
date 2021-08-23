import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_application/bloc/registration/registration_event.dart';
import 'package:test_flutter_application/bloc/registration/registration_state.dart';
import 'package:test_flutter_application/models/client_preferences.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final _userRepository = ClientPreferences();

  RegistrationBloc() : super(RegistrationWaitingState());

  @override
  Stream<RegistrationState> mapEventToState(RegistrationEvent event) async* {
    if (event is RegisterEvent) {
      yield RegistrationLoadingState();
      try {
        _userRepository.registerClient(event.login, event.password);
        yield RegistrationSuccessState();
      } catch (e) {
        print(e.toString());
        yield RegistrationErrorState();
      }
    }
  }
}
