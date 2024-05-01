import 'package:equatable/equatable.dart';

sealed class AuthState extends Equatable {
  const AuthState();
}

final class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

final class AuthLoadingState extends AuthState {
  final bool isLoading;

  const AuthLoadingState({
    required this.isLoading,
  });

  @override
  List<Object> get props => [
        isLoading,
      ];
}

final class AuthSuccessState extends AuthState {
  @override
  List<Object> get props => [];
}

final class AuthErrorState extends AuthState {
  final String errorText;

  const AuthErrorState({this.errorText = ''});

  @override
  List<Object> get props => [
        errorText,
      ];
}
