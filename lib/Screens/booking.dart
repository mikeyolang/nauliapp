// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingForm extends StatefulWidget {
  const BookingForm({super.key});

  @override
  _BookingFormState createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay departureTime = TimeOfDay.now();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _departureController = TextEditingController();
  final TextEditingController _arrivalController = TextEditingController();
  final TextEditingController _costController = TextEditingController();
  final TextEditingController _seatsController = TextEditingController();
  final TextEditingController _pickUpController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != selectedDate) {
      setState(() {
        selectedDate = picked!;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: departureTime,
    );
    if (picked != departureTime) {
      setState(() {
        departureTime = picked!;
      });
    }
  }

  @override
  void dispose() {
    _departureController.dispose();
    _arrivalController.dispose();
    _costController.dispose();
    _seatsController.dispose();
    _pickUpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reserve Your Seat'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _departureController,
                decoration: const InputDecoration(
                  labelText: 'Departure',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter departure location';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _arrivalController,
                decoration: const InputDecoration(
                  labelText: 'Arrival',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter arrival location';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _costController,
                decoration: const InputDecoration(
                  labelText: 'Cost per Seat',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter cost per seat';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _seatsController,
                decoration: const InputDecoration(
                  labelText: 'Number of Seats',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter number of seats';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _pickUpController,
                decoration: const InputDecoration(
                  labelText: 'Pick-Up Location',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter pick-up location';
                  }
                  return null;
                },
              ),
              ListTile(
                title: Text(
                    'Travel Date: ${DateFormat.yMd().format(selectedDate)}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _selectDate(context),
              ),
              ListTile(
                title: Text('Departure Time: ${departureTime.format(context)}'),
                trailing: const Icon(Icons.access_time),
                onTap: () => _selectTime(context),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Process data
                    print('Booking Details:');
                    print('Departure: ${_departureController.text}');
                    print('Arrival: ${_arrivalController.text}');
                    print('Cost per Seat: ${_costController.text}');
                    print('Number of Seats: ${_seatsController.text}');
                    print('Pick-Up Location: ${_pickUpController.text}');
                    print(
                        'Travel Date: ${DateFormat.yMd().format(selectedDate)}');
                    print('Departure Time: ${departureTime.format(context)}');
                    // Here you can add your code to handle the booking data
                  }
                },
                child: const Text('Book Now'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
