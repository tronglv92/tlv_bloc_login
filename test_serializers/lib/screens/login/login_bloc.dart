import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:test_serializers/service/repository/auth_repository.dart';

import 'package:test_serializers/screens/authentication/authentication.dart';
import 'package:test_serializers/screens/login/login.dart';
import 'package:test_serializers/service/models/auth.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
   AuthRepository authRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({

    @required this.authenticationBloc,
  })  :
        assert(authenticationBloc != null){
    authRepository=new AuthRepository();
  }

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        Auth auth = await authRepository.authenticate(
          email: event.email,
          password: event.password,
        );

        authenticationBloc.dispatch(LoggedIn(auth: auth));
        yield LoginInitial();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
