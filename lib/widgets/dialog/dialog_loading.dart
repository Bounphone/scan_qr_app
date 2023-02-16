import 'package:scan_qr_app/packages.dart';

void dialogLoading(BuildContext context) {
  showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.85),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            ],
          ),
        );
      });
}
