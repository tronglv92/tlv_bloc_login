import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:test_serializers/screens/user/user_event.dart';
import 'package:test_serializers/screens/user/user_state.dart';
import 'package:test_serializers/service/repository/user_repository.dart';
import 'package:test_serializers/service/models/auth.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserRepository userRepository;

  UserBloc() {
//    print("da vao noi nay");
    userRepository = UserRepository();
  }

  @override
  UserState get initialState => UserInit();

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is GetDetailUser) {
      yield GetUserLoading();
      try {
        Auth auth= await userRepository.getDetailUser(userId: event.userId);
        yield GetUserSuccess(user: auth);
      } catch (error) {
        yield GetUserError();
      }
    }
  }
}
