import 'package:shared_preferences/shared_preferences.dart';

class ClientPreferences {
  Future<SharedPreferences> _sharedPreferences = SharedPreferences.getInstance();
  late SharedPreferences prefs;

  String _login = "";
  String _password = "";
  
  ClientPreferences() {
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    prefs = await _sharedPreferences;
  }

  checkUserActive() {
    if(_login.isNotEmpty && _password.isNotEmpty) throw Exception("Такого пользователя нет");
  }
  authorizeClient(String login, String password) {
    if(prefs.getString(login) == null && prefs.getString(password) == null) throw Exception("User doesn't exist");
    _login = login;
    _password = password;
  }

  logoutClient() {
    _login = "";
    _password = "";
  }

  deleteUser() {
    prefs.setString(_login, "");
    prefs.setString(_password, "");
  }

  bool registerClient(String login, String password) {
    if(prefs.getString(login) != null && prefs.getString(password) != null) return false;
      prefs.setString("login", login);
      prefs.setString("password", password);
      return true;
  }

}