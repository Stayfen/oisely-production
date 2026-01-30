import 'package:flutter/material.dart';

/// Oisely Design System - Shape Tokens
/// Rounded, friendly shapes for a playful "home zoo" feel
class OiselyShapes {
  OiselyShapes._();

  // Border radius values - More rounded for playful feel
  static const double radiusNone = 0.0;
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;
  static const double radiusXLarge = 24.0;
  static const double radiusXXLarge = 32.0;
  static const double radiusFull = 999.0;

  // Component-specific radii - Enhanced for modern look
  static const double cardRadius = 20.0;
  static const double buttonRadius = 16.0;
  static const double chipRadius = 20.0;
  static const double inputRadius = 16.0;
  static const double avatarRadius = 50.0;
  static const double bottomSheetRadius = 28.0;
  static const double modalRadius = 24.0;
  static const double imageRadius = 16.0;
  static const double badgeRadius = 12.0;

  // Shadow configurations for depth
  static List<BoxShadow> get softShadow => [
    BoxShadow(
      color: const Color(0xFF1A2E1A).withAlpha(15),
      blurRadius: 10,
      offset: const Offset(0, 4),
      spreadRadius: 0,
    ),
  ];

  static List<BoxShadow> get mediumShadow => [
    BoxShadow(
      color: const Color(0xFF1A2E1A).withAlpha(20),
      blurRadius: 16,
      offset: const Offset(0, 6),
      spreadRadius: 0,
    ),
  ];

  static List<BoxShadow> get strongShadow => [
    BoxShadow(
      color: const Color(0xFF1A2E1A).withAlpha(25),
      blurRadius: 24,
      offset: const Offset(0, 8),
      spreadRadius: 0,
    ),
  ];

  // Colored shadows for primary elements
  static List<BoxShadow> primaryShadow(Color color) => [
    BoxShadow(
      color: color.withAlpha(60),
      blurRadius: 16,
      offset: const Offset(0, 6),
      spreadRadius: 0,
    ),
  ];

  // Glassmorphism decoration
  static BoxDecoration get glassDecoration => BoxDecoration(
    color: Colors.white.withAlpha(200),
    borderRadius: BorderRadius.circular(radiusLarge),
    border: Border.all(
      color: Colors.white.withAlpha(50),
      width: 1.5,
    ),
    boxShadow: softShadow,
  );
}
