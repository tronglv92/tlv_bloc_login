import 'package:test_serializers/service/core/models/base_response_message.dart';

class ApiWrapper<T>{
  T apiWragger(response, fromJson) {
    BaseResponseMessage result =
        BaseResponseMessage<T>.fromJson(response, fromJson);
    if (result.data != null) {
    return result.data;
    } else {
    throw result.errors;
    }
  }
}