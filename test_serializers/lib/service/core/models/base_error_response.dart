class BaseErrorResponse {
  final int errorCode;
  final String errorMessage;



  BaseErrorResponse({this.errorCode,this.errorMessage});

  factory BaseErrorResponse.fromJson(Map<String, dynamic> parsedJson) {

    return new BaseErrorResponse(
      errorCode: parsedJson['errorCode'],

      errorMessage: parsedJson['errorMessage'],
    );
  }
}
