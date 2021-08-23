import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter_application/bloc/authorization/authorization_bloc.dart';
import 'package:test_flutter_application/bloc/splash/splash_bloc.dart';
import 'package:test_flutter_application/bloc/splash/splash_event.dart';
import 'package:test_flutter_application/bloc/splash/splash_state.dart';
import 'package:test_flutter_application/view/authorization_page.dart';
import 'package:test_flutter_application/view/home_page.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    void _navigateToAuthorizationPage() {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => BlocProvider<AuthorizationBloc>(
                  create: (context) => AuthorizationBloc(),
                  child: AuthorizationPage())));
    }

    void _navigateToHomePage() {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }

    return BlocProvider<SplashBloc>(
        create: (context) => SplashBloc(CheckingUserState()),
        child: BlocConsumer<SplashBloc, SplashState>(
          listener: (context, state) {
            if (state is NotFoundUserState) {
              _navigateToAuthorizationPage();
            }

            if (state is FoundUserState) {
              print("user found");
              _navigateToHomePage();
            }
          },
          builder: (context, state) {
            if (state is CheckingUserState) {
              Provider.of<SplashBloc>(context).add(CheckUserEvent());
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
