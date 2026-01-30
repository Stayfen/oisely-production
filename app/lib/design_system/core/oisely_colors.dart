import 'package:flutter/material.dart';

/// Oisely Design System - Color Tokens
///
/// A vibrant, playful color palette inspired by a "home zoo" theme.
/// Featuring lush greens, warm earth tones, and friendly animal-inspired accents.

class OiselyColors {
  OiselyColors._();

  // ====================
  // Primary Colors (Vibrant Nature Green)
  // ====================

  /// Primary Green - Lush tropical foliage
  static const Color primary = Color(0xFF2ECC71); // Vibrant emerald green

  /// Primary light variant - Fresh spring leaves
  static const Color primaryLight = Color(0xFF58D68D);

  /// Primary lighter variant - Soft mint
  static const Color primaryLighter = Color(0xFFABEBC6);

  /// Primary dark variant - Deep forest green
  static const Color primaryDark = Color(0xFF1E8449);

  /// Primary container - Light green background
  static const Color primaryContainer = Color(0xFFD5F5E3);

  /// On primary - text/icons on primary color
  static const Color onPrimary = Color(0xFFFFFFFF);

  /// On primary container
  static const Color onPrimaryContainer = Color(0xFF145A32);

  // ====================
  // Secondary Colors (Aqua Teal - Ocean Inspired)
  // ====================

  /// Secondary - Tropical teal (sea turtle/ocean inspired)
  static const Color secondary = Color(0xFF20B2AA);

  /// Secondary light
  static const Color secondaryLight = Color(0xFF5DCFCC);

  /// Secondary dark
  static const Color secondaryDark = Color(0xFF178F89);

  /// Secondary container
  static const Color secondaryContainer = Color(0xFFD0F4F2);

  /// On secondary
  static const Color onSecondary = Color(0xFFFFFFFF);

  /// On secondary container
  static const Color onSecondaryContainer = Color(0xFF0D4744);

  // ====================
  // Tertiary Colors (Tropical Sky Blue)
  // ====================

  /// Tertiary - Tropical ocean blue
  static const Color tertiary = Color(0xFF5DADE2);

  /// Tertiary light
  static const Color tertiaryLight = Color(0xFF85C1E9);

  /// Tertiary dark
  static const Color tertiaryDark = Color(0xFF2980B9);

  /// Tertiary container
  static const Color tertiaryContainer = Color(0xFFD6EAF8);

  /// On tertiary
  static const Color onTertiary = Color(0xFFFFFFFF);

  /// On tertiary container
  static const Color onTertiaryContainer = Color(0xFF1B4F72);

  // ====================
  // Accent Colors (Animal-Inspired)
  // ====================

  /// Flamingo pink - Playful accent
  static const Color accentPink = Color(0xFFFF6B9D);

  /// Canary yellow - Bright highlight
  static const Color accentYellow = Color(0xFFFFC107);

  /// Coral reef - Warm accent
  static const Color accentCoral = Color(0xFFFF7F7F);

  /// Lavender - Calm accent
  static const Color accentLavender = Color(0xFFB39DDB);

  /// Teal - Nature accent
  static const Color accentTeal = Color(0xFF26A69A);

  // ====================
  // Background & Surface
  // ====================

  /// App background - Warm cream with slight green tint
  static const Color background = Color(0xFFF8FBF8);

  /// Surface - Pure white
  static const Color surface = Color(0xFFFFFFFF);

  /// Surface variant - Soft sage
  static const Color surfaceVariant = Color(0xFFF0F7F0);

  /// Surface elevated - Slight shadow
  static const Color surfaceElevated = Color(0xFFFFFFFF);

  /// On background - primary text on background
  static const Color onBackground = Color(0xFF1A2E1A);

  /// On surface - text on surface
  static const Color onSurface = Color(0xFF1A2E1A);

  /// On surface variant - secondary text
  static const Color onSurfaceVariant = Color(0xFF5A6B5A);

  // ====================
  // Pastel Card Backgrounds (Zoo Animal Inspired)
  // ====================

  /// Flamingo pink card
  static const Color cardPink = Color(0xFFFFE4EC);

  /// Canary yellow card
  static const Color cardYellow = Color(0xFFFFF9E6);

  /// Parrot blue card
  static const Color cardBlue = Color(0xFFE6F4FF);

  /// Frog green card
  static const Color cardGreen = Color(0xFFE6FFF0);

  /// Butterfly purple card
  static const Color cardPurple = Color(0xFFF3E8FF);

  /// Peach/coral card
  static const Color cardCoral = Color(0xFFFFEDE6);

  /// Mint card
  static const Color cardMint = Color(0xFFE6FFF8);

  // ====================
  // Semantic Colors
  // ====================

  /// Success - Vibrant green
  static const Color success = Color(0xFF27AE60);
  static const Color onSuccess = Color(0xFFFFFFFF);
  static const Color successLight = Color(0xFFD4EFDF);
  static const Color successContainer = Color(0xFFE8F8F0);

  /// Warning - Warm amber
  static const Color warning = Color(0xFFF39C12);
  static const Color onWarning = Color(0xFFFFFFFF);
  static const Color warningLight = Color(0xFFFCF3CF);
  static const Color warningContainer = Color(0xFFFEF9E7);

  /// Error - Soft coral red
  static const Color error = Color(0xFFE74C3C);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorLight = Color(0xFFFADBD8);
  static const Color errorContainer = Color(0xFFFDEDEC);

  /// Info - Sky blue
  static const Color info = Color(0xFF3498DB);
  static const Color onInfo = Color(0xFFFFFFFF);
  static const Color infoLight = Color(0xFFD4E6F1);
  static const Color infoContainer = Color(0xFFEBF5FB);

  // ====================
  // Neutral Colors
  // ====================

  /// Black - Primary text (slightly green tinted)
  static const Color black = Color(0xFF1A2E1A);

  /// Grey scale with nature tint
  static const Color grey800 = Color(0xFF2D3D2D);
  static const Color grey700 = Color(0xFF445544);
  static const Color grey600 = Color(0xFF5A6B5A);
  static const Color grey500 = Color(0xFF728272);
  static const Color grey400 = Color(0xFF8A998A);
  static const Color grey300 = Color(0xFFA8B8A8);
  static const Color grey200 = Color(0xFFC5D5C5);
  static const Color grey100 = Color(0xFFE0EBE0);
  static const Color grey50 = Color(0xFFF2F7F2);

  /// White
  static const Color white = Color(0xFFFFFFFF);

  // ====================
  // Outline & Dividers
  // ====================

  /// Outline color for borders
  static const Color outline = Color(0xFFD0E0D0);

  /// Outline variant - lighter borders
  static const Color outlineVariant = Color(0xFFE8F0E8);

  /// Divider color
  static const Color divider = Color(0xFFE8F0E8);

  // ====================
  // Shadow Colors
  // ====================

  /// Shadow color with opacity
  static Color shadow = const Color(0xFF1A2E1A).withAlpha(20);

  /// Shadow color for elevated components
  static Color shadowElevated = const Color(0xFF1A2E1A).withAlpha(35);

  /// Shadow color for primary elements
  static Color primaryShadow = primary.withAlpha(60);

  // ====================
  // Gradient Presets
  // ====================

  /// Primary gradient - lush jungle
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Vibrant gradient - tropical sunrise
  static const LinearGradient sunriseGradient = LinearGradient(
    colors: [secondary, accentYellow],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Ocean gradient - tropical waters
  static const LinearGradient oceanGradient = LinearGradient(
    colors: [tertiary, accentTeal],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Pastel gradient - soft nature
  static const LinearGradient pastelGradient = LinearGradient(
    colors: [cardMint, cardYellow],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Sunset gradient - warm evening
  static const LinearGradient sunsetGradient = LinearGradient(
    colors: [accentCoral, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Forest gradient - deep nature
  static const LinearGradient forestGradient = LinearGradient(
    colors: [primaryDark, primary],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  /// Rainbow gradient - playful zoo
  static const LinearGradient rainbowGradient = LinearGradient(
    colors: [accentPink, accentLavender, tertiary, primary, accentYellow],
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
    final colors = [
      cardPink,
      cardYellow,
      cardBlue,
      cardGreen,
      cardPurple,
      cardCoral,
      cardMint,
    ];
    return colors[index % colors.length];
  }

  /// Get animal accent color based on index
  static Color getAnimalAccent(int index) {
    final colors = [
      accentPink, // Flamingo
      secondary, // Tiger
      tertiary, // Parrot
      primary, // Frog
      accentLavender, // Butterfly
      accentCoral, // Goldfish
      accentTeal, // Turtle
    ];
    return colors[index % colors.length];
  }

  /// Create a shimmer gradient for loading states
  static LinearGradient shimmerGradient = LinearGradient(
    colors: [
      grey100,
      grey50,
      grey100,
    ],
    stops: const [0.0, 0.5, 1.0],
    begin: const Alignment(-1.0, -0.3),
    end: const Alignment(1.0, 0.3),
  );
}
