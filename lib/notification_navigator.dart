import 'package:firebase_app/NewNavigationScreen.dart';
import 'package:firebase_app/app.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class NotificationNavigator {

  void handleNavigation(String path){
    print(path);
    if(path == '/NavigationScreen'){
      Navigator.push(FootballLiveScoreApp.navigator.currentContext!, MaterialPageRoute(builder: (context) => const NewNavigationScreen())

      );
    }

  }
}