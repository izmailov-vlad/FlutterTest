import 'package:shared_preferences/shared_preferences.dart';

class ClientPreferences {
  Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();
  late SharedPreferences prefs;

  static String login = "";

  // ClientPreferences() {
  //   _initPrefs();
  // }

  // Future<void> _initPrefs() async {
  //   prefs = await _sharedPreferences;
  // }

  Future checkUserActive() async {
    prefs = await _sharedPreferences;
    if(prefs.getString("login") != "authorized") throw Exception("User is not authorized");
  }

  authorizeClient(String _login, String password) async{
    prefs = await _sharedPreferences;
    if (prefs.getString(_login) == null) throw Exception("User doesn't exist");
    if (prefs.getString(_login) == password) {
      prefs.setString("login", "authorized");
      login = _login;
    }
  }

  logoutClient() async {
    prefs = await _sharedPreferences;
    prefs.setString("login", "unauthorized");
    login = "";
  }

  deleteUser() async{
    prefs = await _sharedPreferences;
    prefs.setString(login, "");
  }

  registerClient(String login, String password) async {
    prefs = await _sharedPreferences;
    if (prefs.getString(login) != null) throw Exception("User already exist");
    prefs.setString(login, password);
  }
}
