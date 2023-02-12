import 'package:scan_qr_app/packages.dart';

class AppRoutes {
  static const login = '/login';
  static const signup = '/signup';
  static const forgotPassword = '/forgotPassword';
  static const profile = '/profile';
  static const scanQRHistory = '/scanQRHistory';
  static const scanQR = '/scanQR';
  static const scanQRSuccess = '/scanQRSuccess';
  static const dashboard = '/dashboard';
  static const home = '/home';
  static const createQR = '/createQR';
  static const myQR = '/myQR';
  static const listMyQR = '/listMyQR';

  static Map<String, WidgetBuilder> getAll() => _route;
  static final Map<String, WidgetBuilder> _route = {
    '/login': (context) => LoginScreen(),
    '/signup': (context) => SignUpScreen(),
    '/forgotPassword': (context) => ForgotPasswordScreen(),
    '/profile': (context) => ProfileScreen(),
    '/scanQRHistory': (context) => ScanQRHistoryScreen(),
    '/scanQR': (context) => ScanQRScreen(),
    '/scanQRSuccess': (context) => ScanQRSuccessScreen(),
    '/dashboard': (context) => DashboardScreen(),
    '/home': (context) => HomeScreen(),
    '/createQR': (context) => CreateQRScreen(),
    '/myQR': (context) => MyQRScreen(),
    '/listMyQR': (context) => ListMyQRScreen(),
  };
}
