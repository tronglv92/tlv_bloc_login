import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:test_serializers/service/models/auth.dart';

abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent([List props = const []]) : super(props);
}

class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';
}

class LoggedIn extends AuthenticationEvent {
  final Auth auth;

  LoggedIn({@required this.auth}) : super([auth.token]);

  @override
  String toString() => 'LoggedIn { token: ${auth.token} }';
}

class LoggedOut extends AuthenticationEvent {
  @override
  String toString() => 'LoggedOut';
}