import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:secure_call/utils/custom_colors.dart';

class CountryCodeButton extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  const CountryCodeButton({super.key, this.onChanged});

  @override
  State<CountryCodeButton> createState() => _CountryCodeButtonState();
}

class _CountryCodeButtonState extends State<CountryCodeButton> {
  String _selectedCountry = '';
  String _selectedCountryCode = ''; // Track the current country code

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: FocusNode(canRequestFocus: false),
      style: const TextStyle(fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        hintText: _selectedCountry != '' ? _selectedCountry : 'Select country',
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
          _selectedCountry = text;
        });
      },
      onTap: () {
        showCountryPicker(
          context: context,
          showPhoneCode: false,
          onSelect: (Country country) {
            setState(() {
              _selectedCountry = "${country.displayNameNoCountryCode} +${country.phoneCode}";
              _selectedCountryCode = country.countryCode;
              widget.onChanged?.call(_selectedCountryCode); // Notify parent about text change
            });
          },
        );
      },
    );
  }
}
