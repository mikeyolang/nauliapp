import 'package:flutter/material.dart';

import '../../Screens/edit_profile_scree.dart';
import '../../Utils/Constants/images.dart';

Widget buildHeader(
  BuildContext context, {
  required String name,
  required String email,
}) {
  return Container(
    decoration: BoxDecoration(
        color: Colors.blue.shade700,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        )),
    padding: EdgeInsets.only(
      top: MediaQuery.of(context).padding.top,
      bottom: 24,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: const EdgeInsets.all(12),
          child: const CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage(nauliLogo),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(12),
          child: Column(
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                ),
              ),
              Text(
                email,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EditProfileScreen()));
                },
                child: const Text(
                  "Edit Profile",
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
