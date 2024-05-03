import 'package:flutter/material.dart';
import 'package:nauliapp/Utils/Dialogs/generic_dialog.dart';


Future<bool> showLogOutDialog(BuildContext context) {
  return showGenericErrorDialog(
      context: context,
      title: "Log Out",
      content: "Are you sure you want to Log out",
      optionBuilder: () => {"Cancel": false, "Log Out": true}).then(
    (value) => value ?? false,
  );
}
