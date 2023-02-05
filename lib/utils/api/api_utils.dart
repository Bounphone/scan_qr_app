import 'package:flutter_blueprint/models/bad_req/bad_req_model.dart';
import 'package:flutter_blueprint/packages.dart';

class APIUtils {
  static String setAPIErrRes(String url, Response response) {
    if (response.statusCode == 400) {
      BadReqModel badReqModel = badReqModelFromJson(jsonEncode(response.data));
      String message = badReqModel.message ?? 'Bad request data';
      return message;
    } else if (response.statusCode == 401) {
      return 'Unauthorized';
    } else if (response.statusCode == 500) {
      return 'Internal Server';
    } else {
      return 'Not found';
    }
  }
}
