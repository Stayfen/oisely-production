import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../design_system/core/oisely_colors.dart';
import '../design_system/core/oisely_shapes.dart';

/// A beautiful full-screen loading overlay with animated paw prints
class LoadingOverlay extends StatelessWidget {
  final String message;
  final bool isVisible;
  final String? subtitle;

  const LoadingOverlay({
    super.key,
    this.message = 'Processing Image',
    this.isVisible = false,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    if (!isVisible) return const SizedBox.shrink();

    return Container(
      color: Colors.black.withAlpha(140),
      child: Center(
        child:
            Container(
                  margin: const EdgeInsets.all(32),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 36,
                  ),
                  decoration: BoxDecoration(
                    color: OiselyColors.surface,
                    borderRadius: BorderRadius.circular(
                      OiselyShapes.modalRadius,
                    ),
                    boxShadow: OiselyShapes.strongShadow,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Animated paw loader
                      _AnimatedPawLoader(),
                      const SizedBox(height: 28),
                      // Message with typing animation
                      Text(
                            message,
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: OiselyColors.onSurface,
                            ),
                          )
                          .animate()
                          .fadeIn(duration: 400.ms)
                          .moveY(begin: 10, end: 0, duration: 400.ms),
                      if (subtitle != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          subtitle!,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: OiselyColors.onSurfaceVariant,
                          ),
                          textAlign: TextAlign.center,
                        ).animate().fadeIn(delay: 200.ms, duration: 400.ms),
                      ],
                      const SizedBox(height: 20),
                      // Progress dots
                      _AnimatedDots(),
                    ],
                  ),
                )
                .animate()
                .fadeIn(duration: 300.ms)
                .scale(
                  begin: const Offset(0.9, 0.9),
                  end: const Offset(1, 1),
                  duration: 300.ms,
                  curve: Curves.easeOut,
                ),
      ),
    );
  }
}

/// Animated paw print loader
class _AnimatedPawLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer rotating ring
          SizedBox(
            width: 80,
            height: 80,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(
                OiselyColors.primary.withAlpha(100),
              ),
            ),
          ).animate(onPlay: (c) => c.repeat()).rotate(duration: 2000.ms),
          // Inner gradient circle
          Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      OiselyColors.primaryContainer,
                      OiselyColors.cardGreen,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.pets,
                  size: 32,
                  color: OiselyColors.primary,
                ),
              )
              .animate(onPlay: (c) => c.repeat())
              .scale(
                begin: const Offset(1, 1),
                end: const Offset(1.15, 1.15),
                duration: 800.ms,
                curve: Curves.easeInOut,
              )
              .then()
              .scale(
                begin: const Offset(1.15, 1.15),
                end: const Offset(1, 1),
                duration: 800.ms,
                curve: Curves.easeInOut,
              ),
        ],
      ),
    );
  }
}

/// Animated loading dots
class _AnimatedDots extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        return Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: OiselyColors.primary,
                shape: BoxShape.circle,
              ),
            )
            .animate(onPlay: (c) => c.repeat())
            .fadeIn(delay: Duration(milliseconds: index * 200))
            .scale(
              begin: const Offset(0.5, 0.5),
              end: const Offset(1, 1),
              delay: Duration(milliseconds: index * 200),
              duration: 600.ms,
              curve: Curves.easeInOut,
            )
            .then()
            .scale(
              begin: const Offset(1, 1),
              end: const Offset(0.5, 0.5),
              duration: 600.ms,
              curve: Curves.easeInOut,
            );
      }),
    );
  }
}

/// A widget that wraps its child and displays a loading overlay when [isLoading] is true
class LoadingOverlayWrapper extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final String message;
  final String? subtitle;

  const LoadingOverlayWrapper({
    super.key,
    required this.child,
    required this.isLoading,
    this.message = 'Processing Image',
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Positioned.fill(
            child: LoadingOverlay(
              isVisible: isLoading,
              message: message,
              subtitle: subtitle,
            ),
          ),
      ],
    );
  }
}

/// Minimal inline loader for buttons and small areas
class OiselyInlineLoader extends StatelessWidget {
  final double size;
  final Color? color;

  const OiselyInlineLoader({
    super.key,
    this.size = 20,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: 2.5,
        valueColor: AlwaysStoppedAnimation<Color>(
          color ?? OiselyColors.onPrimary,
        ),
      ),
    );
  }
}

/// Skeleton loader for card content
class OiselySkeletonCard extends StatelessWidget {
  final double width;
  final double height;

  const OiselySkeletonCard({
    super.key,
    this.width = 140,
    this.height = 180,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
          width: width,
          height: height,
          margin: const EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            color: OiselyColors.grey100,
            borderRadius: BorderRadius.circular(OiselyShapes.cardRadius),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image placeholder
              Container(
                height: height * 0.65,
                decoration: BoxDecoration(
                  color: OiselyColors.grey200,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(OiselyShapes.cardRadius),
                  ),
                ),
              ),
              // Content placeholder
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 12,
                      width: width * 0.7,
                      decoration: BoxDecoration(
                        color: OiselyColors.grey200,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 10,
                      width: width * 0.5,
                      decoration: BoxDecoration(
                        color: OiselyColors.grey200,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
        .animate(onPlay: (c) => c.repeat())
        .shimmer(
          duration: 1500.ms,
          color: OiselyColors.grey50.withAlpha(200),
        );
  }
}
