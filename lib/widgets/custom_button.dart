import 'package:flutter/material.dart';
import 'package:sherpal/constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.formkey,
    required this.text,
    required this.ontap,
    this.color,
    this.width,
    this.bordercolor,
    this.gradient,
  });

  final GlobalKey<FormState>? formkey;
  final Widget text;
  final VoidCallback ontap;
  final Color? color;
  final double? width;
  final Color? bordercolor;
  final LinearGradient? gradient;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: width ?? MediaQuery.of(context).size.width,
        height: 60,
        decoration: BoxDecoration(
          gradient: gradient,
          color: color,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: bordercolor ?? AppColors.ruby, width: 2),
        ),
        child: Center(child: text),
      ),
    );
  }
}
