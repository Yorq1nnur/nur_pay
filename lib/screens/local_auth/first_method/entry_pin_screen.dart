import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_utils/my_utils.dart';
import 'package:nur_pay/blocs/auth/auth_bloc.dart';
import 'package:nur_pay/blocs/auth/auth_event.dart';
import 'package:nur_pay/blocs/auth/auth_state.dart';
import 'package:nur_pay/data/models/form_status.dart';
import 'package:nur_pay/screens/local_auth/widgets/pin_put_items.dart';
import 'package:nur_pay/screens/local_auth/widgets/custom_keyboard.dart';
import 'package:nur_pay/services/biometric_auth_servise.dart';
import 'package:nur_pay/utils/sizedbox/get_sizedbox.dart';
import 'package:nur_pay/utils/styles/app_text_style.dart';
import 'package:pinput/pinput.dart';
import '../../../data/local/storage_repository.dart';
import '../../routes.dart';

class EntryPinScreen extends StatefulWidget {
  const EntryPinScreen({
    super.key,
  });

  @override
  State<EntryPinScreen> createState() => _EntryPinScreenState();
}

class _EntryPinScreenState extends State<EntryPinScreen> {
  final TextEditingController pinPutController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  bool isError = false;
  bool biometricsEnabled = false;
  int attemptCount = 0;
  String currentPin = "";

  @override
  void initState() {
    biometricsEnabled = StorageRepository.getBool(key: "biometrics_enabled");
    currentPin = StorageRepository.getString(key: "pin_code");
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
            "Pin kod kiriting!",
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
          Text(
            isError ? "Pin kod noto'g'ri!" : "",
            style: AppTextStyle.interMedium
                .copyWith(fontSize: 20, color: Colors.red),
          ),
          if (height > 700) 32.getH(),
          CustomKeyboard(
            onFingerPrintTap: checkBiometrics,
            number: (number) {
              if (pinPutController.length < 4) {
                pinPutController.text = "${pinPutController.text}$number";
              }
              if (pinPutController.length == 4) {
                if (currentPin == pinPutController.text) {
                  Navigator.pushReplacementNamed(context, RouteNames.tabRoute);
                } else {
                  attemptCount++;
                  if (attemptCount == 3) {
                    context.read<AuthBloc>().add(LogOutUserEvent());
                  }
                  isError = true;
                  pinPutController.clear();
                }
                pinPutController.text = "";
              }
              setState(() {});
            },
            isBiometricsEnabled: biometricsEnabled,
            onClearButtonTap: () {
              if (pinPutController.length > 0) {
                pinPutController.text = pinPutController.text
                    .substring(0, pinPutController.text.length - 1);
              }
            },
          ),
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state.formStatus == FormStatus.unauthenticated) {
                Navigator.pushNamedAndRemoveUntil(
                    context, RouteNames.loginRoute, (route) => false);
              }
            },
            child: const SizedBox(),
          )
        ],
      ),
    );
  }

  Future<void> checkBiometrics() async {
    bool authenticated = await BiometricAuthService.authenticate();
    if (authenticated) {
      if (mounted) {
        Navigator.pushReplacementNamed(context, RouteNames.tabRoute);
      }
    }
  }
}
