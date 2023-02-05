import 'package:flutter_blueprint/packages.dart';
import 'package:flutter_blueprint/widgets/dialog/app_dialog.dart';
import 'package:jwt_decode/jwt_decode.dart';

class AuthVM extends ChangeNotifier {
  bool _isLoading = false;
  AuthorizeUserModel? _validate;
  int _isRefreshingToken = 0;

  bool get getIsLoading => _isLoading;
  AuthorizeUserModel? get getValidate => _validate;

  /// ເມື່ອ user ປ້ອນເບີໂທລະສັບແລ້ວເຮົາຕ້ອງການກວດວ່າເບີລູກຄ້າມີຢູ່ໃນລະບົບ ຫຼື ບໍ?
  Future<void> validateUser(String username) async {
    _isLoading = true;
    try {
      _validate = await ConnectService.authorize(username, 0, false);
    } catch (e) {
      rethrow;
    }
    _isLoading = false;
    notifyListeners();
  }

  /// ຂໍ OTP
  Future<void> reqOTP(String username) async {
    _isLoading = true;
    try {
      await ConnectService.authorize(username, 0, true);
    } catch (e) {
      rethrow;
    }
    _isLoading = false;
    notifyListeners();
  }

  // ໃຊ້ໃນການຢືນຢັນ OTP ແລະ ຂໍ Token
  Future<void> reqToken(
      String username, String password, BuildContext context) async {
    try {
      final res = await ConnectService.reqToken(username, password, 0);
      await AuthLocal.setUserName(username);
      await AuthLocal.setTokenData(res!);
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.home, (route) => false);
    } catch (e) {
      String message = e.toString() == 'invalid_grant'
          ? 'ກະລຸນາປ້ອນລະຫັດຜ່ານໃຫ້ຖືກຕ້ອງ'
          : 'ເກີດຂໍ້ຜິດພາດ';
      showDialog(
          context: (context),
          builder: (_) {
            return AppDialog(message: message);
          });
      rethrow;
    }
    notifyListeners();
  }

  /// ແມ່ນຟັງຊັ່ນທີ່ໃຊ້ໃນການກວດສອບວ່າ Access token ໝົດອາຍຸຫຼືບໍ? ຖ້າຫາກໝົດອາຍຸແມ່ນໃຫ້ເອົາ refreshToken ໄປຂໍ Token ໃໝ່
  Future<TokenModel?> tokenManagement(BuildContext context) async {
    try {
      TokenModel? connectToken = await AuthLocal.getTokenData();
      String accessToken = connectToken!.accessToken.toString();

      /// ກວດ Expired Date ຂອງ Access token
      DateTime expireTokenTime = Jwt.getExpiryDate(accessToken)!.toLocal();

      /// ຖ້າ Access token ໝົດອາຍຸ
      if (DateTime.now()
          .add(const Duration(minutes: 5))
          .isAfter(expireTokenTime)) {
        /// ໃຊ້ເພື່ອໃຫ້ refresh token ໄດ້ແຕ່ເທື່ອດຽວ
        _isRefreshingToken++;
        if (_isRefreshingToken == 1) {
          String refreshToken = connectToken.refreshToken ?? '';
          TokenModel? connectRefreshTokenData =
              await ConnectService.refreshAccessToken(0, refreshToken);
          _isRefreshingToken = 0;
          await AuthLocal.setTokenData(connectRefreshTokenData!);
          return connectRefreshTokenData;
        }
      }

      /// ຖ້າ Access token ບໍ່ໝົດອາຍຸ
      else {
        return connectToken;
      }
    } catch (e) {
      Navigator.pushReplacementNamed(context, AppRoutes.login);
      rethrow;
    }

    notifyListeners();
  }
}
