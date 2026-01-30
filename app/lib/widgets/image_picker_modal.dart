import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../design_system/core/oisely_colors.dart';
import '../design_system/core/oisely_shapes.dart';
import '../design_system/core/oisely_spacing.dart';

/// Modal bottom sheet for selecting image source (Gallery or Camera)
class ImagePickerModal extends StatelessWidget {
  final Function(File imageFile) onImageSelected;
  final VoidCallback? onPermissionDenied;

  const ImagePickerModal({
    super.key,
    required this.onImageSelected,
    this.onPermissionDenied,
  });

  /// Shows the image picker modal as a bottom sheet
  static Future<void> show({
    required BuildContext context,
    required Function(File imageFile) onImageSelected,
    VoidCallback? onPermissionDenied,
  }) async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => ImagePickerModal(
        onImageSelected: onImageSelected,
        onPermissionDenied: onPermissionDenied,
      ),
    );
  }

  Future<void> _pickImage(ImageSource source, BuildContext context) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(
        source: source,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        final file = File(pickedFile.path);

        // Validate file size (max 10MB)
        final fileSize = await file.length();
        if (fileSize > 10 * 1024 * 1024) {
          if (context.mounted) {
            _showErrorSnackBar(context, 'Image size exceeds 10MB limit');
          }
          return;
        }

        if (context.mounted) {
          Navigator.of(context).pop();
          onImageSelected(file);
        }
      }
    } on Exception catch (e) {
      final errorString = e.toString();
      if (errorString.contains('permission') ||
          errorString.contains('denied') ||
          errorString.contains('access')) {
        onPermissionDenied?.call();
        if (context.mounted) {
          _showPermissionError(context);
        }
      } else {
        if (context.mounted) {
          _showErrorSnackBar(context, 'Failed to pick image: $e');
        }
      }
    }
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Text('❌ '),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: OiselyColors.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _showPermissionError(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(OiselySpacing.xl),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: OiselyColors.outline,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: OiselySpacing.xl),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: OiselyColors.error.withAlpha(25),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.lock_outline,
                  size: 40,
                  color: OiselyColors.error,
                ),
              ).animate().scale(
                begin: const Offset(0.5, 0.5),
                end: const Offset(1, 1),
                duration: 400.ms,
                curve: Curves.elasticOut,
              ),
              const SizedBox(height: OiselySpacing.lg),
              Text(
                'Permission Required 🔐',
                style: GoogleFonts.inter(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: OiselySpacing.sm),
              Text(
                'Please grant permission to access your photos or camera in device settings.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 15,
                  color: OiselyColors.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: OiselySpacing.xl),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: FilledButton.styleFrom(
                    backgroundColor: OiselyColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text('Got it'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
            Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('📸 ', style: TextStyle(fontSize: 24)),
                    Text(
                      'Add Pet Photo',
                      style: GoogleFonts.inter(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
                .animate()
                .fadeIn(duration: 300.ms)
                .moveY(begin: -10, end: 0, duration: 300.ms),
            const SizedBox(height: OiselySpacing.sm),
            Text(
              'Choose how you want to add your pet photo',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: OiselyColors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: OiselySpacing.xl),
            // Gallery Upload Button
            _ImagePickerActionButton(
                  icon: Icons.photo_library_outlined,
                  label: 'Photo Gallery',
                  subtitle: 'Select from your device photos',
                  emoji: '🖼️',
                  gradient: LinearGradient(
                    colors: [
                      OiselyColors.tertiary,
                      OiselyColors.tertiary.withAlpha(180),
                    ],
                  ),
                  onTap: () => _pickImage(ImageSource.gallery, context),
                )
                .animate()
                .fadeIn(delay: 100.ms, duration: 300.ms)
                .moveX(begin: -20, end: 0, duration: 300.ms),
            const SizedBox(height: OiselySpacing.md),
            // Camera Capture Button
            _ImagePickerActionButton(
                  icon: Icons.camera_alt_outlined,
                  label: 'Take Photo',
                  subtitle: 'Capture a new photograph',
                  emoji: '📷',
                  gradient: OiselyColors.primaryGradient,
                  onTap: () => _pickImage(ImageSource.camera, context),
                )
                .animate()
                .fadeIn(delay: 200.ms, duration: 300.ms)
                .moveX(begin: -20, end: 0, duration: 300.ms),
            const SizedBox(height: OiselySpacing.lg),
            // Cancel Button
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  foregroundColor: OiselyColors.onSurfaceVariant,
                ),
                child: Text(
                  'Cancel',
                  style: GoogleFonts.inter(fontSize: 16),
                ),
              ),
            ).animate().fadeIn(delay: 300.ms, duration: 300.ms),
          ],
        ),
      ),
    );
  }
}

/// A styled action button for the image picker modal
class _ImagePickerActionButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final String emoji;
  final Gradient gradient;
  final VoidCallback onTap;

  const _ImagePickerActionButton({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.emoji,
    required this.gradient,
    required this.onTap,
  });

  @override
  State<_ImagePickerActionButton> createState() =>
      _ImagePickerActionButtonState();
}

class _ImagePickerActionButtonState extends State<_ImagePickerActionButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          color: OiselyColors.surfaceVariant.withAlpha(100),
          borderRadius: BorderRadius.circular(OiselyShapes.cardRadius),
          border: Border.all(color: OiselyColors.outline.withAlpha(60)),
        ),
        transform: Matrix4.identity()..scale(_isPressed ? 0.98 : 1.0),
        child: Padding(
          padding: const EdgeInsets.all(OiselySpacing.md),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  gradient: widget.gradient,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(30),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  widget.icon,
                  size: 28,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: OiselySpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.emoji,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          widget.label,
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.subtitle,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: OiselyColors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: OiselyColors.surfaceVariant,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: OiselyColors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
