import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:medgo/routes.dart';
import 'package:medgo/services/locator.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  if ((defaultTargetPlatform == TargetPlatform.iOS)) {
  } else {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyAvwecfQ8ThSZ7U2zlGDcKdgwyZn1wJ5Rs",
          authDomain: "medgo-fd1b6.firebaseapp.com",
          projectId: "medgo-fd1b6",
          storageBucket: "medgo-fd1b6.appspot.com",
          messagingSenderId: "209778832898",
          appId: "1:209778832898:web:8df29580ab61b7d4be991b"),
    );

    FirebaseMessaging.instance.getToken().then(print);
  }
// Configure injecction
  await setupLocator();
  runApp(Routes());
}
