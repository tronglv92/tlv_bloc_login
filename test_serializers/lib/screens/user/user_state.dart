import 'package:equatable/equatable.dart';
import 'package:test_serializers/service/models/auth.dart';
import 'package:meta/meta.dart';
abstract class UserState extends Equatable {}
class UserInit extends UserState {
}

class GetUserLoading extends UserState {

}

class GetUserSuccess extends UserState {
  Auth user;
  GetUserSuccess({@required this.user});

}

class GetUserError extends UserState {

}

