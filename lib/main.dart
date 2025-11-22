import 'package:firebase_app/app.dart';
import 'package:firebase_app/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseService.initialize();
  print('Firebase fcm token is: ${await FirebaseService.getFcmToken()}');
  runApp(const FootballLiveScoreApp());
}
