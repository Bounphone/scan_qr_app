import 'package:flutter_blueprint/constants/app_images.dart';
import 'package:flutter_blueprint/packages.dart';

class LocalAuthScreen extends StatefulWidget {
  @override
  State<LocalAuthScreen> createState() => _LocalAuthScreenState();
}

class _LocalAuthScreenState extends State<LocalAuthScreen> {
  bool isLoginWithBio = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AuthLocal.getLocalAuth().then((value) {
      setState(() {
        isLoginWithBio = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Local auth'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              Image.asset(
                AppImages.fingerprint,
                width: 80.w,
                height: 80.h,
              ),
              SizedBox(
                height: 30.h,
              ),
              Center(
                child: Text(
                  'ການເຂົ້າສູ່ລະບົບດ້ວຍການສະແກນນິ້ວມື',
                  style: TextStyle(fontSize: 18.sp),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                children: [
                  Checkbox(
                      value: isLoginWithBio,
                      onChanged: (val) async {
                        await AuthLocal.setLocalAuth(val ?? false);
                        bool localAuthVal = await AuthLocal.getLocalAuth();
                        setState(() {
                          isLoginWithBio = localAuthVal;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            'ບັນທຶກການປ່ຽນແປງສຳເລັດ',
                            style: TextStyle(fontSize: 14.sp),
                          ),
                        ));
                      }),
                  SizedBox(
                    width: 15.w,
                  ),
                  Expanded(child: Text('ເຂົ້າສູ່ລະບົບດ້ວຍການສະແກນນິ້ວມື'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
