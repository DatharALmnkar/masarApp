// ميثود بناء كرت خيار اللغة المبسط بدون حالات الاختيار السابقة (Border)
import 'package:course_app/core/constants/app_fonts.dart';
import 'package:flutter/material.dart';

Widget buildLanguageOption({
  required String flagAsset,
  required String languageName,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      children: [
        Container(
          width: 120,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 15,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.asset(flagAsset, fit: BoxFit.cover),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          languageName,
          style: AppFonts.style(
            fontWeight: FontWeight.w600,
            fontSize: 22,
            color: const Color(0xFF4B5563),
          ),
        ),
      ],
    ),
  );
}
