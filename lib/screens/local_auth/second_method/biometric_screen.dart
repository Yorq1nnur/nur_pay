import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';
import 'package:nur_pay/services/biometric_auth_servise.dart';
import 'package:nur_pay/utils/utility_functions/utility_functions.dart';
import '../../../data/local/storage_repo.dart';
import '../../routes.dart';

class BiometricScreen extends StatefulWidget {
  const BiometricScreen({super.key});

  @override
  State<BiometricScreen> createState() => _BiometricScreenState();
}

class _BiometricScreenState extends State<BiometricScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.fingerprint, size: 150.w),
            TextButton(
                onPressed: enabledBio, child: const Text("Biometric auth")),
            TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, RouteNames.tabRoute, (route) => false);
                },
                child: const Text("skip"))
          ],
        ),
      ),
    );
  }

  Future<void> enabledBio() async {
    bool authenticated = await BiometricAuthService.authenticate();
    if (authenticated) {
      await StorageRepository.setBool(key: 'biometrics', value: true);
      if (mounted) {
        showToast(
          context: context,
          message: "BIOMETRICS SAVED",
        );
        Navigator.pushNamedAndRemoveUntil(
          context,
          RouteNames.tabRoute,
          (route) => false,
        );
      }
    } else {
      if (mounted) {
        showToast(
          context: context,
          message: "BIOMETRICS ERROR!!!",
        );
      }
    }
  }
}
