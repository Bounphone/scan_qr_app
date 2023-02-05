import 'package:flutter_blueprint/packages.dart';
import 'package:permission_handler/permission_handler.dart';

class DynamicMenuValidate {
  static Future<int> validateGroupID(
      bool needReLogin, String? signature) async {
    String localSignature = await AuthLocal.getSignatureData() ?? '';
    if (needReLogin && localSignature != signature) {
      return 2;
    } else {
      bool everLogin = await UserValidate.isUserEverLogin();

      if (everLogin) {
        return 0;
      } else {
        return 2;
      }
    }
  }

  /// ເມື່ອເລືອກ panel
  static Future<void> onPressedPanel(
      int type, BuildContext context, String url, String title) async {
    try {
      if (type == 0) {
        Navigator.pushNamed(context, url);
      } else if (type == 1) {
        TokenModel? tokenModel =
            await context.read<AuthVM>().tokenManagement(context);
        String? phoneNumber = tokenModel!.username;
        String accessToken = tokenModel.accessToken ?? '';
        var positionStatus = await Permission.location.status;
        String? deviceID = await DeviceInfoUtils.getDeviceID();

        String rpPhoneNumberURL =
            url.replaceAll(r'$phoneNumber', phoneNumber.toString());
        String rpAccessTokenURL = '';
        String rpLatURL = '';
        String rpLongURL = '';

        if (tokenModel != null) {
          rpAccessTokenURL = rpPhoneNumberURL.replaceAll(
              r'$accessToken', tokenModel.accessToken.toString());
        } else {
          rpAccessTokenURL = rpPhoneNumberURL;
        }

        if (positionStatus == Permission.location.isGranted) {
          Position position = await Geolocator.getCurrentPosition();
          rpLatURL = rpAccessTokenURL.replaceAll(
              r'$latitude', position.latitude.toString());
          rpLongURL = rpLatURL.replaceAll(
              r'$longtitude', position.longitude.toString());
        } else {
          rpLatURL = rpAccessTokenURL.replaceAll(r'$latitude', '0');
          rpLongURL = rpLatURL.replaceAll(r'$longtitude', '0');
        }
        String rpDeviceIDUrl =
            rpLongURL.replaceAll(r'$deviceID', deviceID.toString());
        String urlWebView = rpDeviceIDUrl;
        if (urlWebView.isNotEmpty) {
          Navigator.pushNamed(context, AppRoutes.webview,
              arguments: WebViewArg(url: urlWebView, accessToken: accessToken));
        }
      } else if (type == 2) {
        TokenModel? tokenModel =
            await context.read<AuthVM>().tokenManagement(context);
        String? phoneNumber = tokenModel!.username;
        var positionStatus = await Permission.location.status;
        String? deviceID = await DeviceInfoUtils.getDeviceID();

        String rpPhoneNumberURL =
            url.replaceAll(r'$phoneNumber', phoneNumber.toString());
        String rpAccessTokenURL = '';
        String rpLatURL = '';
        String rpLongURL = '';

        if (tokenModel != null) {
          rpAccessTokenURL = rpPhoneNumberURL.replaceAll(
              r'$accessToken', tokenModel.accessToken.toString());
        } else {
          rpAccessTokenURL = rpPhoneNumberURL;
        }

        if (positionStatus == Permission.location.isGranted) {
          Position position = await Geolocator.getCurrentPosition();
          rpLatURL = rpAccessTokenURL.replaceAll(
              r'$latitude', position.latitude.toString());
          rpLongURL = rpLatURL.replaceAll(
              r'$longtitude', position.longitude.toString());
        } else {
          rpLatURL = rpAccessTokenURL.replaceAll(r'$latitude', '0');
          rpLongURL = rpLatURL.replaceAll(r'$longtitude', '0');
        }

        String rpDeviceIDUrl =
            rpLongURL.replaceAll(r'$deviceID', deviceID.toString());
        String urlLauncher = rpDeviceIDUrl;
        if (urlLauncher.isNotEmpty) {
          if (await canLaunch(urlLauncher)) {
            await launch(urlLauncher);
          } else {
            SnackBar(
              content: Text('Url connot lauch $urlLauncher'),
            );
          }
        }
      } else if (type == 3) {
        SnackBar(
          content: Text(title),
        );
      } else if (type == 4) {
        Navigator.pushNamed(context, url);
      } else {
        SnackBar(
          content: Text('Navigator type: $type, Url: $url'),
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
