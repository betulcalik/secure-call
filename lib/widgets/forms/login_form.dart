import 'package:flutter/material.dart';

import '../textfields/custom_textfield.dart';

class LoginForm extends StatefulWidget {
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final VoidCallback? onTextChanged;
  const LoginForm({
    super.key,
    required this.phoneController,
    required this.passwordController,
    this.onTextChanged
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          controller: widget.phoneController,
          hintText: 'Phone',
          isPhone: true,
          onChanged: (value) {
            widget.onTextChanged?.call();
          },
        ),
        const SizedBox(height: 20),
        CustomTextField(
          controller: widget.passwordController,
          hintText: 'Password',
          isPassword: true,
          onChanged: (value) {
            widget.onTextChanged?.call();
          },
        ),
      ],
    );
  }
}
