import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_utils/my_utils.dart';
import 'package:nur_pay/utils/colors/app_colors.dart';
import 'package:nur_pay/utils/styles/app_text_style.dart';
import 'package:toast/toast.dart';

SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
  statusBarColor: AppColors.transparent,
  statusBarBrightness: Brightness.dark,
  statusBarIconBrightness: Brightness.dark,
);

void methodPrint(dynamic data) {
  debugPrint("\$\$\$\$\$\$\n$data\n\$\$\$\$\$\$");
}

showToast({
  required BuildContext context,
  required dynamic message,
  Color? color,
}) {
  ToastContext toastContext = ToastContext();
  toastContext.init(
    context,
  );
  Toast.show(
    "$message",
    duration: Toast.lengthLong,
    gravity: Toast.top,
    border: Border.all(
      color: Colors.black.withOpacity(
        0.6,
      ),
      width: 2.w,
    ),
    backgroundColor: color ?? Colors.blue,
    textStyle: AppTextStyle.interBold.copyWith(
      color: AppColors.black,
      fontSize: 16.w,
    ),
    backgroundRadius: 25,
  );
}

showSnackBar({
  required BuildContext context,
  required String message,
  Color? color,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color ?? Colors.blue,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(
            16,
          ),
          topLeft: Radius.circular(
            16,
          ),
        ),
      ),
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: AppTextStyle.interSemiBold.copyWith(
          fontSize: 20.w,
          color: Colors.black,
        ),
      ),
    ),
  );
}

showErrorForRegister(
  String code,
  BuildContext context,
) {
  if (code == 'weak-password') {
    methodPrint('The password provided is too weak.');
    if (!context.mounted) return;
    showToast(
      color: Colors.red,
      context: context,
      message: "Passwordni xato kiritdingiz!!!",
    );
  } else if (code == 'email-already-in-use') {
    methodPrint('The account already exists for that email.');
    if (!context.mounted) return;
    showToast(
      color: Colors.red,
      context: context,
      message: "Bu e-pochta uchun hisob allaqachon mavjud!!!",
    );
  }
}

showErrorForLogin(
  String code,
  BuildContext context,
) {
  if (code == 'wrong-password') {
    methodPrint('The password provided is wrong.');
    if (!context.mounted) return;
    showToast(
      color: Colors.red,
      context: context,
      message: "Passwordni xato kiritdingiz!!!",
    );
  } else if (code == 'invalid-email') {
    methodPrint('The e-mail is invalid!!!');
    if (!context.mounted) return;
    showToast(
      color: Colors.red,
      context: context,
      message: "Bu e-pochta yaqroqsiz!!!",
    );
  } else if (code == 'user-disabled') {
    methodPrint('The user is blocked.');
    if (!context.mounted) return;
    showToast(
      color: Colors.red,
      context: context,
      message: "Foydalanuvchi bloklangan!!!",
    );
  } else if (code == "user not found") {
    methodPrint('The user is not found.');
    if (!context.mounted) return;
    showToast(
      color: Colors.red,
      context: context,
      message: "Foydalanuvchi topilmadi!!!",
    );
  } else {
    methodPrint('The user is not found.');
    if (!context.mounted) return;
    showToast(
      color: Colors.red,
      context: context,
      message: "Noma'lum xatolik!!!",
    );
  }
}

List<String> cardTypes = [
  "UZCARD",
  "HUMO",
  "VISA",
  "MASTERCARD",
  "UNION PAY",
];

List<List<Color>> gradientColors = [
  [
    const Color(0xFF23F2E6),
    const Color(0xFF2ACB4E),
    const Color(0xFFC529FC),
  ],
  [
    const Color(0xFFFFD951),
    const Color(0xFFEC201B),
  ],
  [
    const Color(0xFF006BFF),
    const Color(0xFF343AD7),
    const Color(0xFFF43DF7),
  ],
  [
    const Color(0xFF4EDFFF),
    const Color(0xFFFFD90F),
    const Color(0xFF930BFD),
  ],
  [
    const Color(0xFF0038FF),
    const Color(0xFF00E0FF),
    const Color(0xFF1FAEFF),
  ],
  [
    const Color(0xFF0A7CCF),
    const Color(0xFF22FF53),
    const Color(0xFF22FF95),
  ],
  [
    const Color(0xFF4D20FF),
    const Color(0xFFE46289),
    const Color(0xFFFF5789),
  ],
  [
    const Color(0xFF00FFC2),
    const Color(0xFF1CF2CC),
    const Color(0xFF2F9FF1),
  ],
  [
    const Color(0xFF001973),
    const Color(0xFF00AAB8),
    const Color(0xFF00E0FF),
    const Color(0xFF423FC3),
  ],
  [
    const Color(0xFFFF29A8),
    const Color(0xFFFF7A00),
    const Color(0xFFFFD481),
  ],
  [
    const Color(0xFFFFDCC5),
    const Color(0xFFB515D0),
    const Color(0xFFB515D0).withOpacity(
      0.8,
    ),
  ],
  [
    const Color(0xFF4EDFFF),
    const Color(0xFF6A24FE),
    const Color(0xFF929CF3),
  ],
  [
    const Color(0xFF3F00B9),
    const Color(0xFFE507B6),
    const Color(0xFFFF8993),
  ],
  [
    const Color(0xFF00EAFF),
    const Color(0xFF4E29E4),
    const Color(0xFF6A40D3),
    const Color(0xFF9AAAFF),
  ],
  [
    const Color(0xFF0466EE),
    const Color(0xFF35DDA1),
    const Color(0xFF46B835),
  ],
  [
    const Color(0xFF0032EF),
    const Color(0xFF1AC7FF),
    const Color(0xFF339DFF),
    const Color(0xFFFF16F0),
  ],
  [
    const Color(0xFF9020FF),
    const Color(0xFFEB20B2),
    const Color(0xFFFF8B20),
  ],
  [
    const Color(0xFF20E4FF),
    const Color(0xFF4D20FF),
    const Color(0xFFFFD90F),
  ],
  [
    const Color(0xFF00A3FF),
    const Color(0xFFFFBE40),
    const Color(0xFFFFF065),
  ],
  [
    const Color(0xFFFF22F6),
    const Color(0xFFFF9900),
    const Color(0xFF00A3FF),
  ],
];
