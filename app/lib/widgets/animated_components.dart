import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../design_system/core/oisely_colors.dart';
import '../design_system/core/oisely_shapes.dart';

/// Custom animated loading widget with paw prints
class OiselyLoader extends StatelessWidget {
  final double size;
  final Color? color;
  final String? message;

  const OiselyLoader({
    super.key,
    this.size = 48,
    this.color,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    final loaderColor = color ?? OiselyColors.primary;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: Stack(
            children: [
              // Outer ring
              SizedBox(
                width: size,
                height: size,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    loaderColor.withAlpha(100),
                  ),
                ),
              ),
              // Inner paw icon
              Center(
                child:
                    Icon(
                          Icons.pets,
                          size: size * 0.5,
                          color: loaderColor,
                        )
                        .animate(onPlay: (c) => c.repeat())
                        .scale(
                          begin: const Offset(1, 1),
                          end: const Offset(1.2, 1.2),
                          duration: 600.ms,
                        )
                        .then()
                        .scale(
                          begin: const Offset(1.2, 1.2),
                          end: const Offset(1, 1),
                          duration: 600.ms,
                        ),
              ),
            ],
          ),
        ),
        if (message != null) ...[
          const SizedBox(height: 16),
          Text(
                message!,
                style: TextStyle(
                  color: OiselyColors.onSurfaceVariant,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              )
              .animate(onPlay: (c) => c.repeat())
              .fadeIn(duration: 400.ms)
              .then()
              .fadeOut(duration: 400.ms, delay: 1000.ms),
        ],
      ],
    );
  }
}

/// Animated shimmer placeholder for loading states
class OiselyShimmer extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final Widget? child;

  const OiselyShimmer({
    super.key,
    this.width = double.infinity,
    this.height = 100,
    this.borderRadius = 16,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: OiselyColors.grey100,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: child,
        )
        .animate(onPlay: (c) => c.repeat())
        .shimmer(
          duration: 1500.ms,
          color: OiselyColors.grey50.withAlpha(200),
        );
  }
}

/// Card shimmer placeholder
class OiselyCardShimmer extends StatelessWidget {
  final double height;

  const OiselyCardShimmer({super.key, this.height = 180});

  @override
  Widget build(BuildContext context) {
    return Container(
          width: 140,
          height: height,
          margin: const EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            color: OiselyColors.grey100,
            borderRadius: BorderRadius.circular(OiselyShapes.cardRadius),
            boxShadow: OiselyShapes.softShadow,
          ),
        )
        .animate(onPlay: (c) => c.repeat())
        .shimmer(
          duration: 1500.ms,
          color: OiselyColors.grey50.withAlpha(200),
        );
  }
}

/// Animated bounce button with scale effect
class OiselyBounceButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final double scaleFactor;

  const OiselyBounceButton({
    super.key,
    required this.child,
    this.onPressed,
    this.scaleFactor = 0.95,
  });

  @override
  State<OiselyBounceButton> createState() => _OiselyBounceButtonState();
}

class _OiselyBounceButtonState extends State<OiselyBounceButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation =
        Tween<double>(
          begin: 1.0,
          end: widget.scaleFactor,
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeInOut,
          ),
        );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
    widget.onPressed?.call();
  }

  void _onTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: widget.child,
      ),
    );
  }
}

/// Animated floating action button with pulse effect
class OiselyPulsingFAB extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final Color? backgroundColor;
  final Color? iconColor;

  const OiselyPulsingFAB({
    super.key,
    this.onPressed,
    this.icon = Icons.add,
    this.backgroundColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? OiselyColors.primary;
    final fgColor = iconColor ?? OiselyColors.onPrimary;

    return GestureDetector(
      onTap: onPressed,
      child:
          Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [bgColor, bgColor.withAlpha(200)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: OiselyShapes.primaryShadow(bgColor),
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: fgColor,
                ),
              )
              .animate(onPlay: (c) => c.repeat())
              .scale(
                begin: const Offset(1, 1),
                end: const Offset(1.05, 1.05),
                duration: 1000.ms,
                curve: Curves.easeInOut,
              )
              .then()
              .scale(
                begin: const Offset(1.05, 1.05),
                end: const Offset(1, 1),
                duration: 1000.ms,
                curve: Curves.easeInOut,
              ),
    );
  }
}

/// Success checkmark animation
class OiselySuccessAnimation extends StatelessWidget {
  final double size;
  final Color? color;
  final VoidCallback? onComplete;

  const OiselySuccessAnimation({
    super.key,
    this.size = 80,
    this.color,
    this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: (color ?? OiselyColors.success).withAlpha(30),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.check_rounded,
            size: size * 0.6,
            color: color ?? OiselyColors.success,
          ),
        )
        .animate(onComplete: (_) => onComplete?.call())
        .scale(
          begin: const Offset(0, 0),
          end: const Offset(1, 1),
          duration: 400.ms,
          curve: Curves.elasticOut,
        )
        .fadeIn(duration: 200.ms);
  }
}

/// Animated empty state illustration
class OiselyEmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget? action;

  const OiselyEmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: OiselyColors.primaryContainer.withAlpha(128),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 56,
                color: OiselyColors.primary,
              ),
            )
            .animate()
            .fadeIn(duration: 400.ms)
            .scale(
              begin: const Offset(0.8, 0.8),
              end: const Offset(1, 1),
              duration: 400.ms,
              curve: Curves.easeOut,
            )
            .then()
            .animate(onPlay: (c) => c.repeat())
            .moveY(
              begin: 0,
              end: -8,
              duration: 2000.ms,
              curve: Curves.easeInOut,
            )
            .then()
            .moveY(
              begin: -8,
              end: 0,
              duration: 2000.ms,
              curve: Curves.easeInOut,
            ),
        const SizedBox(height: 24),
        Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: OiselyColors.onSurface,
              ),
            )
            .animate()
            .fadeIn(delay: 200.ms, duration: 400.ms)
            .moveY(begin: 10, end: 0, duration: 400.ms),
        const SizedBox(height: 8),
        Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: OiselyColors.onSurfaceVariant,
              ),
            )
            .animate()
            .fadeIn(delay: 300.ms, duration: 400.ms)
            .moveY(begin: 10, end: 0, duration: 400.ms),
        if (action != null) ...[
          const SizedBox(height: 24),
          action!
              .animate()
              .fadeIn(delay: 400.ms, duration: 400.ms)
              .moveY(begin: 10, end: 0, duration: 400.ms),
        ],
      ],
    );
  }
}

/// Animated badge with scale and bounce
class OiselyBadge extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final IconData? icon;
  final bool animate;

  const OiselyBadge({
    super.key,
    required this.text,
    this.backgroundColor,
    this.textColor,
    this.icon,
    this.animate = true,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? OiselyColors.primary;
    final fgColor = textColor ?? OiselyColors.onPrimary;

    Widget badge = Container(
      padding: EdgeInsets.symmetric(
        horizontal: icon != null ? 10 : 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(OiselyShapes.badgeRadius),
        boxShadow: OiselyShapes.softShadow,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: fgColor),
            const SizedBox(width: 4),
          ],
          Text(
            text,
            style: TextStyle(
              color: fgColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );

    if (animate) {
      return badge
          .animate()
          .scale(
            begin: const Offset(0, 0),
            end: const Offset(1, 1),
            duration: 300.ms,
            curve: Curves.elasticOut,
          )
          .fadeIn(duration: 200.ms);
    }

    return badge;
  }
}

/// Animated list item entrance
extension OiselyListAnimations on Widget {
  Widget animateListItem(int index, {Duration? delay}) {
    return animate()
        .fadeIn(
          delay: delay ?? Duration(milliseconds: 50 * index),
          duration: 400.ms,
        )
        .moveX(
          begin: 30,
          end: 0,
          delay: delay ?? Duration(milliseconds: 50 * index),
          duration: 400.ms,
          curve: Curves.easeOutCubic,
        );
  }

  Widget animateGridItem(int index, {Duration? delay}) {
    return animate()
        .fadeIn(
          delay: delay ?? Duration(milliseconds: 80 * index),
          duration: 400.ms,
        )
        .scale(
          begin: const Offset(0.8, 0.8),
          end: const Offset(1, 1),
          delay: delay ?? Duration(milliseconds: 80 * index),
          duration: 400.ms,
          curve: Curves.easeOutCubic,
        );
  }
}

/// Page transition animations
class OiselyPageTransitions {
  static Widget fadeThrough(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  static Widget slideUp(
    BuildContext context,
    Animation<double> animation,
    Widget child,
  ) {
    return SlideTransition(
      position:
          Tween<Offset>(
            begin: const Offset(0, 0.1),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            ),
          ),
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }
}
