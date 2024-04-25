// ignore_for_file: avoid_print, unused_fiel
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nauliapp/Features/Authentication/auth_service.dart';
import 'package:nauliapp/Screens/booking_table.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nauliapp/Utils/Dialogs/error.dart';

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

  List<String> _fromRoutes = [];
  String? _selectedFromRoute;
  List<String> _toRoutes = [];
  String? _selectedToRoute;
  String? _costPerSeat;

  int? routeId;
  String? vehicles;
  String? _selectedVehicle;
  final List<DropdownMenuItem> _dropdownMenuItems = [];
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

  final List<String> _routes = [];
  String? _selectedRoute;
  @override
  void initState() {
    super.initState();
    _getFromRoutes();
  }

  Future<void> _getFromRoutes() async {
    const url = 'https://booking.nauli.co.ke/api/v1/booking';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        List<dynamic> routes = data['routes'];

        setState(() {
          print(data);
          _fromRoutes =
              routes.map((route) => route['from'].toString()).toList();
        });
      } else {
        throw Exception('Failed to load from routes');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchData(int routeId, String travelDate) async {
    // Construct the URL by replacing routeId and travelDate in the endpoint
    String url =
        'https://booking.nauli.co.ke/api/v1/fetch-cost/$routeId/$travelDate';

    try {
      // Make the GET request
      final response = await http.get(Uri.parse(url));

      // Check the status code of the response
      if (response.statusCode == 200) {
        // Parse the JSON response body
        Map<String, dynamic> responseData = json.decode(response.body);

        // Extract data from the response
        String cost = responseData['cost'];
        List<dynamic> vehicles = responseData['vehicles'];
        String date = responseData['date'];

        setState(() {
          _costPerSeat = cost;
          vehicles = List<Map<String, dynamic>>.from(vehicles);
          _selectedVehicle = null; // Reset selected vehicle

          // Clear the dropdown items
          _dropdownMenuItems.clear();

          // Add a dropdown item for each vehicle
          for (var vehicle in vehicles) {
            _dropdownMenuItems.add(
              DropdownMenuItem(
                value: vehicle,
                child: Text(
                  'Time: ${vehicle['time']} Hours, ${vehicle['capacity']} seats remaining',
                ),
              ),
            );
          }
        });

        // Process the data as needed
        print('Cost: $cost');
        print('Date: $date');

        // Print vehicle details
        for (var vehicle in vehicles) {
          print(
            'Vehicle ID: ${vehicle['id']}, Time: ${vehicle['time']}, Capacity: ${vehicle['capacity']}, Count: ${vehicle['count']}',
          );
        }
      } else {
        // Handle any errors
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network errors
      print('Error fetching data: $e');
    }
  }

  Future<void> _getToRoutes(String fromRoute) async {
    final url = 'https://booking.nauli.co.ke/api/v1/fetch-routes/$fromRoute';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        List<dynamic> routes = data['routes'];

        setState(() {
          _toRoutes = routes.map((route) => route['name'].toString()).toList();
          routeId =
              routes.map<int>((route) => route['id'] as int).toList().first;
        });
      } else {
        throw Exception('Failed to load to routes');
      }
    } catch (e) {
      print(e.toString());
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
                    activeColor: Colors.blue,
                    value: "Self",
                    groupValue: "",
                    onChanged: (value) => {
                      setState(() {
                        _selectedRoute = value;
                      })
                    },
                  ),
                  const Text("Self"),
                  Radio(
                    value: "Other",
                    groupValue: "",
                    onChanged: (value) => {
                      setState(() {
                        _selectedRoute = value;
                      })
                    },
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
                    'Travel Date: ${DateFormat("yyyy-MM-dd").format(selectedDate)}',
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
                  onTap: () {
                    _selectDate(context);
                    final datePicked =
                        DateFormat("yyyy-MM-dd").format(selectedDate);
                    print(datePicked);
                  },
                ),
              ),
              Container(
                height: 55,
                width: MediaQuery.of(context).size.width * .9,
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
                  hint: const Text('Choose From'),
                  value: _selectedFromRoute,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedFromRoute = newValue;
                      _getToRoutes(newValue!);
                    });
                  },
                  items:
                      _fromRoutes.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
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
                  hint: const Text('Choose To'),
                  value: _selectedToRoute,
                  items:
                      _toRoutes.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      fetchData(
                        routeId!,
                        DateFormat("yyyy-MM-dd").format(selectedDate),
                      );
                    });
                  },
                ),
              ),

              Container(
                margin: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.only(left: 10),
                child: Text('Cost per seat: $_costPerSeat'),
              ),
              Container(
                height: 55,
                width: MediaQuery.of(context).size.width * .9,
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
                  hint: const Text('Choose Time'),
                  value: _selectedVehicle,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedVehicle = newValue;
                    });
                  },
                  items: _dropdownMenuItems,
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
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final numberOfSeats = _seatsController.text;
                      final pickUpLocation = _pickUpController.text;
                      final date =
                          DateFormat("yyyy-MM-dd").format(selectedDate);

                      // final totalCosts = cost * numberOfSeats;
                      final authService = AuthService();
                      final responseResult =
                          await authService.saveBookingRequest(
                        travelDate: date,
                        to: routeId!,
                        time: _selectedVehicle!,
                        seats: numberOfSeats,
                        pickUp: pickUpLocation,
                      );
                      bool isSuccess = responseResult['success'];
                      if (isSuccess) {
                        print("Succes");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BookingTable(),
                          ),
                        );
                      } else {
                        showErrorDialog(context, "Failed To Save Booking");
                      }

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
