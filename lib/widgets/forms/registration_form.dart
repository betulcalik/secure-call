import 'package:flutter/material.dart';
import '../buttons/country_code_button.dart';
import '../textfields/custom_textfield.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CountryCodeButton(),
        const SizedBox(height: 20),
        CustomTextField(
          controller: _phoneController,
          hintText: 'Phone',
          isPhone: true,
        ),
        const SizedBox(height: 20),
        CustomTextField(
          controller: _passwordController,
          hintText: 'Password',
          isPassword: true,
        ),
      ],
    );
  }
}
