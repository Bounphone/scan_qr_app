import 'package:flutter_blueprint/packages.dart';

class AppErrors {

  /// For return exception text
  static String errHandling(dynamic e) {
    /// if development environment will return exception
    if (dotenv.env['ENVIRONMENT'] == 'development') {
      return e;
    }

    /// And if prod environment will return text that user can understand
    else {
      return 'ເກີດຂໍ້ຜິດພາດ';
    }
  }
}
