import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String? Function(String?)? validator;
  final void Function(String)? onChange;
  final IconData? prefixIcon;
  final bool obsecureText;
  final String? initialValue;
  final bool? isReadOnly;
  const CustomTextField({
    super.key,
    required this.hintText,
    this.validator,
    this.onChange,
    this.obsecureText = false,
    this.prefixIcon,
    this.initialValue,
    this.isReadOnly,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: isReadOnly ?? false,
      initialValue: initialValue,
      obscureText: obsecureText,
      onChanged: onChange,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      decoration: InputDecoration(
        labelText: hintText,
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
