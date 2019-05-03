import 'package:test_serializers/service/core/models/base_error_response.dart';

import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
class BaseResponseMessage<T>{
  final List<BaseErrorResponse> errors;
  dynamic data;
  T Function(Object) fromJson;
//   dynamic data;
//  T dynamic Function(Object) fromJson;

  BaseResponseMessage({this.data,this.errors,this.fromJson}) {
    castDataToList(data);
  }

  factory BaseResponseMessage.fromJson(Map<String, dynamic> parsedJson,T fromJson(Object o))
  {
    var listErrors=parsedJson['errors'] as List;
    List<BaseErrorResponse> errors=null;
    if(listErrors!=null)
      {
         errors=listErrors.map((i)=>BaseErrorResponse.fromJson(i)).toList();
      }


    return new BaseResponseMessage(
      errors: errors,
      data:parsedJson['data'],
      fromJson: fromJson,

    );
  }

  void castDataToList(jsonData) {

    if(jsonData!=null)
      {
        this.data = fromJson(jsonData);
      }

  }

}