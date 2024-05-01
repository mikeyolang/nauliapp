// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:nauliapp/Common/Widgets/nav_root.dart';
import 'package:nauliapp/Features/Authentication/auth_provider.dart';
import 'package:nauliapp/Screens/signup.dart';
import 'package:nauliapp/Features/Authentication/auth_service.dart';
import 'package:nauliapp/Utils/Dialogs/error.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //We need two text editing controller

  //TextEditing controller to control the text when we enter into it
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  //A bool variable for show and hide password
  bool isVisible = false;

  //Here is our bool variable
  bool isLoginTrue = false;

  //Now we should call this function in login butto

  //We have to create global key for our form
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            //We put all our textfield to a form to be controlled and not allow as empty
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  //Username field

                  //Before we show the image, after we copied the image we need to define the location in pubspec.yaml
                  Image.asset(
                    "assets/images/Nauli logo.png",
                    width: 210,
                  ),
                  const SizedBox(height: 15),
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      border: Border.all(color: Colors.black.withOpacity(.2)),
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: phoneNumberController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Phone number is required is required";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        icon: Icon(Icons.phone),
                        border: InputBorder.none,
                        hintText: "Phone Number",
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

                  const SizedBox(height: 30),
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
                        if (formKey.currentState!.validate()) {
                          final phone = phoneNumberController.text.toString();
                          final password = passwordController.text.toString();
                          final authService = AuthService();

                          Map<String, dynamic> responseResult =
                              await authService.signIn(
                            phone,
                            password,
                          );
                          bool isSuccess = responseResult['success'];
                          if (isSuccess) {
                           
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const NavBarRoots(),
                              ),
                            );
                          } else {
                            showErrorDialog(context, responseResult['message']);
                          }

                          // I want that after successful login, the user should be redirected to the home page

                          // ignore: unrelated_type_equality_checks

                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => const NavBarRoots(),
                          //   ),
                          // );
                        }
                      },
                      child: const Text(
                        "LOGIN",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),

                  //Sign up button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          //Navigate to sign up
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUp()));
                        },
                        child: const Text(
                          "SIGN UP",
                          style: TextStyle(color: Colors.blue),
                        ),
                      )
                    ],
                  ),

                  // We will disable this message in default, when user and pass is incorrect we will trigger this message to user
                  isLoginTrue
                      ? const Text(
                          "Phone or passowrd is incorrect",
                          style: TextStyle(color: Colors.red),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
