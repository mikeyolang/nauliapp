// Name: Michael Olang
// Email: olangmichael@gmail.com
// phone: +254768241008
// github: @mikeyolang
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nauliapp/Common/Widgets/build_menu_items.dart';
import 'package:nauliapp/Common/Widgets/nav_root.dart';

import '../Common/Widgets/build_header.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.all(12),
        // padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top,
              ),
              margin: const EdgeInsets.only(bottom: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const NavBarRoots(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      left: 10,
                    ),
                    child: const Text(
                      "My Profile",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            buildHeader(
              context,
              name: "John Doe",
              email: "john@doe.com",
            ),
            // buildMenuItems(
            //   context,
            //   icon: Icons.heat_pump_sharp,
            //   title: "Favorite ",
            //   onTapFunction: () {},
            // ),
          ],
        ),
      ),
    );
  }
}
