import 'package:flutter_blueprint/models/dynamic_menu/dynamic_menu_model.dart' as dynamic_model;
import 'package:flutter_blueprint/packages.dart';

class DynamicMenuService {
  static Future<dynamic_model.DynamicMenuModel?> getVersion(int n) async {
    int retry = n + 1;
    String? url = dotenv.env['DYNAMIC_MENU_GETVERSION'];
    try {
      Response response = await Dio().get(url!,
          options: Options(
            headers: {
              'Content-type': 'application/json',
              'accept': 'text/plain'
            },
          ));
      return dynamic_model.dynamicMenuModelFromJson(jsonEncode(response.data));
    } on SocketException catch (e) {
      if (retry > 3) {
        throw ('ກະລຸນາເຊື່ອມຕໍ່ອິນເຕີເນັດ');
      } else {
        return await getVersion(retry);
      }
    } on DioError catch (e) {
      throw (APIUtils.setAPIErrRes(url!, e.response!));
    }
  }
}
