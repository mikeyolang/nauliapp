import 'package:flutter/material.dart';



class BookingTable extends StatelessWidget {
  final List<Map<String, dynamic>> bookings = [
    {
      'number': 1,
      'reference': 'BR123',
      'travelDate': '2024-05-01',
      'seats': 2,
    },
    // Add more bookings here
  ];

   BookingTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Bookings'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Number')),
            DataColumn(label: Text('Booking Reference')),
            DataColumn(label: Text('Travel Date')),
            DataColumn(label: Text('Number of Seats')),
            DataColumn(label: Text('Actions')),
          ],
          rows: bookings.map((booking) {
            return DataRow(cells: [
              DataCell(Text(booking['number'].toString())),
              DataCell(Text(booking['reference'])),
              DataCell(Text(booking['travelDate'])),
              DataCell(Text(booking['seats'].toString())),
              DataCell(Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Implement payment functionality
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
      ),
    );
  }
}
