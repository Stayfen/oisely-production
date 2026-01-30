import 'package:flutter/material.dart';
import '../core/oisely_colors.dart';
import '../core/oisely_shapes.dart';
import '../core/oisely_spacing.dart';
import '../core/oisely_typography.dart';

/// Oisely Design System - Main Theme Configuration
/// A vibrant "home zoo" themed design with playful, nature-inspired elements
class OiselyTheme {
  OiselyTheme._();

  /// Light Theme - Primary theme for the app
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      // Color Scheme - Vibrant nature theme
      colorScheme: const ColorScheme.light(
        primary: OiselyColors.primary,
        onPrimary: OiselyColors.onPrimary,
        primaryContainer: OiselyColors.primaryContainer,
        onPrimaryContainer: OiselyColors.onPrimaryContainer,
        secondary: OiselyColors.secondary,
        onSecondary: OiselyColors.onSecondary,
        secondaryContainer: OiselyColors.secondaryContainer,
        onSecondaryContainer: OiselyColors.onSecondaryContainer,
        tertiary: OiselyColors.tertiary,
        onTertiary: OiselyColors.onTertiary,
        tertiaryContainer: OiselyColors.tertiaryContainer,
        onTertiaryContainer: OiselyColors.onTertiaryContainer,
        surface: OiselyColors.surface,
        onSurface: OiselyColors.onSurface,
        surfaceContainerHighest: OiselyColors.surfaceVariant,
        error: OiselyColors.error,
        onError: OiselyColors.onError,
        errorContainer: OiselyColors.errorContainer,
        outline: OiselyColors.outline,
        outlineVariant: OiselyColors.outlineVariant,
      ),

      // Scaffold
      scaffoldBackgroundColor: OiselyColors.background,

      // App Bar - Clean with subtle shadow
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 2,
        backgroundColor: OiselyColors.background,
        surfaceTintColor: Colors.transparent,
        shadowColor: OiselyColors.shadow,
        titleTextStyle: OiselyTypography.appBarTitle.copyWith(
          color: OiselyColors.onBackground,
        ),
        iconTheme: const IconThemeData(
          color: OiselyColors.onBackground,
          size: 24,
        ),
      ),

      // Card - Elevated with soft shadow
      cardTheme: CardThemeData(
        elevation: 0,
        color: OiselyColors.surface,
        shadowColor: OiselyColors.shadow,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(OiselyShapes.cardRadius),
        ),
        margin: EdgeInsets.zero,
      ),

      // Button - Filled (Primary action)
      filledButtonTheme: FilledButtonThemeData(
        style:
            FilledButton.styleFrom(
              backgroundColor: OiselyColors.primary,
              foregroundColor: OiselyColors.onPrimary,
              disabledBackgroundColor: OiselyColors.grey300,
              disabledForegroundColor: OiselyColors.grey500,
              elevation: 0,
              padding: const EdgeInsets.symmetric(
                horizontal: OiselySpacing.xl,
                vertical: OiselySpacing.md,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(OiselyShapes.buttonRadius),
              ),
              textStyle: OiselyTypography.button,
              minimumSize: const Size(88, 52),
            ).copyWith(
              overlayColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.pressed)) {
                  return OiselyColors.primaryDark.withAlpha(30);
                }
                if (states.contains(WidgetState.hovered)) {
                  return OiselyColors.primaryLight.withAlpha(20);
                }
                return null;
              }),
            ),
      ),

      // Button - Elevated (Secondary action)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: OiselyColors.primary,
          foregroundColor: OiselyColors.onPrimary,
          elevation: 2,
          shadowColor: OiselyColors.primaryShadow,
          padding: const EdgeInsets.symmetric(
            horizontal: OiselySpacing.xl,
            vertical: OiselySpacing.md,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(OiselyShapes.buttonRadius),
          ),
          textStyle: OiselyTypography.button,
          minimumSize: const Size(88, 52),
        ),
      ),

      // Button - Outlined
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: OiselyColors.primary,
          side: const BorderSide(color: OiselyColors.primary, width: 1.5),
          padding: const EdgeInsets.symmetric(
            horizontal: OiselySpacing.xl,
            vertical: OiselySpacing.md,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(OiselyShapes.buttonRadius),
          ),
          textStyle: OiselyTypography.button,
          minimumSize: const Size(88, 52),
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(OiselyShapes.radiusMedium),
          ),
        ),
      ),

      // Icon Button
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: OiselyColors.onSurface,
          highlightColor: OiselyColors.primaryLight.withAlpha(30),
        ),
      ),

      // Floating Action Button
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: OiselyColors.primary,
        foregroundColor: OiselyColors.onPrimary,
        elevation: 4,
        highlightElevation: 8,
        shape: const CircleBorder(),
        splashColor: OiselyColors.primaryLight.withAlpha(50),
      ),

      // Chip - Playful rounded style
      chipTheme: ChipThemeData(
        backgroundColor: OiselyColors.surfaceVariant,
        selectedColor: OiselyColors.primaryContainer,
        secondarySelectedColor: OiselyColors.secondaryContainer,
        labelStyle: OiselyTypography.chip,
        secondaryLabelStyle: OiselyTypography.chip,
        padding: const EdgeInsets.symmetric(
          horizontal: OiselySpacing.md,
          vertical: OiselySpacing.sm,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(OiselyShapes.radiusFull),
        ),
        side: BorderSide.none,
        elevation: 0,
        pressElevation: 2,
      ),

      // Input - Rounded with subtle fill
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: OiselyColors.surfaceVariant,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: OiselySpacing.lg,
          vertical: OiselySpacing.md,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(OiselyShapes.inputRadius),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(OiselyShapes.inputRadius),
          borderSide: const BorderSide(color: OiselyColors.outline, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(OiselyShapes.inputRadius),
          borderSide: const BorderSide(color: OiselyColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(OiselyShapes.inputRadius),
          borderSide: const BorderSide(color: OiselyColors.error, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(OiselyShapes.inputRadius),
          borderSide: const BorderSide(color: OiselyColors.error, width: 2),
        ),
        labelStyle: OiselyTypography.label.copyWith(
          color: OiselyColors.onSurfaceVariant,
        ),
        hintStyle: OiselyTypography.bodyMedium.copyWith(
          color: OiselyColors.grey400,
        ),
        prefixIconColor: OiselyColors.grey500,
        suffixIconColor: OiselyColors.grey500,
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

      // Switch - Nature green
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return OiselyColors.primary;
          }
          return OiselyColors.grey400;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return OiselyColors.primaryLight;
          }
          return OiselyColors.grey200;
        }),
        trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
      ),

      // Checkbox
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return OiselyColors.primary;
          }
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(OiselyColors.onPrimary),
        side: const BorderSide(color: OiselyColors.grey400, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),

      // Radio
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return OiselyColors.primary;
          }
          return OiselyColors.grey400;
        }),
      ),

      // Progress Indicator - Vibrant green
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: OiselyColors.primary,
        linearTrackColor: OiselyColors.primaryLighter,
        circularTrackColor: OiselyColors.primaryLighter,
      ),

      // Slider
      sliderTheme: SliderThemeData(
        activeTrackColor: OiselyColors.primary,
        inactiveTrackColor: OiselyColors.grey200,
        thumbColor: OiselyColors.primary,
        overlayColor: OiselyColors.primary.withAlpha(30),
        valueIndicatorColor: OiselyColors.primary,
        valueIndicatorTextStyle: OiselyTypography.label.copyWith(
          color: OiselyColors.onPrimary,
        ),
      ),

      // Tab Bar
      tabBarTheme: TabBarThemeData(
        labelColor: OiselyColors.primary,
        unselectedLabelColor: OiselyColors.grey500,
        indicatorColor: OiselyColors.primary,
        indicatorSize: TabBarIndicatorSize.label,
        labelStyle: OiselyTypography.button,
        unselectedLabelStyle: OiselyTypography.bodyMedium,
        dividerColor: Colors.transparent,
      ),

      // Bottom Sheet - Rounded top corners
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: OiselyColors.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 8,
        shadowColor: OiselyColors.shadow,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(OiselyShapes.bottomSheetRadius),
          ),
        ),
        dragHandleColor: OiselyColors.grey300,
        dragHandleSize: const Size(40, 4),
      ),

      // Dialog - Rounded with soft shadow
      dialogTheme: DialogThemeData(
        backgroundColor: OiselyColors.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 8,
        shadowColor: OiselyColors.shadow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(OiselyShapes.radiusXLarge),
        ),
        titleTextStyle: OiselyTypography.h4.copyWith(
          color: OiselyColors.onSurface,
        ),
        contentTextStyle: OiselyTypography.bodyMedium.copyWith(
          color: OiselyColors.onSurfaceVariant,
        ),
      ),

      // Snack Bar - Floating with rounded corners
      snackBarTheme: SnackBarThemeData(
        backgroundColor: OiselyColors.grey800,
        contentTextStyle: OiselyTypography.bodyMedium.copyWith(
          color: OiselyColors.white,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(OiselyShapes.radiusMedium),
        ),
        behavior: SnackBarBehavior.floating,
        elevation: 4,
        actionTextColor: OiselyColors.primaryLight,
      ),

      // Divider
      dividerTheme: const DividerThemeData(
        color: OiselyColors.divider,
        thickness: 1,
        space: 1,
      ),

      // List Tile
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: OiselySpacing.md,
          vertical: OiselySpacing.xs,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(OiselyShapes.radiusMedium),
        ),
        iconColor: OiselyColors.primary,
        titleTextStyle: OiselyTypography.bodyLarge.copyWith(
          color: OiselyColors.onSurface,
          fontWeight: FontWeight.w500,
        ),
        subtitleTextStyle: OiselyTypography.bodySmall.copyWith(
          color: OiselyColors.onSurfaceVariant,
        ),
      ),

      // Navigation Bar
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: OiselyColors.surface,
        indicatorColor: OiselyColors.primaryContainer,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return OiselyTypography.label.copyWith(
              color: OiselyColors.primary,
              fontWeight: FontWeight.w600,
            );
          }
          return OiselyTypography.label.copyWith(
            color: OiselyColors.grey500,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(
              color: OiselyColors.primary,
              size: 24,
            );
          }
          return const IconThemeData(
            color: OiselyColors.grey500,
            size: 24,
          );
        }),
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),

      // Tooltip
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: OiselyColors.grey800,
          borderRadius: BorderRadius.circular(OiselyShapes.radiusSmall),
        ),
        textStyle: OiselyTypography.caption.copyWith(
          color: OiselyColors.white,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: OiselySpacing.md,
          vertical: OiselySpacing.sm,
        ),
      ),

      // Page transitions - Smooth curves
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
        },
      ),

      // Visual density
      visualDensity: VisualDensity.adaptivePlatformDensity,

      // Splash factory for ink effects
      splashFactory: InkSparkle.splashFactory,
    );
  }
}
