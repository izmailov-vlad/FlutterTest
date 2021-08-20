import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter_application/models/user.dart';

class UserInfo extends StatefulWidget {
  final Name name;
  final Location location;
  final Picture picture;

  UserInfo(this.name, this.location, this.picture);

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(widget.picture.large),
              Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
              Text(
                widget.name.first + widget.name.last,
                textAlign: TextAlign.center,
                textScaleFactor: 2,
              ),
              Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10)),
              Text(
                widget.location.city,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ));
  }
}
