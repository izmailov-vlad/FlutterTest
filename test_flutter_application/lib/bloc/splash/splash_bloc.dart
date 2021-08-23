import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_application/bloc/home/home_event.dart';
import 'package:test_flutter_application/bloc/splash/splash_event.dart';
import 'package:test_flutter_application/bloc/splash/splash_state.dart';
import 'package:test_flutter_application/models/client_preferences.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc(SplashState initialState) : super(initialState);
  final ClientPreferences _clientPreferences = ClientPreferences();

  @override
  Stream<SplashState> mapEventToState(SplashEvent event) async* {
    if (event is CheckUserEvent) {
      print("Check user event");
      try {
        _clientPreferences.checkUserActive();
        yield FoundUserState();
      } catch (exception) {
        print(exception.toString());
        yield NotFoundUserState();
      }
    }
  }
}
