import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/oisely_colors.dart';
import '../core/oisely_shapes.dart';
import '../core/oisely_spacing.dart';
import '../core/oisely_typography.dart';

/// Oisely Design System - Main Theme Configuration
class OiselyTheme {
  OiselyTheme._();

  /// Light Theme
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      // Color Scheme
      colorScheme: const ColorScheme.light(
        primary: OiselyColors.primary,
        onPrimary: OiselyColors.onPrimary,
        secondary: OiselyColors.secondary,
        onSecondary: OiselyColors.onSecondary,
        tertiary: OiselyColors.tertiary,
        onTertiary: OiselyColors.onTertiary,
        surface: OiselyColors.surface,
        onSurface: OiselyColors.onSurface,
        surfaceContainerHighest: OiselyColors.surfaceVariant,
        error: OiselyColors.error,
        onError: OiselyColors.onError,
        outline: OiselyColors.outline,
      ),

      // Scaffold
      scaffoldBackgroundColor: OiselyColors.background,

      // App Bar
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: OiselyColors.background,
        titleTextStyle: OiselyTypography.appBarTitle.copyWith(
          color: OiselyColors.onBackground,
        ),
        iconTheme: const IconThemeData(
          color: OiselyColors.onBackground,
        ),
      ),

      // Card
      cardTheme: CardThemeData(
        elevation: 0,
        color: OiselyColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(OiselyShapes.cardRadius),
        ),
      ),

      // Button - Filled
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: OiselyColors.primary,
          foregroundColor: OiselyColors.onPrimary,
          padding: const EdgeInsets.symmetric(
            horizontal: OiselySpacing.lg,
            vertical: OiselySpacing.md,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(OiselyShapes.buttonRadius),
          ),
          textStyle: OiselyTypography.button,
        ),
      ),

      // Button - Elevated
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: OiselyColors.primary,
          foregroundColor: OiselyColors.onPrimary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: OiselySpacing.lg,
            vertical: OiselySpacing.md,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(OiselyShapes.buttonRadius),
          ),
          textStyle: OiselyTypography.button,
        ),
      ),

      // Button - Outlined
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: OiselyColors.primary,
          side: const BorderSide(color: OiselyColors.primary),
          padding: const EdgeInsets.symmetric(
            horizontal: OiselySpacing.lg,
            vertical: OiselySpacing.md,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(OiselyShapes.buttonRadius),
          ),
          textStyle: OiselyTypography.button,
        ),
      ),

      // Button - Text
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: OiselyColors.primary,
          padding: const EdgeInsets.symmetric(
            horizontal: OiselySpacing.md,
            vertical: OiselySpacing.sm,
          ),
          textStyle: OiselyTypography.button,
        ),
      ),

      // Chip
      chipTheme: ChipThemeData(
        backgroundColor: OiselyColors.surfaceVariant,
        selectedColor: OiselyColors.primary,
        labelStyle: OiselyTypography.chip,
        padding: const EdgeInsets.symmetric(
          horizontal: OiselySpacing.sm,
          vertical: OiselySpacing.xs,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(OiselyShapes.chipRadius),
        ),
        side: BorderSide.none,
      ),

      // Input
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: OiselyColors.surfaceVariant,
        contentPadding: const EdgeInsets.all(OiselySpacing.md),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(OiselyShapes.inputRadius),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(OiselyShapes.inputRadius),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(OiselyShapes.inputRadius),
          borderSide: const BorderSide(color: OiselyColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(OiselyShapes.inputRadius),
          borderSide: const BorderSide(color: OiselyColors.error, width: 2),
        ),
        labelStyle: OiselyTypography.label.copyWith(
          color: OiselyColors.onSurfaceVariant,
        ),
      ),

      // Text
      textTheme: TextTheme(
        displayLarge: OiselyTypography.h1,
        displayMedium: OiselyTypography.h2,
        displaySmall: OiselyTypography.h3,
        headlineLarge: OiselyTypography.h3,
        headlineMedium: OiselyTypography.h4,
        headlineSmall: OiselyTypography.h5,
        titleLarge: OiselyTypography.h5,
        titleMedium: OiselyTypography.h6,
        titleSmall: OiselyTypography.label,
        bodyLarge: OiselyTypography.bodyLarge,
        bodyMedium: OiselyTypography.bodyMedium,
        bodySmall: OiselyTypography.bodySmall,
        labelLarge: OiselyTypography.button,
        labelMedium: OiselyTypography.label,
        labelSmall: OiselyTypography.caption,
      ),

      // Bottom Sheet
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      // Dialog
      dialogTheme: DialogThemeData(
        backgroundColor: OiselyColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(OiselyShapes.radiusLarge),
        ),
      ),

      // Snack Bar
      snackBarTheme: SnackBarThemeData(
        backgroundColor: OiselyColors.grey800,
        contentTextStyle: OiselyTypography.bodyMedium.copyWith(
          color: OiselyColors.white,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(OiselyShapes.radiusMedium),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
