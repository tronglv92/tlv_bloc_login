import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_serializers/service/api/auth_api.dart' show AuthApi;
import 'package:test_serializers/service/models/auth.dart';

class UserRepository {
  AuthApi authApi;
  Auth currentUser;
  static final UserRepository _instance = UserRepository._internal();

  factory UserRepository() => _instance;

  UserRepository._internal() {

    if (authApi == null) {
      print("auth API chua co ");
      authApi = new AuthApi();
    } else {
      print("auth API da co ");
    }
  }


  Future<Auth> getDetailUser({@required String userId}) async{
    return authApi.getUserById(id:userId);
  }


}
