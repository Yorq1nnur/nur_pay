import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/styles/app_text_style.dart';

class RegisterMethods extends StatelessWidget {
  const RegisterMethods({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 1.h,
          width: 100.w,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 12.w,
          ),
          child: Text(
            "Or continue with",
            style: AppTextStyle.interBold.copyWith(
              fontSize: 14.w,
              fontWeight: FontWeight.w600,
              color: AppColors.c6A707C,
            ),
          ),
        ),
        Container(
          height: 1.h,
          width: 100.w,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
