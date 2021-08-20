import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_flutter_application/bloc/client/authorization_bloc.dart';
import 'package:test_flutter_application/bloc/user/registration_bloc.dart';
import 'package:test_flutter_application/bloc/user/registration_state.dart';
import 'package:test_flutter_application/models/client_preferences.dart';
import 'package:test_flutter_application/services/user_repository.dart';
import 'package:test_flutter_application/view/authorization_page.dart';
import 'package:test_flutter_application/widgets/user_list.dart';

class HomePage extends StatelessWidget {
  final userRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    ClientPreferences _clientPreferences = ClientPreferences();
  
        return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  _clientPreferences.logoutClient();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => BlocProvider<ClientBloc>(
                            create: (context) => ClientBloc(),
                            child: AuthorizationPage(),
                          )));
                },
                icon: Icon(Icons.logout))
          ],
          title: Text("Users List"),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[Expanded(child: UserList())],
        ));
  }
}
