import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';
import '../../../utils/colors/app_colors.dart';

class SaveButton extends StatelessWidget {
  const SaveButton(
      {super.key,
      required this.onTab,
      required this.loading,
      required this.active});

  final VoidCallback onTab;
  final bool loading;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 8.h,
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: active ? Colors.blue : Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              10,
            ),
          ),
        ),
        onPressed: active ? onTab : null,
        child: Center(
          child: loading
              ? const CircularProgressIndicator.adaptive()
              : Text(
                  "Save",
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 20.w,
                    fontWeight: FontWeight.w500,
                  ),
                ),
        ),
      ),
    );
  }
}
