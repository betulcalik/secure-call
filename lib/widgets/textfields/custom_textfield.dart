import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final bool isPhone;
  final bool showErrorMessage;
  final String errorMessage;
  final ValueChanged<String>? onChanged;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.isPassword = false,
    this.isPhone = false,
    this.showErrorMessage = false,
    this.errorMessage = '',
    this.onChanged,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isPasswordVisible = false;
  String? _errorText;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        // The error message should only be visible when the TextField is focused
        _errorText = _focusNode.hasFocus ? (widget.showErrorMessage ? widget.errorMessage : validatePassword(widget.controller.text)) : null;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  List<TextInputFormatter>? getInputFormatters() {
    if (widget.isPassword) {
      return [FilteringTextInputFormatter.deny(RegExp(r'\s'))]; // Deny whitespaces for passwords
    }

    if (widget.isPhone) {
      return [FilteringTextInputFormatter.digitsOnly];
    }

    return null;
  }

  String? validatePassword(String value) {
    if (widget.isPassword && value.length < 6) {
      return 'Password must be at least 6 characters long.';
    }
    return null;
  }

  void _updateErrorText(String text) {
    setState(() {
      // Only update the error message when the TextField is focused
      if (_focusNode.hasFocus) {
        _errorText = widget.showErrorMessage
            ? widget.errorMessage
            : validatePassword(text);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.isPassword && !_isPasswordVisible,
      inputFormatters: getInputFormatters(),
      focusNode: _focusNode,
      onChanged: (text) {
        _updateErrorText(text);
        widget.onChanged?.call(text); // Notify parent about text change
      },
      onEditingComplete: () {
        _updateErrorText(widget.controller.text);
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFF2F2F2),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(width: 1, color: Colors.black),
        ),
        disabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(width: 1, color: Colors.orange),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(width: 1, color: Colors.grey),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(width: 1),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(width: 1, color: Colors.grey),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(width: 1, color: Colors.redAccent),
        ),
        hintText: widget.hintText,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              )
            : null,
        errorText: _errorText,
      ),
    );
  }
}
