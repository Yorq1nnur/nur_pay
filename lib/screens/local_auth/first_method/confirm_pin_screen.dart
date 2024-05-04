import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';
import 'package:nur_pay/screens/local_auth/widgets/pin_put_items.dart';
import 'package:nur_pay/screens/local_auth/widgets/custom_keyboard.dart';
import 'package:nur_pay/services/biometric_auth_servise.dart';
import 'package:nur_pay/utils/sizedbox/get_sizedbox.dart';
import 'package:pinput/pinput.dart';
import '../../../data/local/storage_repository.dart';
import '../../../utils/styles/app_text_style.dart';
import '../../routes.dart';

class ConfirmPinScreen extends StatefulWidget {
  const ConfirmPinScreen({super.key, required this.previousPin});

  final String previousPin;

  @override
  State<ConfirmPinScreen> createState() => _ConfirmPinScreenState();
}

class _ConfirmPinScreenState extends State<ConfirmPinScreen> {
  final TextEditingController pinPutController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  bool isError = false;
  bool isBiometricsEnabled = false;

  @override
  void initState() {
    BiometricAuthService.canAuthenticate().then(
      (value) {
        if (value) {
          isBiometricsEnabled = true;
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Entry pin"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          60.getH(),
          Text(
            "Pin kodlar  O'mos emas!",
            style: AppTextStyle.interMedium.copyWith(fontSize: 20),
          ),
          32.getH(),
          SizedBox(
            width: width / 2,
            child: PinPutItems(
                pinPutFocusMode: focusNode,
                pinPutController: pinPutController,
                isError: isError),
          ),
          32.getH(),
          CustomKeyboard(
            number: (number) {
              if (pinPutController.length < 4) {
                pinPutController.text = "${pinPutController.text}$number";
              }
              if (pinPutController.length == 4) {
                if (widget.previousPin == pinPutController.text) {
                  _setPin(pinPutController.text);
                } else {
                  isError = true;
                  pinPutController.clear();
                }
                pinPutController.text = "";
              }
              setState(() {});
            },
            isBiometricsEnabled: false,
            onClearButtonTap: () {
              if (pinPutController.length > 0) {
                pinPutController.text = pinPutController.text
                    .substring(0, pinPutController.text.length - 1);
              }
            },
          )
        ],
      ),
    );
  }

  Future<void> _setPin(String pin) async {
    await StorageRepository.setString(key: "pin_code", value: pin);
    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(
        context,
        isBiometricsEnabled ? RouteNames.touchId : RouteNames.tabRoute,
        (route) => false);
  }
}
