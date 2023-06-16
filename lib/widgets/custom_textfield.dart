import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String? Function(String?)? validator;
  final void Function(String)? onChange;
  final IconData? prefixIcon;
  const CustomTextField(
      {super.key,
      required this.hintText,
      this.validator,
      this.onChange,
      this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChange,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        fillColor: Colors.grey.shade200,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
