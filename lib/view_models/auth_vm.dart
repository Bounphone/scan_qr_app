import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:scan_qr_app/packages.dart';
import 'package:scan_qr_app/widgets/dialog/dialog_loading.dart';

class AuthVM extends ChangeNotifier {
  String? _accessToken;

  String? get getAccessToken => _accessToken;

  Future<void> onLogin(
      String email, String password, BuildContext context) async {
    try {
      dialogLoading(context);
      AuthModel loginRes = await AuthService.login(email, password);

      /// Set access token to local storage and store it in provider
      final accessToken = loginRes.token;
      await AuthLocalStorage().setAccessToken(accessToken);
      _accessToken = accessToken;
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.dashboard, (route) => false);
    } on DioError catch (e) {
      Navigator.pop(context);
      AwesomeDialog(
          context: context,
          animType: AnimType.scale,
          dialogType: DialogType.warning,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Text(
              e.message ?? 'Error',
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14.sp),
              textAlign: TextAlign.center,
            ),
          ),
          btnOkOnPress: () {})
        ..show();
      rethrow;
    }
    notifyListeners();
  }

  Future<void> onSignUp(String firstname, String surname, String email,
      String password, BuildContext context) async {
    try {
      dialogLoading(context);
      AuthModel loginRes =
          await AuthService.signup(firstname, surname, email, password);

      /// Set access token to local storage and store it in provider
      final accessToken = loginRes.token;
      await AuthLocalStorage().setAccessToken(accessToken);
      _accessToken = accessToken;
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.dashboard, (route) => false);
    } on DioError catch (e) {
      Navigator.pop(context);
      String message = e.message ?? 'Error';
      if (e.response!.statusCode == 401) {
        message = 'ຂໍອະໄພ ບັນຊີຂອງທ່ານມີຢູ່ແລ້ວ';
      }
      AwesomeDialog(
          context: context,
          animType: AnimType.scale,
          dialogType: DialogType.warning,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Text(
              message,
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14.sp),
              textAlign: TextAlign.center,
            ),
          ),
          btnOkOnPress: () {})
        ..show();
      rethrow;
    }
    notifyListeners();
  }

  Future<void> checkValidToken(BuildContext context) async {
    try {
      String? accessToken = await AuthLocalStorage().getAccessToken();
      if (accessToken != null) {
        DateTime? expiryDate = Jwt.getExpiryDate(accessToken);
        if (DateTime.now().isBefore(expiryDate!)) {
          _accessToken = accessToken;
          Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
        }
      } 
    } catch (e) {
      rethrow;
    }
  }
}
