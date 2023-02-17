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

  Future<String?> getAccessToken() async {
    try {
      final box = await Hive.openBox(boxName);
      final accessToken = box.get(accessTokenKey);
      await box.close();
      return accessToken;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> clearBox() async {
    try {
      final box = await Hive.openBox(boxName);
      await box.clear();
      await box.close();
      await Hive.deleteBoxFromDisk(boxName);
    } catch (e) {
      rethrow;
    }
  }
}
