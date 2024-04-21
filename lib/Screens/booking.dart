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
  String _from = 'Choose From';
  String _to = 'Choose To';
  // final String _pickUpLocation = 'Office';
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      locale: const Locale('en', 'US'),
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
        title: const Text(
          'Reserve Your Seat',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Radio(
                    value: "Self",
                    groupValue: "",
                    onChanged: (value) => {},
                  ),
                  const Text("Self"),
                  Radio(
                    value: "Other",
                    groupValue: "",
                    onChanged: (value) => {},
                  ),
                  const Text("Other"),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(left: 12, right: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: ListTile(
                  title: Text(
                    'Travel Date: ${DateFormat("dd/MM/yyyy").format(selectedDate)}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  trailing: const Icon(
                    Icons.calendar_today_outlined,
                    size: 20,
                  ),
                  onTap: () => _selectDate(context),
                ),
              ),
               Container(
                padding: const EdgeInsets.only(left: 12),
                margin: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextFormField(
                  controller: _departureController,
                  decoration: const InputDecoration(
                    hintText: "",
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter departure location';
                    }
                    return null;
                  },
                ),
              ),
              DropdownButtonFormField(
                hint: const Text('From'),
                value: _from,
                items: ['Choose From', 'Item 1', 'Item 2', 'Item 3']
                    .map((value) => DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        ))
                    .toList(),
                onChanged: (newValue) => setState(() => _from = newValue!),
              ),
              DropdownButtonFormField(
                hint: const Text('To'),
                value: _to,
                items: ['Choose To', 'Item 1', 'Item 2', 'Item 3']
                    .map((value) => DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        ))
                    .toList(),
                onChanged: (newValue) => setState(() => _to = newValue!),
              ),
              TextFormField(
                controller: _costController,
                decoration: const InputDecoration(
                  labelText: 'Cost per Seat',
                ),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _seatsController,
                decoration: const InputDecoration(
                  labelText: 'Seats Reserved',
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
              const Text(
                "Pick up Location must be along the way. By default passengers board at the office",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                ),
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
