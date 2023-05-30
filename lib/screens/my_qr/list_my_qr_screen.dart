import 'package:scan_qr_app/models/myQR/my_qr_arg.dart';
import 'package:scan_qr_app/packages.dart';

class ListMyQRScreen extends StatefulWidget {
  const ListMyQRScreen({super.key});

  @override
  State<ListMyQRScreen> createState() => _ListMyQRScreenState();
}

class _ListMyQRScreenState extends State<ListMyQRScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<MyQRVM>().getMyQR(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ລາຍການ QR'),
        backgroundColor: AppColors.BASE_COLOR,
        centerTitle: true,
        elevation: 0,
      ),
      body: Consumer<MyQRVM>(
        builder: (context, model, _) {
          if (model.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (model.getMyQrModel == null) {
              return Text(
                'ເກີດຂໍ້ຜິດພາດ',
                style: TextStyle(fontSize: 14.sp),
              );
            } else {
              if (model.getMyQrModel!.data.length < 1) {
                return Center(
                  child: Text(
                    'ບໍ່ພົບລາຍການ QR ຂອງທ່ານ',
                    style: TextStyle(fontSize: 14.sp),
                  ),
                );
              }
              return Padding(
                padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 15.h),
                child: ListView.separated(
                  itemCount: model.getMyQrModel!.data.length,
                  itemBuilder: (context, index) {
                    Datum data = model.getMyQrModel!.data[index];
                    String qrName = data.name;
                    String qrCode = data.qrCode;
                    String qrID = data.id;
                    String createdDate = DateFormat('yyyy-MM-dd HH:mm:ss')
                        .format(data.createdAt);
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.myQR,
                            arguments: MyQRArg(name: qrName, qrCode: qrCode, id: qrID));
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10.h),
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 10.h),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 2.w),
                            borderRadius: BorderRadius.circular(10.r)),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  menu('ໄອດີ', qrID),
                                  menu('ຊື່ QR', qrName),
                                  menu('ສ້າງເມື່ອ', createdDate),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.arrow_right,
                              size: (25.w + 25.h) / 2,
                            )
                          ],
                        ),
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
      bottomNavigationBar: Container(
          height: 60.h,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.BASE_COLOR,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0))),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.createQR);
            },
            child: Text('ສ້າງ QR'),
          )),
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
          flex: 4,
          child: Text(
            value,
            style: TextStyle(fontSize: 14.sp),
          ),
        ),
      ],
    );
  }
}
