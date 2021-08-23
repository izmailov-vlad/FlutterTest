import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter_application/bloc/authorization/authorization_bloc.dart';
import 'package:test_flutter_application/bloc/registration/registration_bloc.dart';
import 'package:test_flutter_application/bloc/registration/registration_event.dart';
import 'package:test_flutter_application/bloc/registration/registration_state.dart';
import 'package:test_flutter_application/view/authorization_page.dart';

class RegistrationWidget extends StatefulWidget {
  RegistrationWidget({Key? key}) : super(key: key);

  @override
  _RegistrationWidgetState createState() => _RegistrationWidgetState();
}

class _RegistrationWidgetState extends State<RegistrationWidget> {
  final _sizeTextBlack = const TextStyle(fontSize: 20.0, color: Colors.black);
  final _sizeTextWhite = const TextStyle(fontSize: 20.0, color: Colors.white);

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordConfirmationController =
      TextEditingController();

  late String _login;
  late String _password;
  late String _passwordConfiramtion;

  @override
  Widget build(BuildContext context) {
    final _registrationBloc = Provider.of<RegistrationBloc>(context);

    Widget _passwordMismatch() {
      return Container(
        alignment: Alignment.bottomCenter,
        child: Row(children: <Widget>[
          Text(
            "Пароли не совпадают",
            style: TextStyle(color: Colors.red),
          )
        ]),
      );
    }

    void _onRegisterPressed() {
      _login = _emailController.text;
      _password = _passwordController.text;
      _passwordConfiramtion = _passwordConfirmationController.text;

      if (_passwordConfiramtion != _password) _passwordMismatch();

      if (_login.isNotEmpty &&
          _password.isNotEmpty &&
          _passwordConfiramtion.isNotEmpty) {
        _registrationBloc.add(RegisterEvent(_login, _password));
      }

      _emailController.clear();
      _passwordController.clear();
    }

    void _onAuthorizationPressed() {
      Navigator.pop(context);
    }

    Widget _input(Icon icon, String hint, TextEditingController controller,
        bool obsecure) {
      return Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: new TextFormField(
          controller: controller,
          obscureText: obsecure,
          keyboardType: TextInputType.emailAddress,
          style: _sizeTextWhite,
          decoration: InputDecoration(
            hintStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white30),
            hintText: hint,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white54, width: 1)),
            prefixIcon: Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: IconTheme(
                  data: IconThemeData(color: Colors.white),
                  child: icon,
                )),
          ),
        ),
        width: 400.0,
      );
    }

    Widget _button(String text, void func()) {
      return TextButton(
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white), textStyle: MaterialStateProperty.all(TextStyle(fontSize: 15))),
        onPressed: () {
          func();
        },
        child: Text(text),
      );
    }

    Widget _form(String label, void onLoginPressed()) {
      return Container(
          child: Column(children: [
        Padding(
            padding: EdgeInsets.only(bottom: 20, top: 10),
            child: _input(Icon(Icons.email), "EMAIL", _emailController, false)),
        Padding(
            padding: EdgeInsets.only(bottom: 20, top: 10),
            child: _input(
                Icon(Icons.lock), "PASSWORD", _passwordController, true)),
        Padding(
            padding: EdgeInsets.only(bottom: 20, top: 10),
            child: _input(Icon(Icons.confirmation_num), "CONFIRM PASSWORD",
                _passwordConfirmationController, true)),
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: _button(label, onLoginPressed),
          ),
        ),
      ]));
    }

    Widget _logo() {
      return Padding(
        padding: EdgeInsets.only(top: 100),
        child: Container(
          child: Align(
            child: Text('Test App',
                style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ),
        ),
      );
    }

    return BlocListener<RegistrationBloc, RegistrationState>(
        listener: _onStateChanged,
        child: Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            body: new Column(
              children: <Widget>[
                _logo(),
                _form("REGISTER", _onRegisterPressed),
                TextButton(
                    onPressed: () {
                      _onAuthorizationPressed();
                    },
                    child: Text(
                      "Authorize",
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            )));
  }

  void _onStateChanged(BuildContext context, RegistrationState state) {
    if (state is RegistrationSuccessState) {
      Navigator.pop(context);
    }
    if (state is RegistrationErrorState) {
      Fluttertoast.showToast(
          msg: "Error! Try Again",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
