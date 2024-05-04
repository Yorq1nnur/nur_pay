import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:nur_pay/utils/utility_functions/utility_functions.dart';

class BiometricAuthService {
  static LocalAuthentication auth = LocalAuthentication();

  static Future<bool> canAuthenticate() async {
    final bool canAuthenticateBiometrics = await auth.canCheckBiometrics;

    final bool canAuthenticate =
        canAuthenticateBiometrics || await auth.isDeviceSupported();

    if (canAuthenticate) {
      List<BiometricType> types = await auth.getAvailableBiometrics();
      if (types.isNotEmpty) return true;
    }

    return false;
  }

  static Future<bool> authenticate() async {
    try {
      return await auth.authenticate(
          localizedReason: "Barmoq izini faollashtiring",
          options: const AuthenticationOptions(
            useErrorDialogs: false,
            stickyAuth: true,
            biometricOnly: true,
          ));
    } on PlatformException catch (e) {
      methodPrint("Biometrics Error:${e.code}");
      if (e.code == auth_error.notAvailable) {
        methodPrint("BIOMETRIC AUTH NOT SUPPORTED");
      } else if (e.code == auth_error.notEnrolled) {
        methodPrint("BIOMETRIC AUTH NOT SUPPORTED USE");
      } else {
        methodPrint("SOMETHING WRONG");
      }
      return false;
    }
  }
}
