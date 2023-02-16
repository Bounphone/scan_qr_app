
import 'package:scan_qr_app/packages.dart';

class MyQRService {
  static Future<NewQrModel> newQR(String qrName, String qrCode, String userID,
      double lat, double long, String accessToken) async {
    try {
      String url = dotenv.env['MY_QR'] ?? '';
      final Dio dio = Dio();
      String payload = jsonEncode({
        "name": qrName,
        "qrCode": qrCode,
        "createdBy": userID,
        "latitude": lat,
        "longtitude": long
      });
      Response response = await dio.post(url,
          data: payload,
          options: Options(headers: {'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json'}));
      return newQrModelFromJson(jsonEncode(response.data));
    } catch (e) {
      rethrow;
    }
  }

  static Future<GetMyQrModel> getMyQR(String accessToken, String userID) async {
    try {
      String url = dotenv.env['MY_QR'] ?? '';
      final Dio dio = Dio();
      Response response = await dio.get('$url/$userID',
          options: Options(headers: {'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json'}));
      return getMyQrModelFromJson(jsonEncode(response.data));
    } catch (e) {
      rethrow;
    }
  }
}
