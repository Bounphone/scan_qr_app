import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:scan_qr_app/packages.dart';

class HomeScreen extends StatelessWidget {
  List<AppServiceModel> appService = [
    AppServiceModel(
        icon: Icons.document_scanner_sharp,
        routeName: AppRoutes.scanQR,
        title: 'Check In'),
    AppServiceModel(
        icon: Icons.qr_code, routeName: AppRoutes.listMyQR, title: 'My QR'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ໜ້າຫຼັກ'),
        backgroundColor: AppColors.BASE_COLOR,
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () async {
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
              icon: Icon(
                Icons.logout,
                color: AppColors.LIGHT_COLOR,
              ))
        ],
      ),
      // backgroundColor: AppColors.BASE_COLOR,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
                decoration: BoxDecoration(
                    color: AppColors.LIGHT_COLOR,
                    borderRadius: BorderRadius.circular(10.r)),
                child: GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    children: appService
                        .map((e) => GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, e.routeName);
                              },
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.r)),
                                    child: Icon(
                                      e.icon,
                                      color: Colors.orange,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  Text(
                                    e.title,
                                    style: TextStyle(fontSize: 12.sp),
                                  )
                                ],
                              ),
                            ))
                        .toList()),
              ),
              SizedBox(
                height: 12.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
