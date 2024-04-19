import 'package:flutter/material.dart';

import 'package:nauliapp/Screens/Onboarding/onboarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Nauli App',
      debugShowCheckedModeBanner: false,
      home: OnboardingScreen(),
    );
  }
}
