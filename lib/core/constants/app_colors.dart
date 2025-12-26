import 'package:flutter/material.dart';

class AppColors {
  // Primary Brand Color (Teal/Cyan)
  static const Color primary = Color(0xFF2BCDEE);
  static const Color primaryDark = Color(0xFF22A4BE);

  // Backgrounds
  static const Color backgroundLight = Color(0xFFF6F8F8);
  static const Color backgroundDark = Color(0xFF111F22); // Common dark bg
  static const Color backgroundDarker = Color(
    0xFF101F22,
  ); // Sidebar/Header in some files

  // Surfaces & Borders
  static const Color surfaceDark = Color(0xFF192F33); // Card backgrounds
  static const Color surfaceHighlight = Color(0xFF1E2F33);
  static const Color borderDark = Color(0xFF325E67);
  static const Color accentTeal = Color(0xFF234248);

  // Text Colors
  static const Color textWhite = Colors.white;
  static const Color textMuted = Color(
    0xFF92C0C9,
  ); // The specific teal-grey text
  static const Color textSecondary = Color(0xFF94A3B8); // Standard slate grey

  // Functional Colors
  static const Color success = Color(0xFF0BDA54); // Green for wins
  static const Color danger = Color(0xFFFF4B4B); // Red for losses
  static const Color warning = Color(0xFFF3BA2F); // Binance Yellow / Warning

  // Gradients
  static const LinearGradient chartGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color.fromRGBO(43, 205, 238, 0.2),
      Color.fromRGBO(43, 205, 238, 0),
    ],
  );
}
