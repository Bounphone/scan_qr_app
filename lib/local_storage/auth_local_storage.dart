import 'package:scan_qr_app/models/auth/access_token_model.dart';
import 'package:scan_qr_app/packages.dart';

class AuthLocalStorage {
  final accessTokenKey = 'accessTokenKey';

  final boxName = 'authLocalStorage';

  Future<void> setAccessToken(String accessToken) async {
    try {
      final box = await Hive.openBox(boxName);
      box.put(accessTokenKey, accessToken);
      await box.close();
    } catch (e) {
      rethrow;
    }
  }

  Future<AccessTokenModel?> getAccessToken() async {
    try {
      final box = await Hive.openBox(boxName);
      final accessToken = box.get(accessTokenKey);
      await box.close();
      if (accessToken != null) {
        Map<String, dynamic> decodedToken = Jwt.parseJwt(accessToken);
        AccessTokenModel accessTokenModel =
            accessTokenModelFromJson(jsonEncode(decodedToken));
        return accessTokenModel;
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }
}
