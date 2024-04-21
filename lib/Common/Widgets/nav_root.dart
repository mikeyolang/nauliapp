import 'package:flutter/material.dart';
import 'package:nauliapp/Screens/booking.dart';
import 'package:nauliapp/Screens/booking_table.dart';
import 'package:nauliapp/Screens/home.dart';

class NavBarRoots extends StatefulWidget {
  const NavBarRoots({super.key});

  @override
  State<NavBarRoots> createState() => _NavBarRootsState();
}

class _NavBarRootsState extends State<NavBarRoots> {
  int _selectIndex = 0;
  final _screens = [
    //Home Screen
    const HomePageScreen(),
    //  Bookings Screen
    const BookingTable()
    //  Profile Screen

    //  Settings screen
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _screens[_selectIndex],
      bottomNavigationBar: SizedBox(
        height: 80,
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.black,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          currentIndex: _selectIndex,
          onTap: (index) {
            setState(() {
              _selectIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: "Home",
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_outlined),
              label: "Schedules",
            ),

            // BottomNavigationBarItem(Icon(Icons.people), label: "Community")
            BottomNavigationBarItem(
              icon: Icon(Icons.help),
              label: "Help",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_2_rounded),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
