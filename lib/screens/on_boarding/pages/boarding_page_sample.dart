import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';
import 'package:nur_pay/utils/sizedbox/get_sizedbox.dart';
import 'package:nur_pay/utils/styles/app_text_style.dart';

class BoardingPageSample extends StatelessWidget {
  const BoardingPageSample({
    super.key,
    required this.imagePath,
    required this.title,
  });

  final String imagePath;
  final String title;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          imagePath,
        ),
        20.getH(),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10.w,
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyle.interSemiBold.copyWith(fontSize: 14),
          ),
        ),
      ],
    );
  }
}
