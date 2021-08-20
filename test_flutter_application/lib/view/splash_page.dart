import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_application/bloc/splash/splash_bloc.dart';
import 'package:test_flutter_application/bloc/splash/splash_state.dart';
import 'package:test_flutter_application/view/authorization_page.dart';
import 'package:test_flutter_application/view/home_page.dart';

class SplashPage extends StatelessWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashBloc>(
        create: (context) => SplashBloc(CheckingUserState()),
        child: BlocBuilder<SplashBloc, SplashState>(builder: (context, state) {
          if (state == FoundUserState()) {
            return HomePage();
          }
          if(state == NotFoundUserState()) {
            return AuthorizationPage();
          }
          return CircularProgressIndicator();
        }));
  }
}
