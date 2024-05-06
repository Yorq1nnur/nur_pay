import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';
import 'package:nur_pay/utils/colors/app_colors.dart';
import 'package:nur_pay/utils/sizedbox/get_sizedbox.dart';
import 'package:nur_pay/utils/utility_functions/utility_functions.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({
    super.key,
  });

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  @override
  Widget build(
    BuildContext context,
  ) {
    return AnnotatedRegion(
      value: systemUiOverlayStyle,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Ink(
              height: 30.w,
              width: 30.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  50,
                ),
                color: Colors.blueGrey.withOpacity(
                  0.2,
                ),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(
                  50,
                ),
                child: Center(
                  child: Icon(
                    Icons.add,
                    color: AppColors.black,
                    size: 20.w,
                  ),
                ),
              ),
            ),
            10.getW(),
          ],
          centerTitle: true,
          title: const Text(
            "My cards",
          ),
        ),
      ),
    );
  }
}
