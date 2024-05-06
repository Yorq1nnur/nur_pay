import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/styles/app_text_style.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required this.voidCallback,
  });

  final VoidCallback voidCallback;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(
        50,
      ),
      onTap: voidCallback,
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 10.h,
            horizontal: 70.w,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              50,
            ),
            color: AppColors.c69E4F4,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(
                  0.25,
                ),
                blurRadius: 4,
                offset: const Offset(
                  0,
                  4,
                ),
              ),
            ],
          ),
          child: Text(
            "Login",
            style: AppTextStyle.interBlack.copyWith(
              fontSize: 20.w,
              fontWeight: FontWeight.w700,
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
