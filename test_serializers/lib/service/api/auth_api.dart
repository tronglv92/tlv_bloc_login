import 'dart:io' show Platform;

import 'package:meta/meta.dart';
import 'package:test_serializers/service/repository/auth_repository.dart';
import 'package:test_serializers/service/core/network/api_wrapper.dart';
import 'package:test_serializers/service/core/network/network_utils.dart';
import 'package:test_serializers/service/models/auth.dart';

class AuthApi {
  Auth authFromJson(Object o) {
    Auth auth = Auth.fromJson(o);
    return auth;
  }

  Future<Auth> login(
      {@required String email, @required String password}) async {
    String url = "/auth/signIn";
    String platform = "android";
    if (Platform.isIOS) {
      // Android-specific code
      platform = "ios";
    }
    var data = {
      "email": email,
      "password": password,
      "device_platform": platform,
      "device_token":
          "a437dd18254449779569cc1322a87791a426ad0c3e33aaf92379fac65d89758e"
    };
    Map<String, dynamic> response =
        await NetworkUtils().request(url, "POST", data: data);
    ApiWrapper apiWrapper = new ApiWrapper<Auth>();
    return apiWrapper.apiWragger(response, authFromJson);
  }

  Future<Auth> getUserById({@required String id}) async {
    AuthRepository authRepository = new AuthRepository();
    Auth currentUser = await authRepository.getCurrentUser();
    String token = "";
    if (currentUser != null) token = currentUser.token;
    String url = "/users/users/$id";
    Map<String, dynamic> response =
        await NetworkUtils().request(url, "GET", token: token);
    ApiWrapper apiWrapper = new ApiWrapper<Auth>();
    return apiWrapper.apiWragger(response, authFromJson);
  }
}
