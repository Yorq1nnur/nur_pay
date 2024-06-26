import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nur_pay/blocs/auth/auth_event.dart';
import 'package:nur_pay/blocs/auth/auth_state.dart';
import 'package:nur_pay/data/models/form_status.dart';
import 'package:nur_pay/data/models/network_response.dart';
import 'package:nur_pay/data/models/user_model.dart';
import 'package:nur_pay/data/repositories/auth_repo/auth_repo.dart';
import 'package:nur_pay/data/repositories/user_profile_repo/user_profile_repo.dart';
import 'package:nur_pay/utils/utility_functions/utility_functions.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required this.authRepository, required this.userProfileRepo})
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
  final UserProfileRepo userProfileRepo;

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
      email: "${event.username}@gmail.com",
      password: event.password,
    );

    if (networkResponse.errorText.isEmpty) {
      emit(
        state.copyWith(
          formStatus: FormStatus.authenticated,
        ),
      );
      UserModel userModel = UserModel(
        username: event.username,
        lastname: event.username,
        password: event.password,
        userId: '',
        imageUrl: FirebaseAuth.instance.currentUser!.photoURL!,
        phoneNumber: FirebaseAuth.instance.currentUser!.phoneNumber!,
        email: FirebaseAuth.instance.currentUser!.email!,
        fcmToken: '',
        authUUId: FirebaseAuth.instance.currentUser!.uid,

        ///TODO authUUId yangilanmayabdi!!!
      );
      await userProfileRepo.updateUser(
        userModel,
      );
    } else {
      emit(state.copyWith(
        formStatus: FormStatus.error,
        errorMessage: networkResponse.errorText,
      ));
    }
  }

  _registerUser(RegisterUserEvent event, emit) async {
    emit(
      state.copyWith(
        formStatus: FormStatus.loading,
      ),
    );

    NetworkResponse networkResponse =
        await authRepository.registerInWithEmailAndPassword(
      email: "${event.userModel.username}@gmail.com",
      password: event.userModel.password,
    );

    if (networkResponse.errorText.isEmpty) {
      UserCredential userCredential = networkResponse.data as UserCredential;
      UserModel userModel = event.userModel.copyWith(
        authUUId: userCredential.user!.uid,
      );
      emit(
        state.copyWith(
          formStatus: FormStatus.authenticated,
          statusMessage: "registered",
          userModel: userModel,
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

      UserModel userModel = state.userModel.copyWith(
        username: userCredential.user!.displayName,
        lastname: userCredential.user!.displayName,
        password: 'Password',
        userId: '',
        imageUrl: userCredential.user!.photoURL,
        phoneNumber: userCredential.user!.email,
        email: userCredential.user!.email,
        fcmToken: '',
        authUUId: userCredential.user!.uid,
      );
      methodPrint(
        'CURRENT EMAIL: ${userCredential.user!.email}',
      );

      await userProfileRepo.insertUser(userModel).whenComplete(
        () {
          emit(
            state.copyWith(
              formStatus: FormStatus.authenticated,
              userModel: userModel,
            ),
          );
        },
      );

      methodPrint(
        "\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$GOOGLE SIGN IN RETURNED USER MODEL: EMAIL: ${state.userModel.email}, USERNAME: ${state.userModel.username}, LASTNAME: ${state.userModel.lastname}, AUTH ID: ${state.userModel.authUUId},",
      );
    } else {
      methodPrint(
          "\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\n\\ERROR: ${networkResponse.errorText}\n\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$");
      emit(
        state.copyWith(
          formStatus: FormStatus.error,
          errorMessage: networkResponse.errorText,
        ),
      );
    }
    methodPrint(
        "\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\n\\GOOGLE SIGNING STATE: ${state.formStatus}\n\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$");
  }
}
