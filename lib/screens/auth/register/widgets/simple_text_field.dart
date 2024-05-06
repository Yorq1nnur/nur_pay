import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';
import 'package:nur_pay/utils/colors/app_colors.dart';
import 'package:nur_pay/utils/styles/app_text_style.dart';

class SimpleTextField extends StatelessWidget {
  const SimpleTextField({
    super.key,
    required this.textEditingController,
    required this.validator,
    required this.iconPath,
    required this.title,
    required this.textInputType,
    required this.textInputAction,
  });

  final TextEditingController textEditingController;
  final FormFieldValidator validator;
  final IconData iconPath;
  final String title;
  final TextInputType textInputType;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,
      textInputAction: textInputAction,
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
        prefixIcon: Icon(
          iconPath,
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
