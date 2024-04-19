import 'package:flutter/material.dart';
import 'package:nauliapp/Constants/colors.dart';
import 'package:nauliapp/Constants/space.dart';
import 'package:nauliapp/Constants/text_style.dart';
import 'package:nauliapp/Screens/Signup/sign_up.dart';
import 'package:nauliapp/Widgets/main_button.dart';
import 'package:nauliapp/Widgets/text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController userName = TextEditingController();
  TextEditingController userPass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackBG,
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SpaceVH(height: 50.0),
              const Text(
                'Welcome Back!',
                style: headline1,
              ),
              const SpaceVH(height: 10.0),
              const Text(
                'Please sign in to your account',
                style: headline3,
              ),
              const SpaceVH(height: 60.0),
              textField(
                controller: userName,
                hintTxt: 'Username',
              ),
              textField(
                controller: userPass,
                isObs: true,
                hintTxt: 'Password',
              ),
              const SpaceVH(height: 10.0),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Forgot Password?',
                      style: headline3,
                    ),
                  ),
                ),
              ),
              const SpaceVH(height: 100.0),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    Mainbutton(
                      onTap: () {},
                      text: 'Sign in',
                      btnColor: blueButton,
                    ),
                    const SpaceVH(height: 20.0),
                    
                    const SpaceVH(height: 20.0),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => const SignUpPage()));
                      },
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: 'Don\'t have an account? ',
                            style: headline.copyWith(
                              fontSize: 14.0,
                            ),
                          ),
                          TextSpan(
                            text: ' Sign Up',
                            style: headlineDot.copyWith(
                              fontSize: 14.0,
                            ),
                          ),
                        ]),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
