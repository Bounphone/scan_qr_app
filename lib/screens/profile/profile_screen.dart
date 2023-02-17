import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:scan_qr_app/models/auth/access_token_model.dart';
import 'package:scan_qr_app/packages.dart';
import 'package:scan_qr_app/view_models/auth_vm.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  List<ProfileServiceModel> profileService = [
    ProfileServiceModel(
        backgroundColor: Color(0xFFfeedde),
        icon: Icons.qr_code,
        iconColor: Color(0xFFff6c03),
        title: 'My QR',
        routeName: AppRoutes.listMyQR)
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthVM>(builder: (context, model, _) {
      String accessToken = model.getAccessToken ?? '';
      Map<String, dynamic> decodedToken = Jwt.parseJwt(accessToken);
      AccessTokenModel accessTokenModel =
          accessTokenModelFromJson(jsonEncode(decodedToken));
      return Scaffold(
        appBar: AppBar(
          title: Text('ຂໍ້ມູນສ່ວນບຸກຄົນ'),
          backgroundColor: AppColors.BASE_COLOR,
          centerTitle: true,
          elevation: 0,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Center(
                    child: Text(
                  '${accessTokenModel.firstname} ${accessTokenModel.surname}',
                  style:
                      TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w600),
                )),
                SizedBox(
                  height: 8.h,
                ),
                Center(
                  child: Text(
                    accessTokenModel.email,
                    style: TextStyle(fontSize: 18.sp, color: Colors.grey),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                for (var i in profileService)
                  ProfileMenu(
                    title: i.title,
                    iconColor: i.iconColor,
                    background: i.backgroundColor,
                    icons: i.icon,
                    onPressed: () {
                      Navigator.pushNamed(context, i.routeName);
                    },
                  ),
                SizedBox(
                  height: 70.h,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r)),
                    primary: Color(0xFFf4f5f6),
                  ),
                  onPressed: () {
                    AwesomeDialog(
                        context: context,
                        animType: AnimType.scale,
                        dialogType: DialogType.question,
                        body: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: Text(
                            'ທ່ານຕ້ອງການອອກຈາກລະບົບບໍ?',
                            style: TextStyle(
                                fontStyle: FontStyle.italic, fontSize: 14.sp),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        btnOkOnPress: () async {
                          await context.read<AuthVM>().onLogout();
                          Navigator.pushNamedAndRemoveUntil(
                              context, AppRoutes.login, (route) => false);
                        },
                        btnCancelOnPress: () {})
                      ..show();
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.logout,
                        color: Color(0xFFff6c03),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Text(
                        'ອອກຈາກລະບົບ',
                        style: TextStyle(fontSize: 14.sp, color: Colors.black),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
