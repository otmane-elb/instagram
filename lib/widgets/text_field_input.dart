import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController controller;
  final bool ispassword;
  final String hintText;
  final TextInputType textInputType;
  const TextFieldInput(
      {super.key,
      required this.controller,
      required this.hintText,
      this.ispassword = false,
      required this.textInputType});

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          filled: true,
          contentPadding: const EdgeInsets.all(8),
          hintText: hintText,
          border: inputBorder,
          focusedBorder: inputBorder),
      keyboardType: textInputType,
      obscureText: ispassword,
    );
  }
}

