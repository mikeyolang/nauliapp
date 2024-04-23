// ignore_for_file: unrelated_type_equality_checks, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:nauliapp/Features/Authentication/auth_service.dart';
import 'package:nauliapp/Screens/login.dart';
import 'package:nauliapp/Screens/verification.dart';
import 'package:nauliapp/Utils/Dialogs/error.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool isVisible = false;
  bool _agreedToTerms = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //SingleChildScrollView to have an scrol in the screen
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //We will copy the previous textfield we designed to avoid time consuming
                  const SizedBox(
                    height: 0,
                  ),
// The Nauli App Image asset
                  const Center(
                    child: Image(
                      image: AssetImage("assets/images/Nauli logo.png"),
                      height: 100,
                      width: 100,
                    ),
                  ),

                  const Center(
                    child: ListTile(
                      title: Text(
                        "Register to Create Your Account",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),

                  //As we assigned our controller to the textformfields

                  Container(
                    margin: const EdgeInsets.all(4),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black.withOpacity(.2),
                      ),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: TextFormField(
                      controller: firstNameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "First Name is required";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        icon: Icon(Icons.person),
                        border: InputBorder.none,
                        hintText: "First Name",
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black.withOpacity(.2),
                      ),
                    ),
                    child: TextFormField(
                      controller: lastNameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Second name is required";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        icon: Icon(Icons.person),
                        border: InputBorder.none,
                        hintText: "Second Name",
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black.withOpacity(.2),
                      ),
                    ),
                    child: TextFormField(
                      controller: phoneController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Phone number is required";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        icon: Icon(Icons.phone),
                        border: InputBorder.none,
                        hintText: "Enter Phone Number",
                      ),
                    ),
                  ),
                  //Password field
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black.withOpacity(.2),
                      ),
                    ),
                    child: TextFormField(
                      controller: passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "password is required";
                        }
                        return null;
                      },
                      obscureText: !isVisible,
                      decoration: InputDecoration(
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          icon: const Icon(Icons.lock),
                          border: InputBorder.none,
                          hintText: "Password",
                          suffixIcon: IconButton(
                              onPressed: () {
                                //In here we will create a click to show and hide the password a toggle button
                                setState(() {
                                  //toggle button
                                  isVisible = !isVisible;
                                });
                              },
                              icon: Icon(isVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off))),
                    ),
                  ),

                  //Confirm Password field
                  // Now we check whether password matches or not
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black.withOpacity(.2),
                      ),
                    ),
                    child: TextFormField(
                      controller: confirmPasswordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "password is required";
                        } else if (passwordController.text !=
                            confirmPasswordController.text) {
                          return "Passwords don't match";
                        }
                        return null;
                      },
                      obscureText: !isVisible,
                      decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        icon: const Icon(Icons.lock),
                        border: InputBorder.none,
                        hintText: "Confirm Password",
                        suffixIcon: IconButton(
                          onPressed: () {
                            //In here we will create a click to show and hide the password a toggle button
                            setState(() {
                              //toggle button
                              isVisible = !isVisible;
                            });
                          },
                          icon: Icon(isVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: const Text(
                      'I agree to the terms and conditions',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    value: _agreedToTerms,
                    onChanged: (val) => setState(() => _agreedToTerms = val!),
                    checkColor: Colors.blue,
                    activeColor: Colors.white,
                  ),

                  const SizedBox(height: 20),
                  //Login button
                  Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width * .9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.blue,
                    ),
                    child: TextButton(
                        onPressed: () async {
                          // final firstName = firstNameController.text.toString();
                          // final lastName = lastNameController.text.toString();
                          // final phone = phoneController.text.toString();
                          // final password = passwordController.text.toString();
                          // final confirmPassword =
                          //     confirmPasswordController.text.toString();
                          // final authService = AuthService();
                          // Map<String, dynamic> responseResult =
                          //     await authService.signUp(
                          //   phone,
                          //   firstName,
                          //   lastName,
                          //   password,
                          //   confirmPassword,
                          // );
                          // print('Sign-Up Response: ${responseResult['data']}');
                          // bool isSuccess = responseResult['success'];
                          // if (formKey.currentState!.validate()) {
                          //   if (_agreedToTerms) {
                          //     if (isSuccess) {
                          //       Navigator.push(
                          //         context,
                          //         MaterialPageRoute(
                          //           builder: (context) => Otp(
                          //             phoneNumber: phone,
                          //           ),
                          //         ),
                          //       );
                          //     } else {
                          //       showErrorDialog(
                          //         context,
                          //         "An error occurred while signing up. Please try again. Try using a different phone number.",
                          //       );
                          //     }
                          //   }
                          // }
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Otp(
                                phoneNumber: phoneController.text,
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          "SIGN UP",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),

                  //Sign up button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?"),
                      TextButton(
                        onPressed: () {
                          //Navigate to sign up
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
