import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:test_serializers/service/models/auth.dart';

abstract class UserEvent extends Equatable {
  UserEvent([List props = const []]) : super(props);
}

//class AppStarted extends UserEvent {
//  @override
//  String toString() => 'AppStarted';
//}

class GetDetailUser extends UserEvent {
  final String userId;

  GetDetailUser({@required this.userId}) : super([userId]);

  @override
  String toString() => 'GetDetailUser { userId: ${userId} }';
}

