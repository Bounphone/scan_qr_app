import 'package:scan_qr_app/packages.dart';

class BottomNavModel {
  String label;
  IconData icon;
  Widget widget;

  BottomNavModel(
      {required this.icon, required this.label, required this.widget});
}
