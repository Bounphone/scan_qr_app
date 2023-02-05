import 'package:flutter_blueprint/models/dynamic_menu/dynamic_menu_model.dart';
import 'package:flutter_blueprint/packages.dart';
import 'package:flutter_blueprint/utils/biometric/biometric_validate.dart';

class HomeVM extends ChangeNotifier {
  AppStatus _appStatus = AppStatus.Loaded;
  String _errMessage = '';
  DynamicMenuModel? _dynamicMenuData;
  List<Panel?> _dynamicMenuPanels = [];

  List<Panel?> get getDynamicMenuPanels => _dynamicMenuPanels;
  String get getErrMessage => _errMessage;
  AppStatus get getAppStatus => _appStatus;
  DynamicMenuModel? get getDynamicMenuData => _dynamicMenuData;

  /// init data
  Future<void> initialData(BuildContext context) async {
    _appStatus = AppStatus.Loading;
    try {
      await Future.wait([fetchDynamicMenu()]);
      bool isUserLogin = await UserValidate.isUserEverLogin();
      bool isLoginWithBio = await AuthLocal.getLocalAuth();
      if (isLoginWithBio && isUserLogin) {
        bool isAuthenticated =
            await BiometricValidate.authenticateWithBiometrics();
        if (!isAuthenticated) {
          await logout();
          Navigator.pushNamed(context, AppRoutes.login);
        }
      }
      _appStatus = AppStatus.Loaded;
    } catch (e) {
      _appStatus = AppStatus.Error;
      _errMessage = AppErrors.errHandling(e);
      rethrow;
    }
    notifyListeners();
  }

  Future<void> fetchDynamicMenu() async {
    try {
      _dynamicMenuData ??= await DynamicMenuService.getVersion(0);
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String version = packageInfo.version;
      for (var i in _dynamicMenuData!.menu!) {
        if (i!.version == version) {
          /// Group id = 0 ແມ່ນ user ທີ່ລັອກອິນ
          /// Group id = 1 ແມ່ນ apple ຫຼື google
          /// Group id = 2 ແມ່ນ user ທີ່ຍັງບໍ່ທັນໄດ້ລັອກອິນ
          bool needReLogin = i.forceReLogin?.needReLogin ?? false;
          String? signature = i.forceReLogin?.signature;
          for (var j in i.groups!) {
            int groupIDUser = await DynamicMenuValidate.validateGroupID(
                needReLogin, signature);
            if (j!.groupId == groupIDUser) {
              _dynamicMenuPanels = j.panels ?? [];
            }
          }
        }
      }
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

  /// On logout
  Future<void> logout() async {
    try {
      bool isLoginWithBio = await AuthLocal.getLocalAuth();
      String? username = await AuthLocal.getUserName();

      /// Clear local storage
      await Future.wait([AuthLocal.clearBox()]);
      await AuthLocal.setLocalAuth(isLoginWithBio);
      await AuthLocal.setUserName(username);
      await fetchDynamicMenu();
    } catch (e) {
      rethrow;
    }
  }
}
