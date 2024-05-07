import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';
import 'package:nur_pay/utils/colors/app_colors.dart';
import '../../utils/styles/app_text_style.dart';

class ShowSimpleDialog extends StatelessWidget {
  const ShowSimpleDialog({
    super.key,
    required this.onSubmit,
    required this.onCancel,
    required this.title,
    required this.subTitle,
  });

  final VoidCallback onSubmit;
  final VoidCallback onCancel;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.blueGrey,
      title: Text(
        title,
        style: AppTextStyle.interBlack.copyWith(
          fontSize: 16.w,
          color: AppColors.black,
        ),
        textAlign: TextAlign.center,
      ),
      content: Text(
        subTitle,
        style: AppTextStyle.interBlack.copyWith(
          fontSize: 16.w,
          color: AppColors.black,
        ),
        textAlign: TextAlign.center,
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.blue,
          ),
          onPressed: onSubmit,
          child:  Text('OK', style: AppTextStyle.interBold,),
        ),
        TextButton(
          onPressed: onCancel,
          style: TextButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          child:  Text('Cancel', style: AppTextStyle.interBold,),
        ),
      ],
    );
  }
}
