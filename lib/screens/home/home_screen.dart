import 'package:flutter/material.dart';
import 'package:flutter_example_notification_project/screens/home/controller/home_controller.dart';
import 'package:flutter_example_notification_project/screens/home/view/home_view_model.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HomeController(),
      builder: (_)=> const HomeViewModel());
  }
}