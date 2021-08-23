import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_flutter_application/bloc/authorization/auhtorization_event.dart';
import 'package:test_flutter_application/bloc/authorization/authorization_bloc.dart';
import 'package:test_flutter_application/bloc/authorization/authorization_state.dart';
import 'package:test_flutter_application/bloc/registration/registration_bloc.dart';
import 'package:test_flutter_application/view/home_page.dart';
import 'package:test_flutter_application/view/registration_page.dart';
// import 'package:toast/toast.dart';

class AuthorizationPage extends StatelessWidget {
  AuthorizationPage({Key? key}) : super(key: key);
  Duration get loginTime => Duration(milliseconds: 2250);

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final AuthorizationBloc _authorizationBloc =
        context.read<AuthorizationBloc>();

    final _sizeTextBlack = const TextStyle(fontSize: 20.0, color: Colors.black);
    final _sizeTextWhite = const TextStyle(fontSize: 20.0, color: Colors.white);

    late String _login;
    late String _password;

    void _onRegisterPressed(context) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => BlocProvider<RegistrationBloc>(
                create: (context) => RegistrationBloc(),
                child: RegistrationWidget(),
              )));
    }

    Widget _button(String text, void func()) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          textStyle: TextStyle(fontSize: 20),
        ),
        onPressed: () {
          func();
        },
        child: Text(text),
      );
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

    void _onLoginPressed() async {
      _login = _emailController.text;
      _password = _passwordController.text;

      if (_login.isEmpty || _password.isEmpty) return;
      _authorizationBloc
          .add(AuthorizeEvent(login: _login, password: _password));
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
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: _button(label, onLoginPressed),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Container(
            child: TextButton(
              child: Text(
                'Not registered? Register!',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                _onRegisterPressed(context);
              },
            ),
          ),
        )
      ]));
    }

    return BlocListener<AuthorizationBloc, AuthorizationState>(
        listener: _onStateChanged,
        child: Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            body: new Column(
              children: <Widget>[
                _logo(),
                Expanded(child: _form("LOGIN", _onLoginPressed))
              ],
            )));
  }

  void _onStateChanged(BuildContext context, AuthorizationState state) {
    if (state is AuthorizationErrorState) {
      Fluttertoast.showToast(
          msg: "Error! Try Again",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    if (state is AuthorizedState) {
      print("authorize success");

      _emailController.clear();
      _passwordController.clear();

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }
}
