import 'package:flutter/services.dart';
import 'package:scan_qr_app/models/myQR/my_qr_arg.dart';
import 'package:scan_qr_app/packages.dart';

class MyQRScreen extends StatelessWidget {
  MyQRScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as MyQRArg;
    String name = args.name;
    String qrCode = args.qrCode;
    String qrId = args.id;
    String code = '$qrCode/$qrId';
    return Scaffold(
      appBar: AppBar(
        title: Text('My QR Code'),
        backgroundColor: AppColors.BASE_COLOR,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 60.h,
              ),
              Center(
                child: Text(
                  name,
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 60.h,
              ),
              QrImage(
                data: code,
                version: QrVersions.auto,
                size: MediaQuery.of(context).size.width * 0.7,
              ),
              SizedBox(
                height: 80.h,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        vertical: 15.h,
                      ),
                      backgroundColor: AppColors.BASE_COLOR,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.r))),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: code));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.copy,
                        size: 20.sp,
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      Text(
                        'Copy QR Code',
                        style: TextStyle(fontSize: 13.sp),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
