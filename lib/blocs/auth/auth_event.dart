import 'package:equatable/equatable.dart';
import 'package:nur_pay/data/models/user_model.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class SigningWithEmailEvent extends AuthEvent {
  final UserModel userModel;

  const SigningWithEmailEvent({
    required this.userModel,
  });

  @override
  List<Object?> get props => [
        userModel,
      ];
}
class SigningWithGoogleEvent extends AuthEvent {
  final UserModel userModel;

  const SigningWithGoogleEvent({
    required this.userModel,
  });

  @override
  List<Object?> get props => [
        userModel,
      ];
}
class LoginWithGoogleEvent extends AuthEvent {
  final UserModel userModel;

  const LoginWithGoogleEvent({
    required this.userModel,
  });

  @override
  List<Object?> get props => [
        userModel,
      ];
}
class LoginWithEmailEvent extends AuthEvent {
  final UserModel userModel;

  const LoginWithEmailEvent({
    required this.userModel,
  });

  @override
  List<Object?> get props => [
        userModel,
      ];
}
