// Name: Michael Olang
// Email: olangmichael@gmail.com
// phone: +254768241008

import 'package:flutter/material.dart';
import 'package:nauliapp/Common/Widgets/build_header.dart';
import 'package:nauliapp/Common/Widgets/build_menu_items.dart';
import 'package:nauliapp/Utils/Constants/images.dart';

class CustomNavigationDrawer extends StatelessWidget {
  const CustomNavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      width: MediaQuery.of(context).size.width / 0.25,
      child: Container(
        margin: const EdgeInsets.all(12.0),
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildHeader(
                context,
                name: "John Doe",
                email: "john@doe.com",
              ),
              buildMenuItems(
                context,
                icon: Icons.home_filled,
                title: "Home ",
                onTapFunction: () {},
              ),
              buildMenuItems(
                context,
                icon: Icons.home_filled,
                title: "Bookings ",
                onTapFunction: () {},
              ),
              buildMenuItems(
                context,
                icon: Icons.home_filled,
                title: "Settings",
                onTapFunction: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}




