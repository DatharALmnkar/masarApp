import 'package:course_app/core/constants/app_fonts.dart';
import 'package:flutter/material.dart';

class CustomGeneralElevatedButton extends StatelessWidget {
  const CustomGeneralElevatedButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.textButtonColor,
    required this.buttonColor,
    this.borderSide,
  });

  final VoidCallback? onPressed;
  final String text;
  final Color textButtonColor;
  final Color buttonColor;
  final BorderSide? borderSide;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 62,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          foregroundColor: textButtonColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: borderSide ?? BorderSide.none,
          ),
        ),
        child: Text(
          text,
          style: AppFonts.style(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: textButtonColor,
          ),
        ),
      ),
    );
  }
}
