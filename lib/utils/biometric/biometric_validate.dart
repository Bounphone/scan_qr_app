import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class BiometricValidate {
  /// ເຂົ້າສູ່ລະບົບດ້ວຍ Biometric
  static Future<bool> authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      final LocalAuthentication auth = LocalAuthentication();
      authenticated = await auth.authenticate(
        localizedReason:
            'ສະແກນໃບໜ້າ ຫຼື ນິ້ວມືຂອງທ່ານເພື່ອເຂົ້າສູ່ລະບົບ',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
    } on PlatformException catch (e) {
      return authenticated;
    }
    return authenticated;
  }

  /// ກວດສອບວ່າອຸປະກອນສະໜັບສະໜຸນ Biometric ຫຼື ບໍ?
  static Future<bool> isDeviceSupport() async {
    try {
      final LocalAuthentication auth = LocalAuthentication();
      bool isDeviceSupport = await auth.isDeviceSupported();
      return isDeviceSupport;
    } catch (e) {
      rethrow;
    }
  }
}
