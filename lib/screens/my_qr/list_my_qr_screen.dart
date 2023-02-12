import 'package:scan_qr_app/packages.dart';

class ListMyQRScreen extends StatelessWidget {
  const ListMyQRScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ລາຍການ QR'),
        backgroundColor: AppColors.BASE_COLOR,
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 15.h),
        child: ListView.separated(
          itemCount: 2,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, AppRoutes.myQR);
              },
              child: Container(
                decoration: BoxDecoration(color: Colors.grey),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Text('New QR'),
              ),
            );
          },
          separatorBuilder: (context, index){
            return Divider(height: 20,);
          },
        ),
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
}
