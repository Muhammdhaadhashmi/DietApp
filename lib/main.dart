import 'package:diet/splash_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'DashboardScreen/remider_screen.dart';
import 'Utils/local_notification_service.dart';


Future<void> backgroundHandler(title,message,paylod) async {
  await LocalNotifications().init();
  LocalNotifications().notification(title,
      message, paylod);
}
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await LocalNotifications().init();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashView(),
      // home: SplashView(),
    );
  }
}



