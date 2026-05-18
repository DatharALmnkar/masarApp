import 'package:course_app/core/constants/app_fonts.dart';
import 'package:course_app/core/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.text1,
    required this.text2,
    required this.onPressed,
  });

  final String text1;
  final String text2;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$text1 ',
          style: AppFonts.style(
            fontWeight: FontWeight.w500,
            fontSize: 18,
            color: const Color(0xFF949D9E),
            letterSpacing: 0.002,
          ),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            '$text2 ',
            style: AppFonts.style(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: kMainColor,
              letterSpacing: 0.002,
            ),
          ),
        ),
      ],
    );
  }
}
