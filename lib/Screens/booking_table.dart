import 'package:flutter/material.dart';

class BookingTable extends StatelessWidget {
  const BookingTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Details'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const <DataColumn>[
            DataColumn(label: Text('Booking ID')),
            DataColumn(label: Text('Customer Name')),
            DataColumn(label: Text('Date')),
            DataColumn(label: Text('Seats')),
            DataColumn(label: Text('Total Cost')),
            DataColumn(label: Text('Actions')),
          ],
          rows: <DataRow>[
            DataRow(
              cells: <DataCell>[
                const DataCell(Text('BK001')),
                const DataCell(Text('John Doe')),
                const DataCell(Text('2024-04-20')),
                const DataCell(Text('2')),
                const DataCell(Text('\$100')),
                DataCell(Row(
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        // Edit action
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        // Delete action
                      },
                    ),
                  ],
                )),
              ],
            ),
            // More DataRows can be added here
          ],
        ),
      ),
    );
  }
}
