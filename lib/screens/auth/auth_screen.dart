import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';
import 'package:nur_pay/utils/colors/app_colors.dart';
import 'package:nur_pay/utils/sizedbox/get_sizedbox.dart';
import 'package:nur_pay/utils/styles/app_text_style.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({
    super.key,
  });

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      body: Container(
        height: MediaQuery.sizeOf(
          context,
        ).height,
        width: MediaQuery.sizeOf(
          context,
        ).width,
        decoration: const BoxDecoration(
          gradient: AppColors.authContainerGradient,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              100.getH(),
              Text(
                "Welcome\nBack!",
                style: AppTextStyle.interBold.copyWith(
                  fontSize: 40.w,
                  fontWeight: FontWeight.w900,
                ),
              ),
              80.getH(),
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.person,
                          size: 30.w,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                          borderSide: const BorderSide(
                            color: AppColors.cA8A8A9,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    24.getH(),
                    TextFormField(
                      decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.remove_red_eye,
                          size: 20.w,
                        ),
                        prefixIcon: Icon(
                          Icons.lock,
                          size: 30.w,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                          borderSide: const BorderSide(
                            color: AppColors.cA8A8A9,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
