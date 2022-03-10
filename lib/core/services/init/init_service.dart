import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_example_notification_project/core/services/notification/notification_service.dart';
import 'package:get/get.dart';

// ignore: slash_for_doc_comments
/** [InitServices] Servislerin initialize edildiği sınıf.
 * [_getxController] Global olarak her yerden çağırılabilecek olan Controller ın initialize edildiği yer.
 * [_loadServices] Servislerin initialize edilebileceği method.
 * [_fbServices] Firebase servislerinin initialize edildiği method.
 * [NotificationService] Bildirim servisinin initialize edildiği servis.
 * 
 */
class InitServices extends Bindings {

  @override
  Future<void> dependencies() async {
    await _getxController();
    await _fbServices();

    //Timer.run -> Mümkün olan en kısa sürede asenkron olarak methodunuzu 
    //size geri döndürür.
    Timer.run(() =>  _loadServices());
  }


  static Future<void> _fbServices() async {
    await Firebase.initializeApp();
  }

  static Future<void> _getxController() async {

  }

  static Future<void> _loadServices() async {
   NotificationService();
  }

}
