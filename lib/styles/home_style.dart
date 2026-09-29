import 'package:flutter/material.dart';

class HomeStyle {
  static const Color primary = Color(0xFF2E7D32);
  static const Color secondary = Color(0xFF66BB6A);
  static const Color lightGreen = Color(0xFFE8F5E9);
  static const Color textDark = Color(0xFF1B1B1B);
  static const Color textGrey = Color(0xFF666666);
  static const Color white = Colors.white;

  static const BoxDecoration background = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFFF1F8E9),
        Colors.white,
      ],
    ),
  );

  static const TextStyle logo = TextStyle(
    fontSize: 38,
    fontWeight: FontWeight.bold,
    color: primary,
    letterSpacing: 1,
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w700,
    color: secondary,
    letterSpacing: 1.8,
  );

  static const TextStyle description = TextStyle(
    fontSize: 15.5,
    color: textGrey,
    height: 1.55,
  );

  static const BoxDecoration logoShadow = BoxDecoration(
    boxShadow: [
      BoxShadow(
        color: Color(0x33000000),
        blurRadius: 25,
        offset: Offset(0, 12),
      ),
    ],
  );

  static final ButtonStyle button =
      ElevatedButton.styleFrom(
    backgroundColor: primary,
    foregroundColor: white,
    elevation: 5,
    shadowColor: primary.withOpacity(0.35),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18),
    ),
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    letterSpacing: 1,
    color: white,
  );

  static final ButtonStyle loginButton =
      OutlinedButton.styleFrom(
    foregroundColor: primary,
    side: const BorderSide(
      color: primary,
      width: 1.5,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18),
    ),
  );

  static const TextStyle loginButtonText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.8,
    color: primary,
  );

  static const TextStyle footer = TextStyle(
    fontSize: 12,
    color: Color(0xFF888888),
  );
}