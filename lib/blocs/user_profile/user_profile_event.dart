import 'package:equatable/equatable.dart';
import 'package:nur_pay/data/models/user_model.dart';

abstract class UserProfileEvent extends Equatable {}

class AddUserEvent extends UserProfileEvent {
  final UserModel userModel;

  AddUserEvent({
    required this.userModel,
  });

  @override
  List<Object?> get props => [
        userModel,
      ];
}

class UpdateUserEvent extends UserProfileEvent {
  final UserModel userModel;

  UpdateUserEvent({
    required this.userModel,
  });

  @override
  List<Object?> get props => [
        userModel,
      ];
}

class DeleteUserEvent extends UserProfileEvent {
  final UserModel userModel;

  DeleteUserEvent({
    required this.userModel,
  });

  @override
  List<Object?> get props => [
        userModel,
      ];
}

class GetUserEvent extends UserProfileEvent {
  @override
  List<Object?> get props => [];
}
