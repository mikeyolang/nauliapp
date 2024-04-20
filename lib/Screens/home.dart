import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:nauliapp/Common/Widgets/nav_root.dart';
import 'package:nauliapp/Utils/Constants/images.dart';

class HomePageScreen extends StatelessWidget {
  HomePageScreen({super.key});
// Creating static data in Lists for the Grid
// List of Services
  final List serviceName = [
    "Ride",
    "Bus",
    "Flight",
    "Train",
    "Hotel",
    "Car",
  ];
  final List<Color> serviceColor = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.pink,
  ];
  final List<Icon> serviceIcon = [
    const Icon(
      Icons.directions_car,
      size: 30,
      color: Colors.white,
    ),
    const Icon(
      Icons.directions_bus,
      size: 30,
      color: Colors.white,
    ),
    const Icon(
      Icons.flight,
      size: 30,
      color: Colors.white,
    ),
    const Icon(
      Icons.train,
      size: 30,
      color: Colors.white,
    ),
    const Icon(
      Icons.hotel,
      size: 30,
      color: Colors.white,
    ),
    const Icon(
      Icons.directions_car,
      size: 30,
      color: Colors.white,
    ),
  ];

  List imageList = [
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
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.menu,
                      size: 30,
                      color: Colors.white,
                    ),
                    Icon(
                      Icons.notifications,
                      size: 30,
                      color: Colors.white,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 1, bottom: 8),
                  child: Text(
                    "Hi Michael",
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
              left: 15,
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
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio:
                  (MediaQuery.of(context).size.height) / (4 * 240),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(.2),
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Image.asset(
                          imageList[index],
                          height: 100,
                          width: 100,
                          scale: 0.5,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        imageList[index],
                        style: TextStyle(
                          color: Colors.black.withOpacity(.5),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
      // bottomNavigationBar: const NavBarRoots(),
    );
  }
}
