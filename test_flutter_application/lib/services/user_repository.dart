import 'package:test_flutter_application/models/user.dart';
import 'package:test_flutter_application/services/user_api_provider.dart';

class UserRepository {
  UserProvider _usersProvider = UserProvider();
  Future<List<User>> getAllUsers() => _usersProvider.getUsers();
}
