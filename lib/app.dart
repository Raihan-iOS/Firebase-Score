import 'package:firebase_app/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StudentInfoApp extends StatefulWidget {
  const StudentInfoApp({super.key});

  @override
  State<StudentInfoApp> createState() => _StudentInfoAppState();
}

class _StudentInfoAppState extends State<StudentInfoApp> {
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
            return const HomeScreen();
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
