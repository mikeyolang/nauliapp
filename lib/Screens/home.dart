// Name: Michael Olang
// Email: olangmichael@gmail.com
// phone: +254768241008
// github: @mikeyolang
import 'package:flutter/material.dart';
import 'package:nauliapp/Common/Widgets/drawer.dart';
import 'package:nauliapp/Enums/menu_action.dart';
import 'package:nauliapp/Screens/booking.dart';
import 'package:nauliapp/Screens/login.dart';
import 'package:nauliapp/Screens/profile.dart';
import 'package:nauliapp/Utils/Constants/images.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/Dialogs/log_out_alert.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});
// Creating static data in Lists for the Grid
// List of Services
  static const List serviceName = [
    "Ride",
    "Bus",
    "Car",
  ];
  static const List<Color> serviceColor = [
    Colors.blue,
    Colors.red,
    Colors.green,
  ];
  static const List<Icon> serviceIcon = [
    Icon(
      Icons.directions_car,
      size: 30,
      color: Colors.white,
    ),
    Icon(
      Icons.directions_bus,
      size: 30,
      color: Colors.white,
    ),
    Icon(
      Icons.directions_car,
      size: 30,
      color: Colors.white,
    ),
  ];

  static const List imageList = [
    onboardImageWelcome,
    onboardImageVehicle,
    onboardImageFlex,
    onboardImageSecure,
    nauliLogo,
  ];

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
              bottom: 4,
            ),
            decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.menu,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    PopupMenuButton(onSelected: (value) async {
                      switch (value) {
                        case MenuAction.logout:
                          final shouldLogout = await showLogOutDialog(context);
                          if (shouldLogout) {
                            SharedPreferences sp =
                                await SharedPreferences.getInstance();

                            sp.clear();
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()),
                            );
                          }
                        case MenuAction.profile:
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => const ProfileScreen()),
                          );
                      }
                    }, itemBuilder: (context) {
                      return [
                        const PopupMenuItem<MenuAction>(
                          value: MenuAction.logout,
                          child: Text("Log Out"),
                        ),
                        const PopupMenuItem<MenuAction>(
                          value: MenuAction.profile,
                          child: Text("Profile"),
                        ),
                      ];
                    }),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 1, bottom: 8),
                  child: Text(
                    "Welcome Back",
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1,
                      wordSpacing: 2,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 3, bottom: 5),
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search Here....",
                      hintStyle: TextStyle(
                        color: Colors.black38.withOpacity(.5),
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.black38.withOpacity(.5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
              right: 15,
            ),
            child: GridView.builder(
              itemCount: serviceName.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.1,
              ),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: serviceColor[index],
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: serviceIcon[index],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      serviceName[index],
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.black.withOpacity(.6),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 15,
              right: 15,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Services",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      "See All",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ))
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemCount: 4,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                    bottom: 10,
                    top: 10,
                  ),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.1),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        imageList[index],
                        height: 80,
                        width: 140,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // Creating an elevated Button written Book with us
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const BookingForm(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 82, 219, 3),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Book with us",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      // bottomNavigationBar: const NavBarRoots(),
    );
  }
}
