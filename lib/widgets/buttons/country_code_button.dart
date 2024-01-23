import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:secure_call/utils/custom_colors.dart';

class CountryCodeButton extends StatefulWidget {
  const CountryCodeButton({super.key});

  @override
  State<CountryCodeButton> createState() => _CountryCodeButtonState();
}

class _CountryCodeButtonState extends State<CountryCodeButton> {
  String selectedCountry = '';

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: FocusNode(canRequestFocus: false),
      style: const TextStyle(fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        hintText: selectedCountry != '' ? selectedCountry : 'Select country',
        suffixIcon: const Icon(Icons.arrow_drop_down),
        border: const OutlineInputBorder(),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: CustomColors.secondaryColor)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: CustomColors.secondaryColor)),
        isDense: true,
        contentPadding: const EdgeInsets.all(8),
      ),
      onChanged: (text) {
        setState(() {
          selectedCountry = text;
        });
      },
      onTap: () {
        showCountryPicker(
          context: context,
          showPhoneCode: false,
          onSelect: (Country country) {
            setState(() {
              selectedCountry = "${country.displayNameNoCountryCode} +${country.phoneCode}";
            });
          },
        );
      },
    );
  }
}
