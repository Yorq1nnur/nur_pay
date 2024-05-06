import 'package:local_auth/local_auth.dart';
import 'package:nur_pay/utils/utility_functions/utility_functions.dart';

class BiometricAuthService {
  static LocalAuthentication auth = LocalAuthentication();

  static Future<bool> canAuthenticated() async {
    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    final bool canAuthenticate =
        canAuthenticateWithBiometrics || await auth.isDeviceSupported();

    if (canAuthenticate) {
      List<BiometricType> types = await auth.getAvailableBiometrics();
      if (types.isNotEmpty) {
        return true;
      }
    }
    return false;
  }

  static Future<bool> authenticate() async {
    try {
      methodPrint("authenticate");
      methodPrint(
          "AAaaa${await auth.authenticate(localizedReason: "Barmoq izini faollashtirish", options: const AuthenticationOptions(
                useErrorDialogs: false,
                sensitiveTransaction: false,
                stickyAuth: true,
                biometricOnly: true,
              ))}");
      return await auth.authenticate(
          localizedReason: "Barmoq izini faollashtirish",
          options: const AuthenticationOptions(
            useErrorDialogs: false,
            stickyAuth: true,
            biometricOnly: true,
          ));
    } catch (e) {
      return false;
    }
  }
}
