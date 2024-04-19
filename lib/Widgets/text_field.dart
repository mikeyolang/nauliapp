import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nauliapp/Constants/colors.dart';
import 'package:nauliapp/Constants/text_style.dart';

Widget textField({
  required String hintTxt,
  String image = "",
  required TextEditingController controller,
  bool isObs = false,
  TextInputType? keyBordType,
}) {
  return Container(
    height: 60.0,
    padding: const EdgeInsets.symmetric(horizontal: 30.0),
    margin: const EdgeInsets.symmetric(
      horizontal: 20.0,
      vertical: 10.0,
    ),
    decoration: BoxDecoration(
      color: Colors.yellow,
      borderRadius: BorderRadius.circular(5.0),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 150,
          child: TextField(
            textAlignVertical: TextAlignVertical.center,
            obscureText: isObs,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: hintTxt,
              hintStyle: hintStyle,
            ),
          ),
        ),
        SvgPicture.asset(
          'assets/icon/$image',
          height: 20.0,
          // ignore: deprecated_member_use
          color: blackText,
        )
      ],
    ),
  );
}
