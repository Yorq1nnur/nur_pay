import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nur_pay/blocs/user_profile_bloc/user_profile_event.dart';
import 'package:nur_pay/blocs/user_profile_bloc/user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  UserProfileBloc() : super(Initial()) {
    on<UserProfileEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
