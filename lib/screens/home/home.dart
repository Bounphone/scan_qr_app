import 'package:flutter_blueprint/packages.dart';
import 'package:flutter_blueprint/widgets/dynamic_menu_panels/image_slide_panel.dart';
import 'package:flutter_blueprint/widgets/dynamic_menu_panels/list_menu_panel.dart';
import 'package:flutter_blueprint/widgets/dynamic_menu_panels/menu_panel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String appVersion = '1.0.0';
  bool isUserLogin = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      /// init data
      await context.read<HomeVM>().initialData(context);
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      bool? isLogin = await UserValidate.isUserEverLogin();
      setState(() {
        appVersion = packageInfo.version;
        isUserLogin = isLogin;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          actions: isUserLogin
              ? [
                  IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.setting);
                      },
                      icon: Icon(Icons.settings)),
                  IconButton(
                      onPressed: () async {
                        await context.read<HomeVM>().logout();
                        bool? isLogin = await UserValidate.isUserEverLogin();
                        setState(() {
                          isUserLogin = isLogin;
                        });
                      },
                      icon: Icon(Icons.logout))
                ]
              : [],
        ),
        body: Consumer<HomeVM>(
          builder: (context, model, _) {
            if (model.getAppStatus == AppStatus.Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (model.getAppStatus == AppStatus.Error) {
              return Center(
                child: Text(model.getErrMessage),
              );
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 100.h),
                    width: double.infinity,
                    decoration: BoxDecoration(color: Colors.blue),
                    child:

                        /// if user ever login it will not show login button
                        isUserLogin
                            ? Text(
                                'App version: $appVersion',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18.sp, color: Colors.white),
                              )
                            : Center(
                                child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, AppRoutes.login);
                                },
                                child: Text(
                                  'Login',
                                  style: TextStyle(fontSize: 14.sp),
                                ),
                              )),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: model.getDynamicMenuPanels.length,
                    itemBuilder: (context, index) {
                      int panelType = model.getDynamicMenuPanels[index]?.type;

                      /// Grid view
                      if (panelType == 0) {
                        return MenuPanel(index: index);
                      } else if (panelType == 1) {
                        return ImageSlidePanel(
                          index: index,
                        );
                      } else if (panelType == 2) {
                        return ListMenuPanel(
                          index: index,
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ],
              ),
            );
          },
        ));
  }
}
