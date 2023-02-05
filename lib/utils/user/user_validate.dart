import 'package:flutter_blueprint/packages.dart';

class UserValidate {
  static Future<bool> isUserEverLogin() async {
    TokenModel? tokenData = await AuthLocal.getTokenData();

    /// ຖ້າ user ເຄີຍລັອກອິນ
      if (tokenData == null) {
      return false;
    }

    /// ຖ້າ user ບໍ່ເຄີຍລັອກອິນ
    else {
      return true;
    }
  }
}
