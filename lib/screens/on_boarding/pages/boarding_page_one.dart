import 'package:flutter/material.dart';
import 'package:nur_pay/utils/sizedbox/get_sizedbox.dart';

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
      children: [
        Image.asset(
          imagePath,
        ),
        20.getH(),
        Text(title)
      ],
    );
  }
}
