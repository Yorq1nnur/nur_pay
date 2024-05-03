import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nur_pay/blocs/auth/auth_event.dart';
import 'package:nur_pay/blocs/auth/auth_state.dart';
import 'package:nur_pay/data/models/form_status.dart';
import 'package:nur_pay/data/models/network_response.dart';
import 'package:nur_pay/data/models/user_model.dart';
import 'package:nur_pay/data/repositories/auth_repo/auth_repo.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required this.authRepository})
      : super(
          AuthState(
            statusMessage: '',
            formStatus: FormStatus.pure,
            errorMessage: '',
            userModel: UserModel.initial(),
          ),
        ) {
    on<CheckAuthenticationEvent>(_checkAuthentication);
    on<LoginUserEvent>(_loginUser);
    on<RegisterUserEvent>(_registerUser);
    on<LogOutUserEvent>(_logOutUser);
    on<SignInWithGoogleUserEvent>(_googleSignIn);
  }

  final AuthRepository authRepository;

  _checkAuthentication(CheckAuthenticationEvent event, emit) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      emit(state.copyWith(formStatus: FormStatus.unauthenticated));
    } else {
      emit(state.copyWith(formStatus: FormStatus.authenticated));
    }
  }

  _loginUser(LoginUserEvent event, emit) async {
    emit(state.copyWith(formStatus: FormStatus.loading));

    NetworkResponse networkResponse =
        await authRepository.loginInWithEmailAndPassword(
      email: event.username,
      password: event.password,
    );

    if (networkResponse.errorText.isEmpty) {
      emit(state.copyWith(formStatus: FormStatus.authenticated));
    } else {
      emit(state.copyWith(
        formStatus: FormStatus.error,
        errorMessage: networkResponse.errorText,
      ));
    }
  }

  _registerUser(RegisterUserEvent event, emit) async {
    emit(state.copyWith(formStatus: FormStatus.loading));

    NetworkResponse networkResponse =
        await authRepository.registerInWithEmailAndPassword(
      email: "${event.userModel.username}@gmail.com",
      password: event.userModel.password,
    );

    if (networkResponse.errorText.isEmpty) {
      // UserCredential userCredential = networkResponse.data;
      emit(
        state.copyWith(
          formStatus: FormStatus.authenticated,
          statusMessage: "registered",
          userModel: event.userModel,
        ),
      );
    } else {
      emit(state.copyWith(
        formStatus: FormStatus.error,
        errorMessage: networkResponse.errorText,
      ));
    }
  }

  _logOutUser(LogOutUserEvent event, emit) async {
    emit(state.copyWith(formStatus: FormStatus.loading));

    NetworkResponse networkResponse = await authRepository.logOutUser();

    if (networkResponse.errorText.isEmpty) {
      emit(state.copyWith(formStatus: FormStatus.unauthenticated));
    } else {
      emit(state.copyWith(
        formStatus: FormStatus.error,
        errorMessage: networkResponse.errorText,
      ));
    }
  }

  _googleSignIn(SignInWithGoogleUserEvent event, emit) async {
    emit(state.copyWith(formStatus: FormStatus.loading));

    NetworkResponse networkResponse = await authRepository.googleSignIn();

    if (networkResponse.errorText.isEmpty) {
      UserCredential userCredential = networkResponse.data;

      emit(
        state.copyWith(
          formStatus: FormStatus.authenticated,
          userModel: UserModel(
            username: userCredential.user!.displayName ?? '',
            lastname: userCredential.user!.displayName ?? '',
            password: '',
            userId: '',
            imageUrl: userCredential.user!.photoURL ?? '',
            phoneNumber: userCredential.user!.phoneNumber ?? '',
            email: userCredential.user!.email ?? '',
            fcmToken: '',
            authUUId: userCredential.user!.uid,
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          formStatus: FormStatus.error,
          errorMessage: networkResponse.errorText,
        ),
      );
    }
  }
}
