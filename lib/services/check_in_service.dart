import 'package:scan_qr_app/models/check_in/get_checkin_model.dart';
import 'package:scan_qr_app/models/check_in/new_checkin_model.dart';
import 'package:scan_qr_app/packages.dart';

class CheckInService {
  static Future<NewCheckInModel> newCheckIn(
      String qrID,
      String qrName,
      double lat,
      double long,
      String checkInDate,
      String accessToken,
      String userID) async {
    try {
      String url = dotenv.env['CHECK_IN'] ?? '';
      final Dio dio = Dio();
      String payload = jsonEncode({
        "qrId": qrID,
        'qrName': qrName,
        "checkInDate": checkInDate,
        "latitude": lat,
        "longtitude": long,
        "userId": userID
      });
      Response response = await dio.post(url,
          data: payload,
          options: Options(headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json'
          }));
      return newCheckInModelFromJson(jsonEncode(response.data));
    } on DioError catch (e) {
      rethrow;
    }
  }

  static Future<GetCheckInModel> getCheckIn(
      String userID, String accessToken) async {
    try {
      String url = dotenv.env['CHECK_IN'] ?? '';
      final Dio dio = Dio();
      Response response = await dio.get('$url/$userID',
          options: Options(headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json'
          }));
      return getCheckInModelFromJson(jsonEncode(response.data));
    } on DioError catch (e) {
      rethrow;
    }
  }
}
