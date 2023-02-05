import 'packages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await dotenv.load(fileName: "assets/.env");
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<HomeVM>(
              create: (_) => HomeVM()),
          ChangeNotifierProvider<AuthVM>(
              create: (_) => AuthVM()),
        ],
        child: ScreenUtilInit(
          designSize: const Size(375, 861),
          builder: (context, _) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              routes: AppRoutes.getAll(),
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: const HomeScreen(),
            );
          },
        ));
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
