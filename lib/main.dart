import 'package:flutter/material.dart';
import 'package:flutter_example_notification_project/core/services/init/init_service.dart';
import 'package:flutter_example_notification_project/screens/home/home_screen.dart';
import 'package:get/get.dart';

/// [InitServices] Initialize işlemlerinin başlatıldığı sınıftır.
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await InitServices().dependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
