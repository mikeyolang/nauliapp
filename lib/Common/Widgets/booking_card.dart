import 'package:flutter/material.dart';

class BookingCard extends StatelessWidget {
  final String bookingNumber;
  final String bookingReference;
  final String travelDate;
  final String numberOfSeats;
  final String amount;
  final VoidCallback makePayment;
  final VoidCallback deletePressed;

  const BookingCard({
    super.key,
    required this.bookingNumber,
    required this.bookingReference,
    required this.travelDate,
    required this.numberOfSeats,
    required this.amount,
    required this.makePayment,
    required this.deletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / .2,
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1.0,
            blurRadius: 3.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Booking Number: $bookingNumber',
            style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          Text('Booking Reference: $bookingReference'),
          const SizedBox(height: 8.0),
          Text('Travel Date: $travelDate'),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Number of Seats: $numberOfSeats'),
              Text('Amount: $amount'),
            ],
          ),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: makePayment,
                child: const Text('Pay'),
              ),
              const SizedBox(width: 8.0),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: deletePressed,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
