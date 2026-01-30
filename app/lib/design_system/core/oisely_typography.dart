import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Oisely Design System - Typography Tokens
class OiselyTypography {
  OiselyTypography._();

  static String get fontFamily => GoogleFonts.inter().fontFamily!;

  // Display & Headers
  static TextStyle get h1 =>
      GoogleFonts.inter(fontSize: 32, fontWeight: FontWeight.bold, height: 1.2);
  static TextStyle get h2 =>
      GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.bold, height: 1.3);
  static TextStyle get h3 =>
      GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w600, height: 1.3);
  static TextStyle get h4 =>
      GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w600, height: 1.4);
  static TextStyle get h5 =>
      GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600, height: 1.4);
  static TextStyle get h6 =>
      GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, height: 1.5);

  // Body Text
  static TextStyle get bodyLarge => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    height: 1.6,
  );
  static TextStyle get bodyMedium => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );
  static TextStyle get bodySmall => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    height: 1.4,
  );

  // Special
  static TextStyle get caption =>
      GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w500, height: 1.3);
  static TextStyle get button =>
      GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, height: 1.2);
  static TextStyle get label =>
      GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500, height: 1.3);

  // Component-Specific
  static TextStyle get appBarTitle =>
      GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w600, height: 1.4);
  static TextStyle get cardTitle =>
      GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600, height: 1.3);
  static TextStyle get chip =>
      GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500, height: 1.2);
  static TextStyle get percentage =>
      GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.bold, height: 1.2);
}
