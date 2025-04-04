import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hint,
    required this.ontap,
    this.obscureText = false,
    this.validator,
    this.suffixIcon,
    required this.prefixIcon,
    this.controller,
    this.initialvalue,
    this.isenabled,
  });
  final String hint;
  final void Function(String?) ontap;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final String? initialvalue;
  final bool? isenabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: isenabled,
      initialValue: initialvalue,
      validator: validator,
      obscureText: obscureText,
      onSaved: ontap,
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
      ),
    );
  }
}
