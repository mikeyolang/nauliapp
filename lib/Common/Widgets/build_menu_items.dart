// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';

Widget buildMenuItems(
  BuildContext context, {
  required IconData icon,
  required String title,
  required VoidCallback onTapFunction,
}) {
  return Container(
    padding: const EdgeInsets.all(10),
    margin: const EdgeInsets.only(
      top: 10,
      bottom: 10,
    ),
    child: Wrap(
      runSpacing: 16,
      children: [
        ListTile(
          onTap: () {},
          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.blue.shade100, shape: BoxShape.circle),
            child: Icon(
              icon,
              color: Colors.blue,
              size: 30,
            ),
          ),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
          ),
          trailing: const Icon(Icons.arrow_forward_ios_rounded),
        ),
      ],
    ),
  );
}
