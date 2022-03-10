import 'package:flutter/material.dart';
import 'package:flutter_example_notification_project/screens/home/controller/home_controller.dart';
import 'package:get/get.dart';


class HomeViewModel extends GetView<HomeController> {
  const HomeViewModel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: Get.height,
        width: Get.width,
        child: const Center(
          child: Text('Home Screen'),
        ),
      ),
    );
  }
}