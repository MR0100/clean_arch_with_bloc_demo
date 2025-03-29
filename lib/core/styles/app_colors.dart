import 'package:flutter/material.dart';

class AppColors {
  static const Color kTransparent = Colors.transparent;
  static const Color kBlack = Colors.black;
  static const Color kWhite = Colors.white;
  static const Color kPrimary = Colors.deepPurple;
  static const Color kPrimaryAccent = Colors.deepPurpleAccent;
  static Color kGreen = Colors.green.shade700;
  static Color kBlue = Colors.blue.shade900;

  static const Color kError = Colors.red;
  static const Color kInfo = Colors.blue;
  static const Color kWarning = Colors.orange;
  static const Color kSuccess = Colors.green;

  static const Color kTextBlack = Colors.black;
  static const Color kTextTitle = Colors.black;
  static const Color kTextSubTitle = Colors.black87;

  static const Color kButtonDisabled = Colors.grey;

  static LinearGradient diamondCardInnerGradient = LinearGradient(
    colors: [
      Colors.blue.shade50,
      Colors.deepPurple.shade50,
      Colors.orange.shade50,
    ],
    stops: [0.3, 0.8, 1.0],
  );
}
