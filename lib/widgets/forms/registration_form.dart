import 'package:flutter/material.dart';
import '../buttons/country_code_button.dart';
import '../textfields/custom_textfield.dart';

class RegistrationForm extends StatefulWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final VoidCallback? onTextChanged;
  final ValueChanged<String>? onCountryCodeChanged;

  const RegistrationForm({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
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
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                  controller: widget.firstNameController,
                  hintText: "First Name",
                  onChanged: (value) {
                    widget.onTextChanged?.call();
                  }
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: CustomTextField(
                  controller: widget.lastNameController,
                  hintText: "Last Name",
                  onChanged: (value) {
                    widget.onTextChanged?.call();
                  }
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        CountryCodeButton(
          onChanged: (newCountryCode) {
            widget.onCountryCodeChanged
                ?.call(newCountryCode);
          },
        ),
        const SizedBox(height: 20),
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
