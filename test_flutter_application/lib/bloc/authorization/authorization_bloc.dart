import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_application/bloc/authorization/auhtorization_event.dart';
import 'package:test_flutter_application/models/client_preferences.dart';
import 'authorization_state.dart';

class AuthorizationBloc extends Bloc<AuthorizationEvent, AuthorizationState> {
  final ClientPreferences _clientPreferences = ClientPreferences();

  AuthorizationBloc() : super(NotAuthorizedState());

  @override
  Stream<AuthorizationState> mapEventToState(AuthorizationEvent event) async* {
    if (event is AuthorizeEvent) {
      yield AuthorizingState();
      try {
        _clientPreferences.authorizeClient(event.login, event.password);
        yield AuthorizedState();
      } catch (e) {
        print(e.toString());
        yield AuthorizationErrorState();
      }
    }
  }
}
