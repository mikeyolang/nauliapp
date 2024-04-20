import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        Container(
            padding: const EdgeInsets.only(
              top: 10,
              left: 15,
              right: 15,
              bottom: 10,
            ),
            decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: (const Column(
              children: [Row()],
            ))),
      ],
    ));
  }
}
