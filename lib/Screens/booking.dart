// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nauliapp/Screens/booking_table.dart';

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
        actions: const [],
        elevation: 5,
        backgroundColor: Colors.blue,
        centerTitle: true,
        shape: ShapeBorder.lerp(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          1,
        ),
        title: const Text(
          'Booking Your Seat',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w300,
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
                margin: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.only(left: 12),
                child: DropdownButtonFormField(
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                  hint: const Text('From'),
                  value: _from,
                  items: [
                    'Choose From',
                    'Nairobi',
                    'Mombasa',
                    'Kisumu',
                    'Nakuru',
                  ]
                      .map((value) => DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          ))
                      .toList(),
                  onChanged: (newValue) => setState(() => _from = newValue!),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.only(left: 12),
                child: DropdownButtonFormField(
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
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
              ),
              Container(
                margin: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.only(left: 10),
                child: TextFormField(
                  controller: _costController,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    hintText: "Cost Per Seat",
                    hintStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              Container(
                margin: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.only(left: 10),
                child: TextFormField(
                  controller: _seatsController,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    hintText: "Number of Seats",
                    hintStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              Container(
                margin: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.only(left: 10),
                child: TextFormField(
                  controller: _pickUpController,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    hintText: "Pick-Up Location",
                    hintStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // Styling the the below text
              Container(
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.only(left: 10),
                child: const Text(
                  "Pick up Location must be along the way. By default passengers board at the office",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                    // fontWeight: FontWeight.bold is removed
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 55,
                width: MediaQuery.of(context).size.width * .9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.orange,
                ),
                child: TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      //Login method will be here
                      print('Booking Details:');
                      print('Departure: ${_departureController.text}');
                      print('Arrival: ${_arrivalController.text}');
                      print('Cost per Seat: ${_costController.text}');
                      print('Number of Seats: ${_seatsController.text}');
                      print('Pick-Up Location: ${_pickUpController.text}');
                      print(
                          'Travel Date: ${DateFormat.yMd().format(selectedDate)}');
                      print('Departure Time: ${departureTime.format(context)}');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BookingTable(),
                        ),
                      );
                      //We are going to create a user
                    }
                  },
                  child: const Text(
                    "Book",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
