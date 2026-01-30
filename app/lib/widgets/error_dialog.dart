import 'package:flutter/material.dart';

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
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(51),
            blurRadius: 10,
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
                color: colorScheme.outline.withAlpha(128),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            // Error icon
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: colorScheme.errorContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                type.icon,
                size: 40,
                color: colorScheme.onErrorContainer,
              ),
            ),
            const SizedBox(height: 24),
            // Title
            Text(
              type.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            // Message
            Text(
              customMessage ?? type.message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 32),
            // Action buttons
            if (onRetry != null) ...[
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop();
                    onRetry!();
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Try Again'),
                ),
              ),
              const SizedBox(height: 12),
            ],
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Dismiss'),
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
