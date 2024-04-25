import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:nauliapp/Features/Authentication/auth_service.dart';

class BookingTable extends StatelessWidget {
  const BookingTable({super.key});

  // Future<List<Map<String, dynamic>>> _fetchBookings() async {
  //   const String bearerToken =
  //       '76|hW4NzC9gPzCqOBmT1Fq4pj4CdlHIhgqc0pZPUBok5d081b4f';
  //   const String apiUrl = 'https://booking.nauli.co.ke/api/v1/bookings';

  //   try {
  //     final response = await http.get(
  //       Uri.parse(apiUrl),
  //       headers: <String, String>{
  //         'Authorization': 'Bearer $bearerToken',
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       Map<String, dynamic> jsonResponse = json.decode(response.body);
  //       List<dynamic> bookingsData = jsonResponse['bookings']['data'];

  //       List<Map<String, dynamic>> bookingsList = [];
  //       for (var booking in bookingsData) {
  //         Map<String, dynamic> bookingInfo = {
  //           'id': booking['id'],
  //           'number': booking['id'],
  //           'reference': booking['reference_no'],
  //           'travelDate': booking['travel_date'],
  //           'seats': booking['seats'],
  //           'amount': booking['amount'],
  //         };
  //         bookingsList.add(bookingInfo);
  //       }

  //       return bookingsList;
  //     } else {
  //       throw Exception('Failed to load bookings');
  //     }
  //   } catch (e) {
  //     throw Exception('Error: $e');
  //   }
  // }

  // Future<void> _makePayment(int bookingId) async {
  //   const String bearerToken =
  //       '76|hW4NzC9gPzCqOBmT1Fq4pj4CdlHIhgqc0pZPUBok5d081b4f';
  //   final String apiUrl =
  //       'https://booking.nauli.co.ke/api/v1/make_payment/$bookingId';

  //   try {
  //     final response = await http.get(
  //       Uri.parse(apiUrl),
  //       headers: <String, String>{
  //         'Authorization': 'Bearer $bearerToken',
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       // Payment successful, handle response accordingly
  //       print('Payment successful');
  //     } else {
  //       throw Exception('Failed to make payment');
  //     }
  //   } catch (e) {
  //     throw Exception('Error: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final AuthService authservice = AuthService();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Bookings'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: authservice.fetchBookings(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No bookings available'));
          } else {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Number')),
                  DataColumn(label: Text('Booking Reference')),
                  DataColumn(label: Text('Travel Date')),
                  DataColumn(label: Text('Number of Seats')),
                  DataColumn(label: Text('Amount')),
                  DataColumn(label: Text('Actions')),
                ],
                rows: snapshot.data!.map((booking) {
                  return DataRow(cells: [
                    DataCell(Text(booking['number'].toString())),
                    DataCell(Text(booking['reference'])),
                    DataCell(Text(booking['travelDate'])),
                    DataCell(Text(booking['seats'].toString())),
                    DataCell(Text(booking['amount'])),
                    DataCell(Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            authservice.makePayment(
                              booking['id'],
                            );
                            print(
                              booking["id"],
                            ); // Call make payment with booking ID
                          },
                          child: const Text('Pay'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            // Implement delete functionality
                          },
                          style: ElevatedButton.styleFrom(),
                          child: const Icon(Icons.delete),
                        ),
                      ],
                    )),
                  ]);
                }).toList(),
              ),
            );
          }
        },
      ),
    );
  }
}
