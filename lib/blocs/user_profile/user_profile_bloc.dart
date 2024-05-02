import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nur_pay/blocs/user_profile/user_profile_event.dart';
import 'package:nur_pay/blocs/user_profile/user_profile_state.dart';
import 'package:nur_pay/data/models/form_status.dart';
import 'package:nur_pay/data/models/user_model.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  UserProfileBloc()
      : super(
          UserProfileState(
            formStatus: FormStatus.pure,
            userModel: UserModel.initial(),
            errorMessage: "",
            statusMessage: "",
          ),
        ) {
    on<UserProfileEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
