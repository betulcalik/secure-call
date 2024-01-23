import 'package:flutter/material.dart';
import '../buttons/country_code_button.dart';
import '../textfields/custom_textfield.dart';

class RegistrationForm extends StatefulWidget {
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final VoidCallback? onTextChanged;
  final ValueChanged<String>? onCountryCodeChanged;

  const RegistrationForm({
    super.key,
    required this.phoneController,
    required this.passwordController,
    this.onTextChanged,
    this.onCountryCodeChanged,
  });

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CountryCodeButton(
          onChanged: (newCountryCode) {
            widget.onCountryCodeChanged?.call(newCountryCode); // Notify parent about validity change
          },
        ),
        const SizedBox(height: 20),
        CustomTextField(
          controller: widget.phoneController,
          hintText: 'Phone',
          isPhone: true,
          onChanged: (value) {
            widget.onTextChanged?.call(); // Notify parent about validity change
          },
        ),
        const SizedBox(height: 20),
        CustomTextField(
          controller: widget.passwordController,
          hintText: 'Password',
          isPassword: true,
          onChanged: (value) {
            widget.onTextChanged?.call(); // Notify parent about validity change
          },
        ),
      ],
    );
  }
}