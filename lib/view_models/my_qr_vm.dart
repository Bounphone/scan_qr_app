import 'package:scan_qr_app/packages.dart';

class MyQRVM extends ChangeNotifier {
  GetMyQrModel? _getMyQrModel;
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  GetMyQrModel? get getMyQrModel => _getMyQrModel;

  Future<void> onCreateQR(
      String qrName, double lat, double long, BuildContext context) async {
    try {
      String accessToken = context.read<AuthVM>().getAccessToken ?? '';
      Map<String, dynamic> decodedToken = Jwt.parseJwt(accessToken);
      AccessTokenModel accessTokenModel =
          accessTokenModelFromJson(jsonEncode(decodedToken));
      String userID = accessTokenModel.id;
      String qrCode = 'SCAN2CHECK/CHECKIN/$qrName';
      NewQrModel newQrModel = await MyQRService.newQR(
          qrName, qrCode, userID, lat, long, accessToken);
      _getMyQrModel!.data.add(Datum(
          id: newQrModel.data.id,
          name: newQrModel.data.name,
          qrCode: newQrModel.data.qrCode,
          createdBy: newQrModel.data.createdBy,
          latitude: newQrModel.data.latitude,
          longtitude: newQrModel.data.longtitude,
          createdAt: newQrModel.data.createdAt,
          updatedAt: newQrModel.data.updatedAt,
          v: newQrModel.data.v));
      // print('Le')
      Navigator.pop(context);
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

  Future<void> getMyQR(BuildContext context) async {
    _isLoading = true;
    try {
      String accessToken = context.read<AuthVM>().getAccessToken ?? '';
      Map<String, dynamic> decodedToken = Jwt.parseJwt(accessToken);
      AccessTokenModel accessTokenModel =
          accessTokenModelFromJson(jsonEncode(decodedToken));
      String userID = accessTokenModel.id;
      _getMyQrModel = await MyQRService.getMyQR(accessToken, userID);
    } catch (e) {
      rethrow;
    }
    _isLoading = false;
    notifyListeners();
  }
}
