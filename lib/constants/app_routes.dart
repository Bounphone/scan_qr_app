import 'package:flutter_blueprint/packages.dart';
import 'package:flutter_blueprint/screens/settings/local_auth_screen.dart';
import 'package:flutter_blueprint/screens/webview/webview.dart';

class AppRoutes {
  static const home = '/home';
  static const login = '/login';
  static const confirmOTP = '/confirmOTP';
  static const setting = '/setting';
  static const localAuth = '/localAuth';
  static const webview = '/webview';

  static Map<String, WidgetBuilder> getAll() => _route;
  static final Map<String, WidgetBuilder> _route = {
    '/home': (context) => const HomeScreen(),
    '/login': (context) => LoginScreen(),
    '/confirmOTP': (context) => ConfirmOTPScreen(),
    '/setting': (context) => SettingScreen(),
    '/localAuth': (context) => LocalAuthScreen(),
    '/webview': (context) => WebViewScreen(),
  };
}
