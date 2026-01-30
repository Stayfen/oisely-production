import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../design_system/core/oisely_colors.dart';
import '../design_system/core/oisely_spacing.dart';

/// Types of errors that can occur during image processing
enum ErrorType {
  network,
  timeout,
  invalidFormat,
  permissionDenied,
  serverError,
  unknown,
}

/// Extension to get user-friendly error messages
extension ErrorTypeExtension on ErrorType {
  String get title {
    switch (this) {
      case ErrorType.network:
        return 'Network Error';
      case ErrorType.timeout:
        return 'Request Timeout';
      case ErrorType.invalidFormat:
        return 'Invalid Image';
      case ErrorType.permissionDenied:
        return 'Permission Denied';
      case ErrorType.serverError:
        return 'Server Error';
      case ErrorType.unknown:
        return 'Something Went Wrong';
    }
  }

  String get emoji {
    switch (this) {
      case ErrorType.network:
        return '📡';
      case ErrorType.timeout:
        return '⏰';
      case ErrorType.invalidFormat:
        return '🖼️';
      case ErrorType.permissionDenied:
        return '🔐';
      case ErrorType.serverError:
        return '🔧';
      case ErrorType.unknown:
        return '😕';
    }
  }

  String get message {
    switch (this) {
      case ErrorType.network:
        return 'Please check your internet connection and try again.';
      case ErrorType.timeout:
        return 'The request took too long. Please try again later.';
      case ErrorType.invalidFormat:
        return 'The selected image format is not supported or the file is corrupted.';
      case ErrorType.permissionDenied:
        return 'Permission to access photos or camera was denied. Please enable it in settings.';
      case ErrorType.serverError:
        return 'We encountered a problem on our end. Please try again later.';
      case ErrorType.unknown:
        return 'An unexpected error occurred. Please try again.';
    }
  }

  IconData get icon {
    switch (this) {
      case ErrorType.network:
        return Icons.wifi_off_outlined;
      case ErrorType.timeout:
        return Icons.timer_off_outlined;
      case ErrorType.invalidFormat:
        return Icons.broken_image_outlined;
      case ErrorType.permissionDenied:
        return Icons.lock_outline;
      case ErrorType.serverError:
        return Icons.cloud_off_outlined;
      case ErrorType.unknown:
        return Icons.error_outline;
    }
  }

  Color get color {
    switch (this) {
      case ErrorType.network:
        return OiselyColors.tertiary;
      case ErrorType.timeout:
        return OiselyColors.secondary;
      case ErrorType.invalidFormat:
        return OiselyColors.accentCoral;
      case ErrorType.permissionDenied:
        return OiselyColors.accentLavender;
      case ErrorType.serverError:
        return OiselyColors.error;
      case ErrorType.unknown:
        return OiselyColors.error;
    }
  }
}

/// Shows an error modal bottom sheet
void showErrorModal({
  required BuildContext context,
  required ErrorType type,
  String? customMessage,
  VoidCallback? onRetry,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) => ErrorModalContent(
      type: type,
      customMessage: customMessage,
      onRetry: onRetry,
    ),
  );
}

/// Error modal content widget
class ErrorModalContent extends StatelessWidget {
  final ErrorType type;
  final String? customMessage;
  final VoidCallback? onRetry;

  const ErrorModalContent({
    super.key,
    required this.type,
    this.customMessage,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(OiselySpacing.xl),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(30),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: OiselyColors.outline.withAlpha(127),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: OiselySpacing.xl),
            // Error icon with animation
            Container(
                  width: 88,
                  height: 88,
                  decoration: BoxDecoration(
                    color: type.color.withAlpha(25),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: type.color.withAlpha(60),
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      type.icon,
                      size: 42,
                      color: type.color,
                    ),
                  ),
                )
                .animate()
                .scale(
                  begin: const Offset(0.5, 0.5),
                  end: const Offset(1, 1),
                  duration: 400.ms,
                  curve: Curves.elasticOut,
                )
                .then()
                .shakeX(hz: 2, amount: 3, duration: 300.ms),
            const SizedBox(height: OiselySpacing.xl),
            // Title with emoji
            Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(type.emoji, style: const TextStyle(fontSize: 24)),
                    const SizedBox(width: 8),
                    Text(
                      type.title,
                      style: GoogleFonts.inter(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
                .animate()
                .fadeIn(delay: 100.ms, duration: 300.ms)
                .moveY(begin: 10, end: 0, duration: 300.ms),
            const SizedBox(height: OiselySpacing.md),
            // Message
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: OiselySpacing.md),
              child: Text(
                customMessage ?? type.message,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 15,
                  color: OiselyColors.onSurfaceVariant,
                  height: 1.5,
                ),
              ),
            ).animate().fadeIn(delay: 200.ms, duration: 300.ms),
            const SizedBox(height: OiselySpacing.xl),
            // Action buttons
            if (onRetry != null) ...[
              _RetryButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      onRetry!();
                    },
                  )
                  .animate()
                  .fadeIn(delay: 300.ms, duration: 300.ms)
                  .moveY(begin: 10, end: 0, duration: 300.ms),
              const SizedBox(height: OiselySpacing.sm),
            ],
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: BorderSide(color: OiselyColors.outline),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  'Dismiss',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ).animate().fadeIn(delay: 400.ms, duration: 300.ms),
          ],
        ),
      ),
    );
  }
}

/// Retry button with gradient styling
class _RetryButton extends StatefulWidget {
  final VoidCallback onPressed;

  const _RetryButton({required this.onPressed});

  @override
  State<_RetryButton> createState() => _RetryButtonState();
}

class _RetryButtonState extends State<_RetryButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: double.infinity,
        height: 54,
        decoration: BoxDecoration(
          gradient: OiselyColors.primaryGradient,
          borderRadius: BorderRadius.circular(14),
          boxShadow: _isPressed
              ? []
              : [
                  BoxShadow(
                    color: OiselyColors.primary.withAlpha(80),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        transform: Matrix4.identity()..scale(_isPressed ? 0.98 : 1.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.refresh_rounded, color: Colors.white, size: 22),
            const SizedBox(width: 10),
            Text(
              'Try Again',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Helper function to determine error type from exception
ErrorType getErrorType(dynamic error) {
  final errorString = error.toString().toLowerCase();

  if (errorString.contains('socket') ||
      errorString.contains('connection') ||
      errorString.contains('network') ||
      errorString.contains('internet')) {
    return ErrorType.network;
  }

  if (errorString.contains('timeout')) {
    return ErrorType.timeout;
  }

  if (errorString.contains('permission') ||
      errorString.contains('denied') ||
      errorString.contains('access')) {
    return ErrorType.permissionDenied;
  }

  if (errorString.contains('format') ||
      errorString.contains('invalid image') ||
      errorString.contains('unsupported')) {
    return ErrorType.invalidFormat;
  }

  if (errorString.contains('server') ||
      errorString.contains('500') ||
      errorString.contains('internal')) {
    return ErrorType.serverError;
  }

  return ErrorType.unknown;
}
