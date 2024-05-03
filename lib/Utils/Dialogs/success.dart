import 'package:flutter/material.dart';
import 'package:nauliapp/Utils/Dialogs/generic_dialog.dart';

Future<bool> showSuccessDialog(
  BuildContext context,
  String text,
  String title,
) {
  return showGenericErrorDialog(
    context: context,
    title: title,
    content: text,
    optionBuilder: () => {
      "Ok": null,
    },
  ).then(
    (value) => value ?? false,
  );
}
