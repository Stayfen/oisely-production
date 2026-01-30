import 'package:flutter/material.dart';

/// Oisely Design System - Color Tokens
///
/// Based on the warm, friendly UI with orange primary and pastel backgrounds
/// extracted from the app screenshots.

class OiselyColors {
  OiselyColors._();

  // ====================
  // Primary Colors (Greenish Look)
  // ====================

  /// Primary Green - Nature/Forest Theme
  static const Color primary = Color(0xFF6B9E26); // Fresh nature green

  /// Primary Green light variant
  static const Color primaryLight = Color(0xFF9CCC65);

  /// Primary Green dark variant
  static const Color primaryDark = Color(0xFF33691E);

  /// On primary - text/icons on primary color
  static const Color onPrimary = Color(0xFFFFFFFF);

  // ====================
  // Secondary Colors (Accents)
  // ====================

  /// Secondary - Warm accent (Orange from original brand)
  static const Color secondary = Color(0xFFF5A623);

  /// On secondary
  static const Color onSecondary = Color(0xFFFFFFFF);

  /// Tertiary - Soft purple
  static const Color tertiary = Color(0xFFB39DDB);

  /// On tertiary
  static const Color onTertiary = Color(0xFF1A1A1A);

  // ====================
  // Background & Surface
  // ====================

  /// App background - warm cream/off-white
  static const Color background = Color(0xFFFAF8F5);

  /// Surface - slightly elevated surfaces
  static const Color surface = Color(0xFFFFFFFF);

  /// Surface variant - for cards and elevated components
  static const Color surfaceVariant = Color(0xFFF5F5F5);

  /// On background - primary text on background
  static const Color onBackground = Color(0xFF1A1A1A);

  /// On surface - text on surface
  static const Color onSurface = Color(0xFF1A1A1A);

  /// On surface variant - secondary text
  static const Color onSurfaceVariant = Color(0xFF666666);

  // ====================
  // Pastel Card Backgrounds
  // ====================

  /// Soft pink card background
  static const Color cardPink = Color(0xFFFFD6E0);

  /// Soft yellow/cream card background
  static const Color cardYellow = Color(0xFFFFF3D6);

  /// Soft blue card background
  static const Color cardBlue = Color(0xFFD6E8FF);

  /// Soft green card background
  static const Color cardGreen = Color(0xFFD6F5E3);

  /// Soft purple card background
  static const Color cardPurple = Color(0xFFE8D6FF);

  // ====================
  // Semantic Colors
  // ====================

  /// Success - Green
  static const Color success = Color(0xFF4CAF50);
  static const Color onSuccess = Color(0xFFFFFFFF);
  static const Color successLight = Color(0xFFE8F5E9);

  /// Warning - Orange/Amber
  static const Color warning = Color(0xFFFF9800);
  static const Color onWarning = Color(0xFFFFFFFF);
  static const Color warningLight = Color(0xFFFFF3E0);

  /// Error - Red
  static const Color error = Color(0xFFE53935);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorLight = Color(0xFFFFEBEE);

  /// Info - Blue
  static const Color info = Color(0xFF2196F3);
  static const Color onInfo = Color(0xFFFFFFFF);
  static const Color infoLight = Color(0xFFE3F2FD);

  // ====================
  // Neutral Colors
  // ====================

  /// Black - Primary text
  static const Color black = Color(0xFF1A1A1A);

  /// Dark grey
  static const Color grey800 = Color(0xFF333333);
  static const Color grey700 = Color(0xFF4D4D4D);
  static const Color grey600 = Color(0xFF666666);
  static const Color grey500 = Color(0xFF808080);
  static const Color grey400 = Color(0xFF999999);
  static const Color grey300 = Color(0xFFB3B3B3);
  static const Color grey200 = Color(0xFFCCCCCC);
  static const Color grey100 = Color(0xFFE6E6E6);
  static const Color grey50 = Color(0xFFF5F5F5);

  /// White
  static const Color white = Color(0xFFFFFFFF);

  // ====================
  // Outline & Dividers
  // ====================

  /// Outline color for borders
  static const Color outline = Color(0xFFE0E0E0);

  /// Outline variant - lighter borders
  static const Color outlineVariant = Color(0xFFF0F0F0);

  /// Divider color
  static const Color divider = Color(0xFFEEEEEE);

  // ====================
  // Shadow Colors
  // ====================

  /// Shadow color with opacity
  static Color shadow = const Color(0xFF000000).withAlpha(25);

  /// Shadow color for elevated components
  static Color shadowElevated = const Color(0xFF000000).withAlpha(40);

  // ====================
  // Gradient Presets
  // ====================

  /// Primary gradient - orange to coral
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Pastel gradient - pink to yellow
  static const LinearGradient pastelGradient = LinearGradient(
    colors: [cardPink, cardYellow],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Soft gradient - purple to blue
  static const LinearGradient softGradient = LinearGradient(
    colors: [cardPurple, cardBlue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ====================
  // Helper Methods
  // ====================

  /// Get confidence color based on score (0.0 - 1.0)
  static Color getConfidenceColor(double confidence) {
    if (confidence >= 0.8) return success;
    if (confidence >= 0.5) return warning;
    return error;
  }

  /// Get light confidence color for backgrounds
  static Color getConfidenceColorLight(double confidence) {
    if (confidence >= 0.8) return successLight;
    if (confidence >= 0.5) return warningLight;
    return errorLight;
  }

  /// Get card background color based on index (for cycling through pastels)
  static Color getCardColor(int index) {
    final colors = [cardPink, cardYellow, cardBlue, cardGreen, cardPurple];
    return colors[index % colors.length];
  }
}
