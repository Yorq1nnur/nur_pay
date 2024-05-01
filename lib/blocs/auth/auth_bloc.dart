import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nur_pay/blocs/auth/auth_event.dart';
import 'package:nur_pay/blocs/auth/auth_state.dart';
import 'package:nur_pay/utils/constants/app_constants.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc()
      : super(
          AuthInitial(),
        ) {
    on<SigningWithEmailEvent>(_registerWithEmail);
  }

  _registerWithEmail(
      SigningWithEmailEvent event, Emitter<AuthState> emit) async {
    emit(
      const AuthLoadingState(
        isLoading: true,
      ),
    );

    if (AppConstants.emailRegExp.hasMatch(event.userModel.email) &&
        AppConstants.passwordRegExp.hasMatch(event.userModel.password)) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: event.userModel.email,
          password: event.userModel.password,
        );
        if (userCredential.user != null) {
          await FirebaseAuth.instance.currentUser!
              .updateDisplayName(event.userModel.userName);
        }
      } on FirebaseAuthException catch (e) {
        emit(AuthErrorState(errorText: e.toString()));
      } catch (error) {
        emit(
          AuthErrorState(
            errorText: error.toString(),
          ),
        );
      }
    }
  }
}
