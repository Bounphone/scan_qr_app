import 'package:flutter_blueprint/constants/app_images.dart';
import 'package:flutter_blueprint/models/setting/setting_list_model.dart';
import 'package:flutter_blueprint/packages.dart';
import 'package:flutter_blueprint/utils/biometric/biometric_validate.dart';

class SettingScreen extends StatefulWidget {
  SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  List<SettingListModel> settingList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      bool isDeviceSupportBiometric = await BiometricValidate.isDeviceSupport();
      if (isDeviceSupportBiometric) {
        setState(() {
          settingList.add(SettingListModel(
              title: 'Local Auth',
              image: AppImages.fingerprint,
              route: AppRoutes.localAuth,
              description:
                  'Lorem Ipsum is simply dummy text of the printing and typesettinLorem Ipsum is simply dummy text of the printing and typesettinLorem Ipsum is simply dummy text of the printing and typesettinLorem Ipsum is simply dummy text of the printing and typesettin'));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
      ),
      body: ListView.separated(
        itemCount: settingList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, settingList[index].route);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Image.asset(
                      settingList[index].image,
                      width: 50.w,
                      height: 50.h,
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          settingList[index].title,
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          settingList[index].description,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 14.sp),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            height: 1.h,
          );
        },
      ),
    );
  }
}
