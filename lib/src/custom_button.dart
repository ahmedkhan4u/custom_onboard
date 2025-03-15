import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String text;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final Color? borderColor;
  final Color? buttonColor;
  final Color? textColor;
  final ButtonStyle? buttonStyle;

  const CustomButton({
    super.key,
    required this.text,
    this.onTap,
    this.textStyle,
    this.padding,
    this.borderColor,
    this.buttonColor,
    this.textColor,
    this.buttonStyle,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: buttonStyle ??
          OutlinedButton.styleFrom(
            backgroundColor: buttonColor,
            side: BorderSide(
                color: borderColor ?? Colors.transparent), // Outline border
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)), // Rounded corners

            padding: padding ??
                const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          ),
      child: Text(
        text,
        style: textStyle ??
            TextStyle(fontSize: 16, color: textColor ?? Colors.black),
      ),
    );
  }
}
