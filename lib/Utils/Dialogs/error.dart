import 'package:flutter/material.dart';
import 'package:nauliapp/Utils/Dialogs/generic_dialog.dart';

Future<bool> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showGenericErrorDialog(
    context: context,
    title: "Authentication Error",
    content: text,
    optionBuilder: () => {
      "Ok": null,
    },
  ).then(
    (value) => value ?? false,
  );
}
