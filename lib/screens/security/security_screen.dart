import 'package:flutter/material.dart';
import 'package:nur_pay/services/biometric_auth_servise.dart';
import 'package:nur_pay/utils/utility_functions/utility_functions.dart';
import '../../data/local/storage_repo.dart';
import 'global_button_security.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({
    super.key,
  });

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Security screen",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          26.0,
        ),
        child: Column(
          children: [
            SecurityButton(
              isEnabled: StorageRepository.getBool(
                key: 'biometrics',
              ),
              onTab: () async {
                bool isEnabled = StorageRepository.getBool(
                  key: 'biometrics',
                );
                if (isEnabled) {
                  await StorageRepository.setBool(
                    key: 'biometrics',
                    value: false,
                  );
                } else {
                  bool authenticated =
                      await BiometricAuthService.authenticate();
                  if (authenticated) {
                    await StorageRepository.setBool(
                      key: 'biometrics',
                      value: true,
                    );
                    if (!context.mounted) return;
                    showSnackBar(
                      context: context,
                      message: "Boimetrics saved",
                    );
                  } else {
                    if (!context.mounted) return;
                    showSnackBar(
                      context: context,
                      message: "Boimetrics Error",
                      color: Colors.red,
                    );
                  }
                }
                setState(() {});
              },
            )
          ],
        ),
      ),
    );
  }
}
