import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:location/location.dart';
import 'package:scan_qr_app/models/check_in/get_checkin_model.dart';
import 'package:scan_qr_app/models/check_in/new_checkin_model.dart';
import 'package:scan_qr_app/packages.dart';
import 'package:scan_qr_app/services/check_in_service.dart';
import 'package:scan_qr_app/utils/location/get_location.dart';
import 'package:scan_qr_app/widgets/dialog/dialog_loading.dart';

class CheckInVM extends ChangeNotifier {
  GetCheckInModel? _getCheckInModel;
  NewCheckInModel? _newCheckInModel;
  bool _isLoading = false;

  NewCheckInModel? get newCheckInModel => _newCheckInModel;
  GetCheckInModel? get getCheckInModel => _getCheckInModel;
  bool get isLoading => _isLoading;

  Future<void> onCheckIn(BuildContext context, String qrData) async {
    try {
      List<String> qrSplited = qrData.split('/');
      if (qrSplited.length >= 3 && qrData.startsWith('SCAN2CHECK/CHECKIN/')) {
        dialogLoading(context);
        String accessToken = context.read<AuthVM>().getAccessToken ?? '';
        Map<String, dynamic> decodedToken = Jwt.parseJwt(accessToken);
        AccessTokenModel accessTokenModel =
            accessTokenModelFromJson(jsonEncode(decodedToken));
        String userID = accessTokenModel.id;
        String checkInDate =
            DateFormat('yyyy-MM-ddTHH:mm:ss').format(DateTime.now());
        String qrID = '1';
        String qrName = qrSplited[2];
        LocationData locationData = await getLocation();
        double lat = locationData.latitude ?? 0;
        double long = locationData.longitude ?? 0;
        _newCheckInModel = await CheckInService.newCheckIn(
            qrID, qrName, lat, long, checkInDate, accessToken, userID);
        Navigator.pop(context);
        AwesomeDialog(
            context: context,
            animType: AnimType.scale,
            dialogType: DialogType.success,
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Text(
                'ທ່ານໄດ້ສະແກນ QR ຂອງ ${_newCheckInModel!.data.qrId} ສຳເລັດແລ້ວ',
                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14.sp),
                textAlign: TextAlign.center,
              ),
            ),
            btnOkOnPress: () {
              Navigator.pop(context);
            })
          ..show();
      } else {
        AwesomeDialog(
            context: context,
            animType: AnimType.scale,
            dialogType: DialogType.error,
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Text(
                'ຂໍອະໄພ ຮູບແບບ QR ຂອງທ່ານບໍ່ຖືກຕ້ອງ',
                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14.sp),
                textAlign: TextAlign.center,
              ),
            ),
            btnOkOnPress: () {})
          ..show();
      }
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

  Future<void> getCheckIn(BuildContext context) async {
    _isLoading = true;
    try {
      String accessToken = context.read<AuthVM>().getAccessToken ?? '';
      Map<String, dynamic> decodedToken = Jwt.parseJwt(accessToken);
      AccessTokenModel accessTokenModel =
          accessTokenModelFromJson(jsonEncode(decodedToken));
      String userID = accessTokenModel.id;
      _getCheckInModel = await CheckInService.getCheckIn(userID, accessToken);
    } catch (e) {
      rethrow;
    }
    _isLoading = false;
    notifyListeners();
  }
}
