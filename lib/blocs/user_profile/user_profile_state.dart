import 'package:equatable/equatable.dart';

abstract class UserProfileState extends Equatable {
  const UserProfileState();
}

class Initial extends UserProfileState {
  @override
  List<Object> get props => [];
}
