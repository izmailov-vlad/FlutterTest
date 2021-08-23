import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_application/bloc/home/home_event.dart';
import 'package:test_flutter_application/bloc/home/home_state.dart';
import 'package:test_flutter_application/models/client_preferences.dart';
import 'package:test_flutter_application/models/user.dart';
import 'package:test_flutter_application/services/user_api_provider.dart';
import 'package:test_flutter_application/services/user_repository.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc(HomePageState initialState) : super(initialState);

  final _clientPreferences = ClientPreferences();
  final _userProvider = UserRepository();

  @override
  Stream<HomePageState> mapEventToState(HomePageEvent event) async* {
    print("bloc");
    if (event is HomePageLogoutEvent) {
      print("logout");
      try {
        _clientPreferences.logoutClient();
      } catch (exception) {
        print(exception);
        yield HomePageErrorState();
      }
    } else if (event is HomePageRefreshEvent) {
      print("refresh");
      try {
        List<User> users = await _userProvider.getAllUsers();
        yield HomePageRefreshedState(loadedUser: users);
      } catch (exception) {
        print(exception);
        yield HomePageErrorState();
      }
    }
    // if (event is HomePageStartSearchEvent) {
    //   yield StartSearchingState();
    // }
  }
}
