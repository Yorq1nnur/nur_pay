import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/styles/app_text_style.dart';

class OtherMethod extends StatelessWidget {
  const OtherMethod({
    super.key,
    required this.voidCallback,
  });

  final VoidCallback voidCallback;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 35.w,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "I Already Have an Account",
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
                "Login",
                style: AppTextStyle.interBold.copyWith(
                  fontSize: 17.w,
                  fontWeight: FontWeight.w700,
                  color: AppColors.c009FFF,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
