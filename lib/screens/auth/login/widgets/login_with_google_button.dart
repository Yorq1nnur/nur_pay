import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_utils/my_utils.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/images/app_images.dart';
import '../../../../utils/styles/app_text_style.dart';

class LoginWithGoogleButton extends StatelessWidget {
  const LoginWithGoogleButton({
    super.key,
    required this.voidCallback,
  });

  final VoidCallback voidCallback;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
      ),
      child: Center(
        child: InkWell(
          borderRadius: BorderRadius.circular(
            50,
          ),
          onTap: voidCallback,
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 10.h,
              horizontal: 30.w,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                50,
              ),
              gradient: AppColors.loginWithGoogleGradient,
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SvgPicture.asset(
                    AppImages.google,
                    height: 30.w,
                    width: 30.w,
                  ),
                  Text(
                    "Login with Google",
                    style: AppTextStyle.interBold.copyWith(
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
