import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_application/models/client_preferences.dart';
import 'authorization_state.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState> {
  final ClientPreferences _clientPreferences = ClientPreferences();

  ClientBloc() : super(ClientNotAuthorizedState());

  @override
  Stream<ClientState> mapEventToState(ClientEvent event) async* {
    if (event is ClientAuthorizeEvent) {
      yield ClientAuthorizingState();
      try {
        _clientPreferences.authorizeClient(event.login, event.password);
        yield ClientAuthorizedState();
      } catch (e) {
        print(e.toString());
        yield ClientErrorState();
      }
    } else if (event is ClientRegisterEvent) {
      yield ClientRegistratingState();
      try {
        _clientPreferences.registerClient(event.login, event.password);
        yield ClientRegisteredState();
      } catch (e) {
        print(e.toString());
        yield ClientErrorState();
      }
    } else if (event is ClientLogoutEvent) {}
  }
}
