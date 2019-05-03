class Auth{
  final int id;
  final String email;
  final String token;
  Auth({this.id,this.email,this.token});
  factory Auth.fromJson(Map<String, dynamic> parsedJson){
    return new Auth(
        id:parsedJson['id'],
        email:parsedJson['email'],
      token: parsedJson['token']
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'email': email,
        'token':token
      };

}