import 'package:shared_preferences/shared_preferences.dart';

class ClientPreferences {
  Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();
  late SharedPreferences prefs;

  String _login = "";
  String _password = "";

  ClientPreferences() {
    _initPrefs();
  }

  String get login => _login;

  Future<void> _initPrefs() async {
    prefs = await _sharedPreferences;
  }

  checkUserActive() {
    if (prefs.getString("login") == "authorized") {
      print("client authorized");
      throw Exception("User is not authorized");
    }
  }

  authorizeClient(String login, String password) {
    if (prefs.getString(login) == null) throw Exception("User doesn't exist");
    if (prefs.getString(login) == password) {
      prefs.setString("login", "authorized");
      _login = login;
      _password = password;
    }
  }

  logoutClient() {
    _login = "";
    _password = "";
  }

  deleteUser() {
    prefs.setString(_login, "");
  }

  registerClient(String login, String password) {
    if (prefs.getString(login) != null) throw Exception("User already exist");
    prefs.setString(login, password);
  }
}
