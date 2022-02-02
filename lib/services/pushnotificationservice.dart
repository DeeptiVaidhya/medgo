import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_messaging_web/firebase_messaging_web.dart';
import 'package:flutter/cupertino.dart';

class PushNotificationService extends ChangeNotifier {
  static PushNotificationService _instance =
      new PushNotificationService.internal();
  factory PushNotificationService() => _instance;
  PushNotificationService.internal();

  Future initialise(BuildContext context) async {
    await FirebaseMessaging.instance.getInitialMessage();
  }
}
