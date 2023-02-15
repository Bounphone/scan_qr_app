import 'package:scan_qr_app/packages.dart';

class AuthService {
  static Future<AuthModel> login(String email, String password) async {
    try {
      String url = dotenv.env['USERS_LOGIN'] ?? '';
      final Dio dio = Dio();
      String payload = jsonEncode({'email': email, 'password': password});
      Response response = await dio.post(url, data: payload);
      return authModelFromJson(jsonEncode(response.data));
    } catch (e) {
      rethrow;
    }
  }

  static Future<AuthModel> signup(
      String firstname, String surname, String email, String password) async {
    try {
      String url = dotenv.env['USERS_LOGIN'] ?? '';
      final Dio dio = Dio();
      String payload = jsonEncode({'email': email, 'password': password});
      Response response = await dio.post(url, data: payload);
      return authModelFromJson(jsonEncode(response.data));
    } catch (e) {
      rethrow;
    }
  }
}
