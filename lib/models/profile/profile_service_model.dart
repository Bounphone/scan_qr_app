import 'package:scan_qr_app/packages.dart';

class ProfileServiceModel{
  String title;
  Color iconColor;
  Color backgroundColor;
  IconData icon;
  String routeName;

  ProfileServiceModel({required this.backgroundColor, required this.icon, required this.iconColor, required this.title, required this.routeName});
}