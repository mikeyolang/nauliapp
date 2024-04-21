import 'package:flutter/material.dart';


class BookingTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Details'),
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
          rows: const <DataRow>[
            DataRow(
              cells: <DataCell>[
                DataCell(Text('BK001')),
                DataCell(Text('John Doe')),
                DataCell(Text('2024-04-20')),
                DataCell(Text('2')),
                DataCell(Text('\$100')),
                DataCell(Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // Edit action
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
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
