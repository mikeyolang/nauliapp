// ignore_for_file: avoid_print, unused_fiel, unnecessary_string_interpolations, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nauliapp/Features/Authentication/auth_service.dart';
import 'package:nauliapp/Screens/booking_table.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nauliapp/Utils/Dialogs/error.dart';
import 'package:nauliapp/Utils/Dialogs/success.dart';

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
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _secondNameController = TextEditingController();

  List<String> _fromRoutes = [];
  String? _selectedFromRoute;
  List<String> _toRoutes = [];
  String? _selectedToRoute;
  String? _costPerSeat;

  int? _selectedRouteId;
  Map<String, int> _routeIdMap = {};
  String? vehicles;
  String? _selectedVehicle;
  final List<DropdownMenuItem> _dropdownMenuItems = [];

  String? _selectedTime;
  int _selectedCapacity = 0;

  bool isSelfSelected = true;
  String? firstName;
  String? secondName;

  // Function to handle dropdown menu item selection
  void _handleVehicleSelection(dynamic newValue) {
    setState(() {
      _selectedCapacity = newValue['capacity'];
      _selectedTime = newValue['time'];
    });
  }

  // Validate number of seats against capacity
  String? _validateSeats(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter number of seats';
    }
    final int? seats = int.tryParse(value);
    if (seats == null || seats <= 0) {
      return 'Please enter a valid number of seats';
    }
    if (seats > _selectedCapacity) {
      return 'Number of seats cannot Remaining Seats ($_selectedCapacity)';
    }
    return null;
  }

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

  // ignore: unused_field
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

  Future<void> fetchCostPerSeat(int routeId, String travelDate) async {
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
        // _selectedTime = responseData["vehicles"]["time"];

        setState(() {
          _costPerSeat = cost;
          vehicles = List<Map<String, dynamic>>.from(vehicles);
          // _selectedVehicle = null; // Reset selected vehicle

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
        List<String> routeNamesList = [];

// Create a map to associate each route with its corresponding routeId
        Map<String, int> routeIdMap = {};
        for (var route in routes) {
          String routeName = route['name'].toString();
          int routeId = route['id'] as int;
          routeNamesList.add(routeName); // Add routeName to list
          routeIdMap[routeName] = routeId;
          // routeIdMap[route['name']] = route['id'];
        }
        // Convert Set back to List and sort alphabetically

        setState(() {
          _toRoutes = routeIdMap.keys.toList();
          _routeIdMap = routeIdMap;
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
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
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
          'Book Your Seat',
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
                    value: true,
                    groupValue: isSelfSelected,
                    onChanged: (value) => {
                      setState(() {
                        // _selectedRoute = value;
                        isSelfSelected = value as bool;
                      })
                    },
                  ),
                  const Text("Self"),
                  Radio(
                    value: false,
                    groupValue: isSelfSelected,
                    onChanged: (value) => {
                      setState(() {
                        // _selectedRoute = value;
                        isSelfSelected = value as bool;
                      })
                    },
                  ),
                  const Text("Other"),
                ],
              ),
              if (!isSelfSelected)
                Column(
                  children: [
                    Container(
                      height: 55,
                      width: MediaQuery.of(context).size.width * .9,
                      padding: const EdgeInsets.only(bottom: 0),
                      margin: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        controller: _firstNameController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter First Name",
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
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
                      child: TextFormField(
                        controller: _secondNameController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter Last Name",
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
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
                      child: TextFormField(
                        controller: _phoneController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter Phone Number",
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
                        // onChanged: (value) {
                        //   setState(() {
                        //     secondName = value;
                        //   });
                        // },
                      ),
                    ),
                  ],
                ),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: MediaQuery.of(context).size.width * .9,
                margin: const EdgeInsets.only(left: 10, right: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: ListTile(
                  title: Text(
                    'Travel Date: ${DateFormat("yyyy-MM-dd").format(selectedDate)}',
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
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
                child: DropdownButtonFormField(
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                  hint: const Text('Choose From'),
                  value: _selectedFromRoute,
                  onChanged: (newValue) async {
                    setState(() {
                      _selectedFromRoute = newValue;
                      _selectedToRoute = null;
                    });
                    await _getToRoutes(newValue!);
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
                width: MediaQuery.of(context).size.width * .9,
                margin: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: DropdownButtonFormField(
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                  hint: const Text('Choose To'),
                  value: _selectedToRoute,
                  items:
                      _toRoutes.map<DropdownMenuItem<String?>>((String? value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value!),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    _selectedToRoute = newValue;
                    // Get the selected routeId from the map
                    _selectedRouteId = _routeIdMap[newValue];
                    setState(() {
                      fetchCostPerSeat(
                        _selectedRouteId!,
                        DateFormat("yyyy-MM-dd").format(selectedDate),
                      );
                    });
                    if (_selectedToRoute != "Choose To") {
                      print("Hello World");
                    }
                  },
                ),
              ),

              Container(
                alignment: Alignment.center,
                height: 50,
                width: MediaQuery.of(context).size.width * .9,
                margin: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
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
                child: DropdownButtonFormField(
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                  hint: const Text('Choose Time'),
                  value: _selectedVehicle,
                  onChanged: _handleVehicleSelection,
                  items: _dropdownMenuItems,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * .9,
                margin: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                // padding: const EdgeInsets.only(left: 10),
                child: TextFormField(
                  controller: _seatsController,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    hintText: "Number of Seats",
                    hintStyle: TextStyle(
                      color: Colors.black54,
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: _validateSeats,
                ),
              ),

              Container(
                width: MediaQuery.of(context).size.width * .9,
                margin: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                // padding: const EdgeInsets.only(left: 10),
                child: TextFormField(
                  controller: _pickUpController,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    hintText: "Pick-Up Location",
                    hintStyle: TextStyle(
                      color: Colors.black54,
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
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
                      final firstName = _firstNameController.text;
                      final lastName = _secondNameController.text;
                      final phoneNumber = _phoneController.text;
                      final numberOfSeats = _seatsController.text;
                      final pickUpLocation = _pickUpController.text;
                      String date =
                          DateFormat("yyyy-MM-dd").format(selectedDate);
                      final AuthService authService = AuthService();
                      final routeStringId = _selectedRouteId;
                      final time = _selectedTime;
                      print(
                          "Her are the details sent to the API: $date, \n$routeStringId, \n$time, \n$numberOfSeats, \n$pickUpLocation");

                      if (isSelfSelected) {
                        final responseResult =
                            await authService.saveSelfBooking(
                          travel_date: date,
                          to: "$routeStringId",
                          time: "$time",
                          seats: "$numberOfSeats",
                          pick_up: "$pickUpLocation",
                        );
                        bool isSuccess = responseResult['success'];
                        if (isSuccess) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const BookingTable();
                              },
                            ),
                          );
                        } else {
                          showErrorDialog(
                            context,
                            "Oops Not Successfull",
                          );
                        }
                      } else {
                        if (firstName.isNotEmpty &&
                            phoneNumber.isNotEmpty &&
                            lastName.isNotEmpty) {
                          // Additional fields are filled, proceed with booking
                          final responseResult =
                              await authService.saveOtherBooking(
                            travel_date: date,
                            to: "$routeStringId",
                            time: "$time",
                            seats: "$numberOfSeats",
                            pick_up: "$pickUpLocation",
                            first_name: firstName,
                            last_name: lastName,
                            phone: phoneNumber,
                          );
                          bool isSuccess = responseResult['success'];
                          if (isSuccess) {
                            await showSuccessDialog(
                              context,
                              "You Booking has Been Save Successfully. Proceed to Paying",
                              "Booking Successfll",
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const BookingTable();
                                },
                              ),
                            );
                          } else {
                            showErrorDialog(
                              context,
                              "Oops Not Successfull",
                            );
                          }
                        } else {
                          // Additional fields are not filled, show error or prompt user
                          showErrorDialog(
                            context,
                            "Make Sure you have entered First Name, Second Name, and Phone Number",
                          );
                        }
                      }
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
