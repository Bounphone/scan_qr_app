import 'package:scan_qr_app/local_storage/auth_local_storage.dart';
import 'package:scan_qr_app/models/auth/access_token_model.dart';
import 'package:scan_qr_app/packages.dart';

class AuthVM extends ChangeNotifier {
  AccessTokenModel? _accessTokenModel;

  AccessTokenModel? get getAccessTokenModel => _accessTokenModel;

  Future<void> onLogin(
      String email, String password, BuildContext context) async {
    try {
      AuthModel loginRes = await AuthService.login(email, password);

      /// Set access token to local storage and store it in provider
      final accessToken = loginRes.token;
      await AuthLocalStorage().setAccessToken(accessToken);
      _accessTokenModel = await AuthLocalStorage().getAccessToken();
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.dashboard, (route) => false);
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

  Future<void> onSignUp(String firstname, String surname, String email,
      String password, BuildContext context) async {
    try {
      AuthModel loginRes =
          await AuthService.signup(firstname, surname, email, password);

      /// Set access token to local storage and store it in provider
      final accessToken = loginRes.token;
      await AuthLocalStorage().setAccessToken(accessToken);
      _accessTokenModel = await AuthLocalStorage().getAccessToken();
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.dashboard, (route) => false);
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }
}
