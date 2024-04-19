import 'package:flutter/material.dart';
import 'package:nauliapp/Constants/colors.dart';
import 'package:nauliapp/Constants/space.dart';
import 'package:nauliapp/Constants/text_style.dart';
import 'package:nauliapp/Widgets/main_button.dart';
import 'package:nauliapp/Widgets/text_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController userName = TextEditingController();
  TextEditingController userPass = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPh = TextEditingController();
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
                'Create new account',
                style: headline1,
              ),
              const SpaceVH(height: 10.0),
              const Text(
                'Please fill in the form to continue',
                style: headline3,
              ),
              const SpaceVH(height: 40.0),
              textField(
                controller: userName,
                image: 'user.svg',
                keyBordType: TextInputType.name,
                hintTxt: 'Full Name',
              ),
              textField(
                controller: userEmail,
                keyBordType: TextInputType.emailAddress,
                image: 'user.svg',
                hintTxt: 'Email Address',
              ),
              textField(
                controller: userPh,
                image: 'user.svg',
                keyBordType: TextInputType.phone,
                hintTxt: 'Phone Number',
              ),
              textField(
                controller: userPass,
                isObs: true,
                image: 'hide.svg',
                hintTxt: 'Password',
              ),
              const SpaceVH(height: 20.0),
              Mainbutton(
                onTap: () {},
                text: 'Sign Up',
                btnColor: blueButton,
              ),
              const SpaceVH(height: 20.0),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: 'Have an account? ',
                      style: headline.copyWith(
                        fontSize: 14.0,
                      ),
                    ),
                    TextSpan(
                      text: ' Sign In',
                      style: headlineDot.copyWith(
                        fontSize: 14.0,
                      ),
                    ),
                  ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
