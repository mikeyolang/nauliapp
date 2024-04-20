import 'package:flutter/material.dart';
import 'package:nauliapp/Screens/home.dart';

import 'package:nauliapp/Screens/Onboarding/onboarding_screen.dart';
import 'package:nauliapp/Screens/verification.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nauli App',
      debugShowCheckedModeBanner: false,
      home: HomePageScreen(),
    );
  }
}
