import 'package:firebase_app/home_screen.dart';
import 'package:firebase_app/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FootballLiveScoreApp extends StatefulWidget {
  const FootballLiveScoreApp({super.key});

  @override
  State<FootballLiveScoreApp> createState() => _FootballLiveScoreAppState();
}

class _FootballLiveScoreAppState extends State<FootballLiveScoreApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading...");
          }

          if (!snapshot.hasData) {
            return const SignInScreen();
          }else{
            return const HomeScreen();
          }

          // final user = snapshot.data!;
          // return HomeScreen(userId: user.uid);
        },
      )

    );
  }
}
