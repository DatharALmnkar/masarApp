import 'package:course_app/core/constants/app_fonts.dart';
import 'package:course_app/core/helper_functions/form_validators.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.textInputType,
    required this.text,
    this.suffixIcon,
    this.onSaved,
    this.obscureText = false,
    this.onChanged,
    this.validator,
  });

  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final String hintText;
  final String text;
  final TextInputType textInputType;
  final Widget? suffixIcon;
  final void Function(String?)? onSaved;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: AppFonts.style(
            fontWeight: FontWeight.w500,
            fontSize: 22,
            color: Colors.black,
            letterSpacing: 0.002,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          onChanged: onChanged,
          obscureText: obscureText,
          onSaved: onSaved,
          validator: validator ?? FormValidators.required,
          keyboardType: textInputType,
          style: AppFonts.style(fontSize: 16, color: Colors.black),
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            hintStyle: AppFonts.style(color: const Color(0xFF949D9E)),
            hintText: hintText,
            filled: true,
            fillColor: Colors.white,
            border: _buildBorder(),
            enabledBorder: _buildBorder(),
            focusedBorder: _buildBorder(),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(width: 2, color: Color(0xFFE6E9E9)),
    );
  }
}
