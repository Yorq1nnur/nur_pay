import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';

import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/styles/app_text_style.dart';

class OtherMethodsLogin extends StatelessWidget {
  const OtherMethodsLogin({
    super.key,
    required this.voidCallback,
  });

  final VoidCallback voidCallback;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 15.w,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Don’t have an account?",
            style: AppTextStyle.interBold.copyWith(
              fontSize: 17.w,
              fontWeight: FontWeight.w500,
              color: AppColors.c1E232C,
            ),
          ),
          InkWell(
            onTap: voidCallback,
            child: Center(
              child: Text(
                "Register Now",
                style: AppTextStyle.interBold.copyWith(
                  fontSize: 17.w,
                  fontWeight: FontWeight.w700,
                  color: AppColors.c009FFF,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
