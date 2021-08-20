import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_application/bloc/user/registration_bloc.dart';
import 'package:test_flutter_application/bloc/user/registration_event.dart';

class ActionButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserBloc userBloc = BlocProvider.of<UserBloc>(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        TextButton(
            onPressed: () {
              userBloc.add(UserLoadEvent());
            },
            child: Text("Load"),
            style: TextButton.styleFrom(
                primary: Colors.black, backgroundColor: Colors.green)),
        SizedBox(
          width: 8.0,
        ),
        TextButton(
            onPressed: () {
              userBloc.add(UserClearEvent());
            },
            child: Text("Clear"),
            style: TextButton.styleFrom(
                primary: Colors.black, backgroundColor: Colors.red)),
      ],
    );
  }
}
