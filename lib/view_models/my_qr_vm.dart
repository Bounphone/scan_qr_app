import 'package:scan_qr_app/packages.dart';

class MyQRVM extends ChangeNotifier {
  Future<void> onCreateQR(String qrName, double lat, double long) async {
    
    notifyListeners();
  }
}
