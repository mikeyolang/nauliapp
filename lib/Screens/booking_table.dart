import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nauliapp/Common/Widgets/booking_card.dart';
import 'package:nauliapp/Common/Widgets/nav_root.dart';
import 'dart:convert';
import 'package:nauliapp/Features/Authentication/auth_service.dart';

class BookingTable extends StatefulWidget {
  const BookingTable({super.key});

  @override
  State<BookingTable> createState() => _BookingTableState();
}

class _BookingTableState extends State<BookingTable> {
  @override
  void initState() {
    AuthService().fetchAllBookings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AuthService authservice = AuthService();
    return Scaffold(
        appBar: AppBar(
          title: const Text("Your Bookings"),
          backgroundColor: Colors.blue,
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const NavBarRoots();
                  },
                ),
              );
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(),
          child: Column(
            children: [
              FutureBuilder<List<Map<String, dynamic>>>(
                future: authservice.fetchAllBookings(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No bookings available'));
                  } else {
                    return SingleChildScrollView(
                      child: Column(
                        children: snapshot.data!
                            .map((booking) => BookingCard(
                                  bookingNumber: booking['number'].toString(),
                                  bookingReference: booking['reference'],
                                  travelDate: booking['travelDate'],
                                  numberOfSeats: booking['seats'].toString(),
                                  amount: booking['amount'],
                                  makePayment: () =>
                                      authservice.makePayment(booking['id']),
                                  // Implement delete functionality on deletePressed
                                  deletePressed: () {},
                                ))
                            .toList(),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ));
  }
}
