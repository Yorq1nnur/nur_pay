import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_utils/my_utils.dart';
import 'package:nur_pay/utils/styles/app_text_style.dart';

import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/images/app_images.dart';

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({
    super.key,
    required this.isVisible,
    required this.valueChanged,
    required this.textEditingController,
    required this.validator,
    required this.voidCallback, required this.title,
  });

  final bool isVisible;
  final ValueChanged valueChanged;
  final TextEditingController textEditingController;
  final FormFieldValidator validator;
  final VoidCallback voidCallback;
  final String title;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isVisible,
      onChanged: valueChanged,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.next,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: textEditingController,
      validator: validator,
      decoration: InputDecoration(
        labelText: title,
        labelStyle: AppTextStyle.interBold.copyWith(
          fontSize: 15.w,
          fontWeight: FontWeight.w500,
          color: AppColors.c676767,
        ),
        suffixIcon: IconButton(
          icon: SvgPicture.asset(
            isVisible ? AppImages.eye : AppImages.eyeUnVisible,
            width: 25.w,
            height: 25.h,
            fit: BoxFit.fill,
            colorFilter: const ColorFilter.mode(
              Colors.black,
              BlendMode.srcIn,
            ),
          ),
          onPressed: voidCallback,
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
    );
  }
}
