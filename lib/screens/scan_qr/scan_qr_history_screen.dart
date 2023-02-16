import 'package:scan_qr_app/packages.dart';
import 'package:scan_qr_app/models/check_in/get_checkin_model.dart' as check_in;

class ScanQRHistoryScreen extends StatelessWidget {
  const ScanQRHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CheckInVM>().getCheckIn(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('ປະຫວັດການເຊັກອີນ'),
        backgroundColor: AppColors.BASE_COLOR,
        elevation: 0,
      ),
      body: Consumer<CheckInVM>(
        builder: (context, model, _) {
          if (model.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (model.getCheckInModel == null) {
              return Text(
                'ເກີດຂໍ້ຜິດພາດ',
                style: TextStyle(fontSize: 14.sp),
              );
            } else {
              return Padding(
                padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 15.h),
                child: ListView.separated(
                  itemCount: model.getCheckInModel!.data.length,
                  itemBuilder: (context, index) {
                    check_in.Data data = model.getCheckInModel!.data[index];

                    String id = data.id;
                    String qrID = data.qrId;
                    String createdDate = DateFormat('yyyy-MM-dd HH:mm:ss')
                        .format(data.checkInDate);
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 10.h),
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 10.h),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 2.w),
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Column(
                        children: [
                          menu('ໄອດີ', id),
                          menu('ໄອດີ QR', qrID),
                          menu('ເຊັກອີນເມື່ອ', createdDate),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      height: 5.h,
                    );
                  },
                ),
              );
            }
          }
        },
      ),
    );
  }

  Row menu(String title, String value) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(fontSize: 14.sp),
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: TextStyle(fontSize: 14.sp),
          ),
        ),
      ],
    );
  }
}
