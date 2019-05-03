import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_serializers/screens/user/user_bloc.dart';
import 'package:test_serializers/service/repository/auth_repository.dart';
import 'package:test_serializers/screens/authentication/authentication.dart';
import 'package:test_serializers/screens/splash/splash.dart';
import 'package:test_serializers/screens/home/home.dart';
import 'package:test_serializers/screens/login/login.dart';
import 'package:test_serializers/screens/common/loading_indicator.dart';
import 'package:test_serializers/event_bus/event_bus.dart';


class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Transition transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    super.onError(error, stacktrace);
    print(error);
  }
}

void main() {
  BlocSupervisor().delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {


  MyApp({Key key, }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }

}
class _MyAppState extends State<MyApp> {
  AuthenticationBloc _authenticationBloc;
  AuthRepository userRepository;

  @override
  void initState() {

    _authenticationBloc = AuthenticationBloc();
    _authenticationBloc.dispatch(AppStarted());
    userRepository=new AuthRepository();

    eventBus.on<UnAuthErrorEvent>().listen((event) {
      // All events are of type UserLoggedInEvent (or subtypes of it).
      print(" loi un authentoken");
      _authenticationBloc.dispatch(LoggedOut());

    });
    super.initState();
  }

  @override
  void dispose() {
    _authenticationBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProviderTree(
      blocProviders: [
        BlocProvider<AuthenticationBloc>(bloc: _authenticationBloc,),
        BlocProvider<UserBloc>(bloc: UserBloc(),)
      ],
      child: MaterialApp(
        home: Container(
          color: Colors.white,
          child: BlocBuilder<AuthenticationEvent, AuthenticationState>(
            bloc: _authenticationBloc,
            builder: (BuildContext context, AuthenticationState state) {
//              var currentUser=userRepository.getCurrentUser();
              if (state is AuthenticationUninitialized) {
                return SplashPage();
              }
              if (state is AuthenticationAuthenticated) {
                return HomePage();
              }
              if (state is AuthenticationUnauthenticated) {
                return LoginPage();
              }
              if (state is AuthenticationLoading) {
                return LoadingIndicator();
              }

            },
          ),
        ),
      ),
    );
  }
}

