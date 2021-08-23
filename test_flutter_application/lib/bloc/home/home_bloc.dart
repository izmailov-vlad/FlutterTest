import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_application/bloc/home/home_event.dart';
import 'package:test_flutter_application/bloc/home/home_state.dart';
import 'package:test_flutter_application/models/client_preferences.dart';
import 'package:test_flutter_application/models/user.dart';
import 'package:test_flutter_application/services/user_repository.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc(HomePageState initialState) : super(initialState);

  final _clientPreferences = ClientPreferences();
  final _userProvider = UserRepository();
  late List<User> users;

  bool _isSearching = false;

  @override
  Stream<HomePageState> mapEventToState(HomePageEvent event) async* {
    print("bloc");
    if (event is HomePageLogoutEvent) {
      print("logout");
      try {
        _clientPreferences.logoutClient();
        yield HomePageLogoutSuccessState();
      } catch (exception) {
        print(exception);
        yield HomePageErrorState();
      }
    } else if (event is HomePageRefreshEvent) {
      print("refresh");
      try {
        if(event.closeSearchingField) {
          yield HomePageRefreshedState(loadedUser: users, isSearching: false);
        }
        if (event.loadNewUsers) {
          users = await _userProvider.getAllUsers();
          yield HomePageRefreshedState(loadedUser: users, isSearching: false);
        }
        if (event.loadAndFindNewUser) {
          users = await _userProvider.getAllUsers();
          List<User> _searchList = [];
          for (int i = 0; i < users.length; i++) {
            String name = users.elementAt(i).name.first;
            if (name.toLowerCase().contains(event.text.toLowerCase())) {
              _searchList.add(users.elementAt(i));
            }
          }
          yield HomePageRefreshedState(loadedUser: _searchList, isSearching: true);
        }
        if(event.findUser) {
          List<User> _searchList = [];
          for (int i = 0; i < users.length; i++) {
            String name = users.elementAt(i).name.first;
            if (name.toLowerCase().contains(event.text.toLowerCase())) {
              _searchList.add(users.elementAt(i));
            }
          }
          yield HomePageRefreshedState(loadedUser: _searchList, isSearching: true);
        }
      } catch (exception) {
        print(exception);
        yield HomePageErrorState();
      }
    }
  }
}
