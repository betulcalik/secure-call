import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  final String hintText;
  final String initialValue;
  final Function(String) onChanged;

  const SearchTextField({
    super.key,
    this.hintText = "Search contacts",
    this.initialValue = "",
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      controller: TextEditingController(text: initialValue),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 1.0),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 1.0),
          borderRadius: BorderRadius.circular(8.0),
        ),
        hintStyle: TextStyle(
          fontSize: 14,
          color: Colors.grey.shade500,
        ),
        hintText: hintText,
        prefixIcon: const Icon(Icons.search),
        isDense: true, // decrease height of textfield
      ),
    );
  }
}
