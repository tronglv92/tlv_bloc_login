import 'dart:async';

import "package:dio/dio.dart";

import 'package:test_serializers/event_bus/event_bus.dart';

class NetworkUtils {
  static final NetworkUtils _instance = NetworkUtils._internal();
  Dio _client;

  factory NetworkUtils() => _instance;

  NetworkUtils._internal() {
    if (null == _client) {

      BaseOptions options = new BaseOptions();
      options.baseUrl = "http://axcro.api.web.beesightsoft.com/api";
      options.receiveTimeout = 1000 * 10;
      options.connectTimeout = 5000;
      _client = new Dio(options);
      _setupInterceptor();

    }
  }

  void _setupInterceptor() {
    int maxCharactersPerLine = 200;
    _client.interceptors.add(InterceptorsWrapper(
        onRequest:(RequestOptions options){
          print("--> ${options.method} ${options.path}");
          print("Content type: ${options.contentType}");
          print("<-- END HTTP");
          // Do something before request is sent
          return options; //continue
          // If you want to resolve the request with some custom data，
          // you can return a `Response` object or return `dio.resolve(data)`.
          // If you want to reject the request with a error message,
          // you can return a `DioError` object or return `dio.reject(errMsg)`
        },
        onResponse:(Response response) {
          print(
              "<-- ${response.statusCode} ${response.request.method} ${response.request.path}");
          String responseAsString = response.data.toString();
          if (responseAsString.length > maxCharactersPerLine) {
            int iterations =
            (responseAsString.length / maxCharactersPerLine).floor();
            for (int i = 0; i <= iterations; i++) {
              int endingIndex = i * maxCharactersPerLine + maxCharactersPerLine;
              if (endingIndex > responseAsString.length) {
                endingIndex = responseAsString.length;
              }
              print(responseAsString.substring(
                  i * maxCharactersPerLine, endingIndex));
            }
          } else {
            print(response.data);
          }
          print("<-- END HTTP");
          // Do something with response data
          return response; // continue
        },
        onError: (DioError e) {
          print(e);
          if(e.response.statusCode==401){

            eventBus.fire(UnAuthErrorEvent());
          }
          // Do something with response error
          return  e;//continue
        }
    ));

  }

  Future<Map<String, dynamic>> request(String path, String method,
      {Map<String, dynamic> queryParameters, dynamic data,String token}) async {
    try {
      Response<Map<String, dynamic>> response;
      if(token!=null)
        {
          _client.options.headers={"USER-TOKEN":token};
        }

      response = await _client.request(path,
          queryParameters: queryParameters,
          options: Options(method: method),
          data: data);
      return response.data;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      if (error.response != null && error.response.data != null) {
        var response = error.response;
        return response.data;
      } else
        return error;
    }
  }

//   Future<Auth> apiWragger(response, fromJson) {
//    BaseResponseMessage result =
//        BaseResponseMessage<Auth>.fromJson(response, fromJson);
//    if (result.data != null) {
//      return result.data;
//    } else {
//      throw result.errors;
//    }
//  }
}
