import 'package:scan_qr_app/constants/app_images.dart';
import 'package:scan_qr_app/models/check_in/new_checkin_model.dart';
import 'package:scan_qr_app/packages.dart';

class ScanQRSuccessScreen extends StatelessWidget {
  const ScanQRSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Scan qr success'),
          backgroundColor: AppColors.BASE_COLOR,
          elevation: 0,
          centerTitle: true,
        ),
        body: Consumer<CheckInVM>(builder: (ctx, model, _) {
          if (model.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (model.newCheckInModel == null) {
              return Center(
                child: Text('Error'),
              );
            } else {
              return Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 50.h),
                    child: Image.asset(AppImages.success),
                  ),
                  Column(
                    children: [
                      Center(
                          child: Text('ຂອບໃຈທີ່ໃຫ້ຄວາມຮ່ວມມື',
                              style: TextStyle(
                                  fontSize: 22.sp,
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.w600))),
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 150.h,
                          ),
                          Text(
                            'ທ່ານໄດ້ສະແກນ QR ຂອງ ${model.newCheckInModel!.data.qrId} ແລ້ວ',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 50.h,
                          ),
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(horizontal: 20.w),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, AppRoutes.dashboard);
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: AppColors.BASE_COLOR),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.home),
                                  SizedBox(
                                    width: 30.w,
                                  ),
                                  Text(
                                    'ກັບຄືນສູ່ໜ້າຫຼັກ',
                                    style: TextStyle(fontSize: 16.sp),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ))
                    ],
                  )
                ],
              );
            }
          }
        }));
  }
}
