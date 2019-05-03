import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_serializers/service/api/auth_api.dart' show AuthApi;
import 'package:test_serializers/service/models/auth.dart';

class AuthRepository {
  AuthApi authApi;
  Auth currentUser;
  static final AuthRepository _instance = AuthRepository._internal();

  factory AuthRepository() => _instance;

  AuthRepository._internal() {
    print("vao roi ne ");
    if (authApi == null) {
      print("auth API chua co ");
      authApi = new AuthApi();
    } else {
      print("auth API da co ");
    }
  }

  Future<Auth> authenticate({
    @required String email,
    @required String password,
  }) async {
    Future<Auth> result = authApi.login(email: email, password: password);

    return result;
  }



  Future<void> deleteToken() async {
    /// delete from keystore/keychain
//    await Future.delayed(Duration(seconds: 1));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('currentUser');
    currentUser = null;
    return;
  }

  Future<void> persistToken(Auth auth) async {
    /// write to keystore/keychain
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String currentUserString = json.encode(auth.toJson());
    await prefs.setString('currentUser', currentUserString);
    currentUser = auth;
    return;
  }

  Future<Auth> getCurrentUser() async {
    /// read from keystore/keychain

    if (currentUser == null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String currentUserString = prefs.getString('currentUser');
      if (currentUserString != null) {
        Map<String, dynamic> currentUserMap = json.decode(currentUserString);
        Auth auth = Auth.fromJson(currentUserMap);
        if (auth != null) {
          currentUser = auth;
        }
      }
    }
    print(" get current user");
    return currentUser;
  }

//  bool testchovui(){
//    print(" test cho vui");
//    return true;
//}

  Future<bool> hasUser() async {
    if (currentUser != null) {
      return true;
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String currentUserString = prefs.getString('currentUser');
      if (currentUserString != null) {
        Map<String, dynamic> currentUserMap = json.decode(currentUserString);
        Auth auth = Auth.fromJson(currentUserMap);
        currentUser = auth;
        if (auth != null) {
          return true;
        }
      }
    }
    return false;
  }
}
