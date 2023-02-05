import 'package:flutter_blueprint/models/connect/token_model.dart';
import 'package:hive/hive.dart';

class AuthLocal {
  /// box name
  static const _authBox = 'authBox';

  /// key name
  static const _tokenModel = 'tokenModel';
  static const _signatureAuth = 'signatureAuth';
  static const _localAuth = 'localAuth';
  static const _username = 'username';

  /// token data
  static Future<void> setTokenData(TokenModel tokenModel) async {
    try {
      var authData = await Hive.openBox(_authBox);
      String tokenData = tokenModelToJson(tokenModel);
      authData.put(_tokenModel, tokenData);
    } catch (e) {
      rethrow;
    }
  }

  static Future<TokenModel?> getTokenData() async {
    try {
      var authData = await Hive.openBox(_authBox);
      var tokenData = authData.get(_tokenModel);

      /// if there's not data
      if (tokenData == null) {
        return null;
      } else {
        return tokenModelFromJson(tokenData);
      }
    } catch (e) {
      rethrow;
    }
  }

  ///  signature in dynamic menu
  static Future<void> setSignature(String signature) async {
    try {
      var authBox = await Hive.openBox(_authBox);
      authBox.put(_signatureAuth, signature);
    } catch (e) {
      rethrow;
    }
  }

  static Future<String?> getSignatureData() async {
    try {
      var authBox = await Hive.openBox(_authBox);
      var signatureData = authBox.get(_signatureAuth);
      return signatureData;
    } catch (e) {
      rethrow;
    }
  }

  ///  username
  static Future<void> setUserName(String username) async {
    try {
      var authBox = await Hive.openBox(_authBox);
      authBox.put(_username, username);
    } catch (e) {
      rethrow;
    }
  }

  static Future<String> getUserName() async {
    try {
      var authBox = await Hive.openBox(_authBox);
      var username = authBox.get(_username);
      return username ?? '';
    } catch (e) {
      rethrow;
    }
  }

  /// local auth
  static Future<void> setLocalAuth(bool val) async {
    try {
      var authBox = await Hive.openBox(_authBox);
      authBox.put(_localAuth, val);
    } catch (e) {
      rethrow;
    }
  }

  static Future<bool> getLocalAuth() async {
    try {
      var authBox = await Hive.openBox(_authBox);
      var localAuthData = authBox.get(_localAuth);
      return localAuthData ?? false;
    } catch (e) {
      rethrow;
    }
  }

  /// Clear auth box
  static Future<void> clearBox() async {
    await Hive.box(_authBox).clear();
  }
}
