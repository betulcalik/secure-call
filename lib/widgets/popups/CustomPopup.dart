import 'package:flutter/material.dart';

class CustomPopup extends StatelessWidget {
  final String title;
  final String message;
  const CustomPopup({super.key, required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontFamily: "Source Sans 3",
          fontWeight: FontWeight.bold,
          fontSize: 24
        ),
      ),
      content: Text(message),
      actions: [
        Center(
          child: TextButton(
            child: const Text(
              'OK',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );
  }
}
