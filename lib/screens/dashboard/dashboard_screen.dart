import 'package:scan_qr_app/packages.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<BottomNavModel> bottomList = [
    BottomNavModel(icon: Icons.home, label: 'Home', widget: HomeScreen()),
    BottomNavModel(
        icon: Icons.person, label: 'Profile', widget: ProfileScreen()),
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      // await context.read<DashboardProvider>().setEmail();
      final cameraPermission = await Permission.camera.status;
      final locationStatus = await Permission.location.status;
      if (cameraPermission.isDenied) {
        await Permission.camera.request();
      }
      if (locationStatus.isDenied) {
        await Permission.location.request();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        body: bottomList[_selectedIndex].widget,
        bottomNavigationBar: BottomNavigationBar(
          items: bottomList
              .map((e) => BottomNavigationBarItem(
                    icon: Icon(e.icon),
                    label: e.label,
                  ))
              .toList(),
          currentIndex: _selectedIndex,
          selectedItemColor: AppColors.BASE_COLOR,
          onTap: _onItemTapped,
        ));
  }
}
