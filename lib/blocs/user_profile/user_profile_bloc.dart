import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nur_pay/blocs/user_profile/user_profile_event.dart';
import 'package:nur_pay/blocs/user_profile/user_profile_state.dart';
import 'package:nur_pay/data/models/form_status.dart';
import 'package:nur_pay/data/models/network_response.dart';
import 'package:nur_pay/data/models/user_model.dart';
import 'package:nur_pay/data/repositories/user_profile_repo/user_profile_repo.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final UserProfileRepo userProfileRepo;

  UserProfileBloc(
    this.userProfileRepo,
  ) : super(
          UserProfileState(
            formStatus: FormStatus.pure,
            userModel: UserModel.initial(),
            errorMessage: "",
            statusMessage: "",
          ),
        ) {
    on<AddUserEvent>(_addUser);
    on<UpdateUserEvent>(_updateUser);
    on<GetCurrentUserEvent>(_getUserByUUID);
    on<DeleteUserEvent>(_deleteUser);
    on<GetUserByDocIdEvent>(_getUserByDocID);
  }

  _addUser(AddUserEvent event, emit) async {
    emit(state.copyWith(formStatus: FormStatus.loading));

    NetworkResponse networkResponse =
        await userProfileRepo.insertUser(event.userModel);

    if (networkResponse.errorText.isEmpty &&
        networkResponse.errorCode.isEmpty) {
      state.copyWith(
        formStatus: FormStatus.success,
        userModel: event.userModel,
      );
    } else {
      debugPrint(
          "\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$ERRORS: ${networkResponse.errorText} =====================${networkResponse.errorCode}");
      emit(state.copyWith(
        formStatus: FormStatus.error,
        errorMessage: networkResponse.errorText,
        statusMessage: networkResponse.errorCode,
      ));
    }
  }

  _updateUser(UpdateUserEvent event, emit) async {
    emit(state.copyWith(formStatus: FormStatus.loading));

    NetworkResponse networkResponse =
        await userProfileRepo.updateUser(event.userModel);

    if (networkResponse.errorText.isEmpty &&
        networkResponse.errorCode.isEmpty) {
      state.copyWith(
        formStatus: FormStatus.success,
        userModel: event.userModel,
      );
    } else {
      debugPrint(
          "\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$ERRORS: ${networkResponse.errorText} =====================${networkResponse.errorCode}");
      emit(state.copyWith(
        formStatus: FormStatus.error,
        errorMessage: networkResponse.errorText,
        statusMessage: networkResponse.errorCode,
      ));
    }
  }

  _deleteUser(DeleteUserEvent event, emit) async {
    emit(state.copyWith(formStatus: FormStatus.loading));

    NetworkResponse networkResponse = await userProfileRepo.deleteUser(
      event.userModel.userId,
    );

    if (networkResponse.errorText.isEmpty &&
        networkResponse.errorCode.isEmpty) {
      state.copyWith(
        formStatus: FormStatus.success,
        userModel: UserModel.initial(),
      );
    } else {
      debugPrint(
          "\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$ERRORS: ${networkResponse.errorText} =====================${networkResponse.errorCode}");
      emit(state.copyWith(
        formStatus: FormStatus.error,
        errorMessage: networkResponse.errorText,
        statusMessage: networkResponse.errorCode,
      ));
    }
  }

  _getUserByUUID(GetCurrentUserEvent event, emit) async {
    emit(state.copyWith(formStatus: FormStatus.loading));

    NetworkResponse networkResponse = await userProfileRepo.getUserByUUId(
      event.uuid,
    );

    if (networkResponse.errorText.isEmpty &&
        networkResponse.errorCode.isEmpty) {
      state.copyWith(
        formStatus: FormStatus.success,
        userModel: networkResponse.data as UserModel,
      );
    } else {
      debugPrint(
          "\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$ERRORS: ${networkResponse.errorText} =====================${networkResponse.errorCode}");
      emit(state.copyWith(
        formStatus: FormStatus.error,
        errorMessage: networkResponse.errorText,
        statusMessage: networkResponse.errorCode,
      ));
    }
  }

  _getUserByDocID(GetUserByDocIdEvent event, emit) async {
    emit(state.copyWith(formStatus: FormStatus.loading));

    debugPrint("\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$${event.docId}");

    NetworkResponse networkResponse = await userProfileRepo.getUserByDocId(
      event.docId,
    );

    if (networkResponse.errorText.isEmpty &&
        networkResponse.errorCode.isEmpty) {
      state.copyWith(
        formStatus: FormStatus.success,
        userModel: networkResponse.data as UserModel,
      );
    } else {
      debugPrint(
          "\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$ERRORS: ${networkResponse.errorText} =====================${networkResponse.errorCode}");
      emit(state.copyWith(
        formStatus: FormStatus.error,
        errorMessage: networkResponse.errorText,
        statusMessage: networkResponse.errorCode,
      ));
    }
  }
}
