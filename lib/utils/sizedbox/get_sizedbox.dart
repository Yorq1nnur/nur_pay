import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';

extension GetSizedbox on int {
  SizedBox getH() {
    return SizedBox(
      height: (this / 812) * height,
    );
  }

  SizedBox getW() {
    return SizedBox(
      width: (this / 375) * width,
    );
  }
}
