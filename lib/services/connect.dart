import 'package:flutter_blueprint/packages.dart';

class ConnectService {
  static Future<AuthorizeUserModel> authorize(
      String username, int n, bool reqOTP) async {
    int retry = n + 1;
    String? url = reqOTP
        ? dotenv.env['CONNECT_AUTHORIZE']
        : dotenv.env['CONNECT_VALIDATE_USER'];
    DateTime now = DateTime.now();
    String logOn = DateFormat('yyyy-MM-ddTkk:mm:ss').format(now);
    var bytes = utf8.encode('P' + username + 'L' + logOn); // bytes
    var signature = md5.convert(bytes).toString(); // hd5 code
    String payload = jsonEncode({"username": username, "logon": logOn});
    try {
      Response response = await Dio().post(url!,
          options: Options(
            headers: {
              'Content-type': 'application/json',
              'accept': 'text/plain',
              'signature': signature
            },
          ),
          data: payload);
      return authorizeUserModelFromJson(jsonEncode(response.data));
    } on SocketException catch (e) {
      if (retry > 3) {
        throw ('ກະລຸນາເຊື່ອມຕໍ່ອິນເຕີເນັດ');
      } else {
        return await authorize(username, retry, reqOTP);
      }
    } on DioError catch (e) {
      throw (APIUtils.setAPIErrRes(url!, e.response!));
    }
  }

  static Future<TokenModel?> reqToken(
      String username, String password, int n) async {
    String? url = dotenv.env['CONNECT_TOKEN'];
    int retry = n + 1;
    try {
      String payload = jsonEncode({
        "clientID": dotenv.env['CLIENT_ID'],
        "secret": dotenv.env['SECRET'],
        "grantType": dotenv.env['GRANT_TYPE'],
        "scope": dotenv.env['SCOPE'],
        "username": username,
        "password": '$password@Telbiz.la'
      });
      Response response = await Dio().post(url!,
          options: Options(
            headers: {
              'Content-type': 'application/json',
              'accept': 'text/plain'
            },
          ),
          data: payload);
      return tokenModelFromJson(jsonEncode(response.data));
    } on SocketException catch (e) {
      if (retry > 3) {
        throw ('ກະລຸນາເຊື່ອມຕໍ່ອິນເຕີເນັດ');
      } else {
        return reqToken(username, password, retry);
      }
    } on DioError catch (e) {
      throw (APIUtils.setAPIErrRes(url!, e.response!));
    }
  }

  static Future<TokenModel?> refreshAccessToken(
      int n, String refreshToken) async {
    String? url = dotenv.env['CONNECT_REFRESH_TOKEN'];
    int retry = n + 1;
    try {
      String payload = jsonEncode({
        "clientID": dotenv.env['CLIENT_ID'],
        "secret": dotenv.env['SECRET'],
        "refreshToken": refreshToken
      });
      Response response = await Dio().post(url!,
          options: Options(
            headers: {
              'Content-type': 'application/json',
              'accept': 'text/plain'
            },
          ),
          data: payload);
      return tokenModelFromJson(jsonEncode(response.data));
    } on SocketException catch (e) {
      if (retry > 3) {
        throw ('ກະລຸນາເຊື່ອມຕໍ່ອິນເຕີເນັດ');
      } else {
        return await refreshAccessToken(retry, refreshToken);
      }
    } on DioError catch (e) {
      throw (APIUtils.setAPIErrRes(url!, e.response!));
    }
  }
}
