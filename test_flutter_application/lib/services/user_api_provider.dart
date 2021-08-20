import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_flutter_application/models/user.dart';

class UserProvider {
  final url = Uri.parse('https://randomuser.me/api/?results=20');
  Future<List<User>> getUsers() async {
    final response = await http.get(url);
    print(response.body);
    if (response.statusCode == 200) {
      var userJson = jsonDecode(response.body)['results'] as List;
      List<User> userObj = userJson.map((json) => User.fromJson(json)).toList();
      return userObj;
    } else {
      throw Exception('Error fetching users');
    }
  }
}
