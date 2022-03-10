import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class HomeController extends GetxController{

  RemoteMessage? fbRemoteMessage;
  late RxString inComingMessage;

  HomeController(){
    fbRemoteMessage = const RemoteMessage();
    inComingMessage = ''.obs;
  }

  
  
}