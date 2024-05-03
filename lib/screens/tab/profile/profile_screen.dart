import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_utils/my_utils.dart';
import 'package:nur_pay/blocs/auth/auth_bloc.dart';
import 'package:nur_pay/blocs/auth/auth_event.dart';
import 'package:nur_pay/blocs/auth/auth_state.dart';
import 'package:nur_pay/blocs/user_profile/user_profile_bloc.dart';
import 'package:nur_pay/blocs/user_profile/user_profile_event.dart';
import 'package:nur_pay/blocs/user_profile/user_profile_state.dart';
import 'package:nur_pay/data/models/form_status.dart';
import 'package:nur_pay/screens/routes.dart';
import 'package:nur_pay/utils/sizedbox/get_sizedbox.dart';
import 'package:nur_pay/utils/styles/app_text_style.dart';
import 'package:nur_pay/utils/utility_functions/utility_functions.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    context.read<UserProfileBloc>().add(
          GetCurrentUserEvent(
            uuid: FirebaseAuth.instance.currentUser!.uid,
          ),
        );
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return AnnotatedRegion(
      value: systemUiOverlayStyle,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state.formStatus == FormStatus.unauthenticated) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    RouteNames.loginRoute,
                    (route) => false,
                  );
                }
              },
              child: IconButton(
                onPressed: () {
                  context.read<AuthBloc>().add(
                        LogOutUserEvent(),
                      );
                },
                icon: Icon(
                  Icons.logout,
                  size: 20.w,
                  color: Colors.black,
                ),
              ),
            ),
            20.getW(),
          ],
          centerTitle: true,
          title: const Text(
            "Profile Screen",
          ),
        ),
        body: BlocBuilder<UserProfileBloc, UserProfileState>(
          builder: (context, state) {
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.h,
                  ),
                  child: Text(
                    state.userModel.email,
                    style: AppTextStyle.interSemiBold,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.h,
                  ),
                  child: Text(
                    state.userModel.username,
                    style: AppTextStyle.interSemiBold,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.h,
                  ),
                  child: Text(
                    state.userModel.lastname,
                    style: AppTextStyle.interSemiBold,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
