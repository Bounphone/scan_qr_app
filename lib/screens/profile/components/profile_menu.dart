import 'package:scan_qr_app/packages.dart';

class ProfileMenu extends StatelessWidget {
  String title;
  IconData icons;
  Color background;
  Color iconColor;
  VoidCallback onPressed;

  ProfileMenu(
      {required this.title,
      required this.iconColor,
      required this.background,
      required this.icons,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: background, shape: BoxShape.circle),
                    padding: EdgeInsets.all(7),
                    child: Icon(
                      icons,
                      color: iconColor,
                    ),
                  ),
                  SizedBox(
                    width: 25.w,
                  ),
                  Text(
                    title,
                    style: TextStyle(fontSize: 18.sp),
                  )
                ],
              ),
              Container()
            ],
          ),
        ),
        SizedBox(
          height: 15.h,
        )
      ],
    );
  }
}
