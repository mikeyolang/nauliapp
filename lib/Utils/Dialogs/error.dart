import 'package:flutter/material.dart';
import 'package:nauliapp/Utils/Dialogs/generic_dialog.dart';

Future<bool> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showGenericErrorDialog(
    context: context,
    title: "An Error Has Occured",
    content: text,
    optionBuilder: () => {
      "Ok": null,
    },
  ).then(
    (value) => value ?? false,
  );
}
