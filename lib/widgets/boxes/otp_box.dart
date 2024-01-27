import 'package:flutter/material.dart';

class OTPBox extends StatelessWidget {
  final bool isFilled;
  final TextEditingController controller;

  const OTPBox({
    super.key,
    required this.isFilled,
    required this.controller
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      child: TextField(
        controller: controller,
        maxLength: 1,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          counterText: "",
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: isFilled ? Colors.black : Colors.grey,
                width: isFilled ? 1 : 0.5
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: isFilled ? Colors.black : Colors.grey,
                width: isFilled ? 1 : 0.5
            ),
          ),
        ),
      ),
    );
  }
}
