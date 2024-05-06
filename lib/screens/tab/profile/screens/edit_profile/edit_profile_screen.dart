import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_utils/my_utils.dart';
import 'package:nur_pay/blocs/auth/auth_bloc.dart';
import 'package:nur_pay/blocs/auth/auth_event.dart';
import 'package:nur_pay/utils/colors/app_colors.dart';
import 'package:nur_pay/utils/sizedbox/get_sizedbox.dart';
import 'package:nur_pay/utils/styles/app_text_style.dart';
import 'package:nur_pay/utils/utility_functions/utility_functions.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({
    super.key,
    required this.voidCallback,
  });

  final VoidCallback voidCallback;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: systemUiOverlayStyle,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.save_rounded,
                color: AppColors.black,
                size: 20.w,
              ),
            ),
          ],
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              widget.voidCallback.call();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 20.w,
            ),
          ),
          centerTitle: true,
          title: Text(
            "Update profile",
            style: AppTextStyle.interBold,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 20.h,
          ),
          child: Column(
            children: [
              const Spacer(),
              Ink(
                width: double.infinity,
                height: 50.h,
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(
                    50,
                  ),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(
                    50,
                  ),
                  onTap: () {
                    context.read<AuthBloc>().add(
                          LogOutUserEvent(),
                        );
                  },
                  child: Center(
                    child: Text(
                      'Logout',
                      style: AppTextStyle.interBold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
