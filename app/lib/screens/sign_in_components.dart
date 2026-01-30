import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import '../design_system/core/oisely_colors.dart';
import '../design_system/core/oisely_shapes.dart';
import '../design_system/core/oisely_spacing.dart';
import '../design_system/core/oisely_typography.dart';

/// The Hero section displaying value propositions.
/// Responsive: Full width/height on mobile, Left side on desktop.
class AuthHeroSection extends StatelessWidget {
  const AuthHeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            OiselyColors.primary,
            OiselyColors.primaryDark,
            const Color(0xFF145A32),
          ],
          stops: const [0.0, 0.6, 1.0],
        ),
      ),
      padding: const EdgeInsets.all(OiselySpacing.xl),
      child: Stack(
        children: [
          // Decorative circles
          Positioned(
            top: -50,
            right: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withAlpha(15),
              ),
            ),
          ),
          Positioned(
            bottom: -80,
            left: -80,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withAlpha(10),
              ),
            ),
          ),
          // Content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo / Brand
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(50),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(30),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.pets,
                      color: Colors.white,
                      size: 32,
                    ),
                  ).animate().scale(
                    begin: const Offset(0, 0),
                    end: const Offset(1, 1),
                    duration: 500.ms,
                    curve: Curves.elasticOut,
                  ),
                  const SizedBox(width: OiselySpacing.md),
                  Text(
                        'Oisely',
                        style: GoogleFonts.inter(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )
                      .animate()
                      .fadeIn(delay: 200.ms, duration: 400.ms)
                      .moveX(begin: -20, end: 0, duration: 400.ms),
                ],
              ),
              const SizedBox(height: OiselySpacing.xxl),

              // Slogan with animated emoji
              Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          'The AI Guardian for\nYour Pet\'s Life',
                          style: OiselyTypography.h1.copyWith(
                            color: Colors.white,
                            height: 1.2,
                            fontSize: 28,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text('🦁', style: const TextStyle(fontSize: 40))
                          .animate(onPlay: (c) => c.repeat())
                          .scale(
                            begin: const Offset(1, 1),
                            end: const Offset(1.2, 1.2),
                            duration: 1000.ms,
                          )
                          .then()
                          .scale(
                            begin: const Offset(1.2, 1.2),
                            end: const Offset(1, 1),
                            duration: 1000.ms,
                          ),
                    ],
                  )
                  .animate()
                  .fadeIn(delay: 300.ms, duration: 500.ms)
                  .moveY(begin: 20, end: 0, duration: 500.ms),
              const SizedBox(height: OiselySpacing.xl),

              // Features List with staggered animation
              _AnimatedFeatureItem(
                icon: Icons.camera_alt_outlined,
                title: 'AI Animal Identification',
                description: 'Snap a photo and instantly identify any animal.',
                delay: 400,
                accentColor: OiselyColors.accentYellow,
              ),
              _AnimatedFeatureItem(
                icon: Icons.psychology_outlined,
                title: 'Behavior Analysis',
                description: 'Understand your pet\'s emotions and needs.',
                delay: 500,
                accentColor: OiselyColors.accentPink,
              ),
              _AnimatedFeatureItem(
                icon: Icons.calendar_today_outlined,
                title: 'Smart Care Plans',
                description: 'Personalized routines for a healthier pet.',
                delay: 600,
                accentColor: OiselyColors.tertiary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AnimatedFeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final int delay;
  final Color accentColor;

  const _AnimatedFeatureItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.delay,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.only(bottom: OiselySpacing.lg),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: accentColor.withAlpha(60),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: Colors.white, size: 22),
              ),
              const SizedBox(width: OiselySpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: OiselyTypography.h6.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: OiselyTypography.bodySmall.copyWith(
                        color: Colors.white.withAlpha(200),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(
          delay: Duration(milliseconds: delay),
          duration: 400.ms,
        )
        .moveX(begin: -30, end: 0, duration: 400.ms);
  }
}

/// The Input Form for Email.
class AuthFormSection extends StatefulWidget {
  final TextEditingController emailController;
  final bool isLoading;
  final VoidCallback onSendCode;
  final String? errorMessage;

  const AuthFormSection({
    super.key,
    required this.emailController,
    required this.isLoading,
    required this.onSendCode,
    this.errorMessage,
  });

  @override
  State<AuthFormSection> createState() => _AuthFormSectionState();
}

class _AuthFormSectionState extends State<AuthFormSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(OiselySpacing.xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Welcome illustration
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: OiselyColors.primaryGradient,
              shape: BoxShape.circle,
              boxShadow: OiselyShapes.primaryShadow(OiselyColors.primary),
            ),
            child: const Text(
              '🐾',
              style: TextStyle(fontSize: 48),
              textAlign: TextAlign.center,
            ),
          ).animate().scale(
            begin: const Offset(0.5, 0.5),
            end: const Offset(1, 1),
            duration: 600.ms,
            curve: Curves.elasticOut,
          ),
          const SizedBox(height: OiselySpacing.xl),
          Text(
                'Welcome to Oisely! 👋',
                style: OiselyTypography.h2.copyWith(
                  color: OiselyColors.onBackground,
                ),
                textAlign: TextAlign.center,
              )
              .animate()
              .fadeIn(delay: 200.ms, duration: 400.ms)
              .moveY(begin: 10, end: 0, duration: 400.ms),
          const SizedBox(height: OiselySpacing.xs),
          Text(
            'Sign in to access your pet dashboard',
            style: OiselyTypography.bodyMedium.copyWith(
              color: OiselyColors.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 300.ms, duration: 400.ms),
          const SizedBox(height: OiselySpacing.xxl),

          // Error Message
          if (widget.errorMessage != null)
            Container(
                  padding: const EdgeInsets.all(OiselySpacing.md),
                  margin: const EdgeInsets.only(bottom: OiselySpacing.lg),
                  decoration: BoxDecoration(
                    color: OiselyColors.error.withAlpha(25),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: OiselyColors.error.withAlpha(75)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: OiselyColors.error.withAlpha(50),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.error_outline,
                          color: OiselyColors.error,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: OiselySpacing.md),
                      Expanded(
                        child: Text(
                          widget.errorMessage!,
                          style: OiselyTypography.bodySmall.copyWith(
                            color: OiselyColors.error,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                .animate()
                .fadeIn(duration: 300.ms)
                .shakeX(hz: 3, amount: 4, duration: 400.ms),

          // Email Input
          Text(
            'Email Address',
            style: OiselyTypography.label.copyWith(
              color: OiselyColors.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ).animate().fadeIn(delay: 400.ms, duration: 300.ms),
          const SizedBox(height: OiselySpacing.sm),
          TextField(
                controller: widget.emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'name@example.com',
                  prefixIcon: Container(
                    margin: const EdgeInsets.all(12),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: OiselyColors.primary.withAlpha(25),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.email_outlined,
                      color: OiselyColors.primary,
                      size: 20,
                    ),
                  ),
                  filled: true,
                  fillColor: OiselyColors.surfaceVariant.withAlpha(127),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: OiselyColors.outline.withAlpha(127),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: OiselyColors.primary,
                      width: 2,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 18,
                  ),
                ),
                onSubmitted: (_) => widget.onSendCode(),
              )
              .animate()
              .fadeIn(delay: 500.ms, duration: 300.ms)
              .moveY(begin: 10, end: 0, duration: 300.ms),
          const SizedBox(height: OiselySpacing.xl),

          // Submit Button
          _AnimatedSubmitButton(
                isLoading: widget.isLoading,
                onPressed: widget.onSendCode,
                label: 'Send Magic Link ✨',
              )
              .animate()
              .fadeIn(delay: 600.ms, duration: 300.ms)
              .moveY(begin: 10, end: 0, duration: 300.ms),
          const SizedBox(height: OiselySpacing.lg),

          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.lock_outline,
                  size: 14,
                  color: OiselyColors.onSurfaceVariant,
                ),
                const SizedBox(width: 6),
                Text(
                  'We\'ll send a secure magic link code to your email',
                  style: OiselyTypography.caption.copyWith(
                    color: OiselyColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(delay: 700.ms, duration: 300.ms),
        ],
      ),
    );
  }
}

class _AnimatedSubmitButton extends StatefulWidget {
  final bool isLoading;
  final VoidCallback onPressed;
  final String label;

  const _AnimatedSubmitButton({
    required this.isLoading,
    required this.onPressed,
    required this.label,
  });

  @override
  State<_AnimatedSubmitButton> createState() => _AnimatedSubmitButtonState();
}

class _AnimatedSubmitButtonState extends State<_AnimatedSubmitButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.isLoading ? null : widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        height: 56,
        decoration: BoxDecoration(
          gradient: widget.isLoading
              ? LinearGradient(
                  colors: [
                    OiselyColors.primary.withAlpha(180),
                    OiselyColors.primaryDark.withAlpha(180),
                  ],
                )
              : OiselyColors.primaryGradient,
          borderRadius: BorderRadius.circular(16),
          boxShadow: _isPressed
              ? []
              : [
                  BoxShadow(
                    color: OiselyColors.primary.withAlpha(100),
                    blurRadius: 15,
                    offset: const Offset(0, 6),
                  ),
                ],
        ),
        transform: Matrix4.identity()..scale(_isPressed ? 0.98 : 1.0),
        child: Center(
          child: widget.isLoading
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 22,
                      height: 22,
                      child:
                          const CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: Colors.white,
                              )
                              .animate(onPlay: (c) => c.repeat())
                              .rotate(duration: 1000.ms),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Sending...',
                      style: OiselyTypography.button.copyWith(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.label,
                      style: OiselyTypography.button.copyWith(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: OiselySpacing.sm),
                    const Icon(
                      Icons.arrow_forward_rounded,
                      size: 20,
                      color: Colors.white,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

/// The Verification Code Section.
class AuthCodeVerifySection extends StatelessWidget {
  final String email;
  final TextEditingController otpController;
  final bool isLoading;
  final Function(String) onVerify;
  final VoidCallback onRetry;
  final String? errorMessage;

  const AuthCodeVerifySection({
    super.key,
    required this.email,
    required this.otpController,
    required this.isLoading,
    required this.onVerify,
    required this.onRetry,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 52,
      height: 60,
      textStyle: OiselyTypography.h3.copyWith(
        color: OiselyColors.onSurface,
        fontWeight: FontWeight.bold,
      ),
      decoration: BoxDecoration(
        color: OiselyColors.surfaceVariant.withAlpha(127),
        border: Border.all(color: OiselyColors.outline.withAlpha(127)),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.all(OiselySpacing.xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Email icon with animation
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  OiselyColors.primary.withAlpha(40),
                  OiselyColors.tertiary.withAlpha(40),
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.mark_email_read_outlined,
              size: 48,
              color: OiselyColors.primary,
            ),
          ).animate().scale(
            begin: const Offset(0.5, 0.5),
            end: const Offset(1, 1),
            duration: 500.ms,
            curve: Curves.elasticOut,
          ),
          const SizedBox(height: OiselySpacing.xl),
          Text(
                'Check your email 📬',
                style: OiselyTypography.h2.copyWith(
                  color: OiselyColors.onBackground,
                ),
                textAlign: TextAlign.center,
              )
              .animate()
              .fadeIn(delay: 200.ms, duration: 400.ms)
              .moveY(begin: 10, end: 0, duration: 400.ms),
          const SizedBox(height: OiselySpacing.md),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: OiselyTypography.bodyMedium.copyWith(
                color: OiselyColors.onSurfaceVariant,
              ),
              children: [
                const TextSpan(text: 'We sent a 6-digit code to '),
                TextSpan(
                  text: email,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: OiselyColors.primary,
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(delay: 300.ms, duration: 400.ms),
          const SizedBox(height: OiselySpacing.xxl),

          // Error Message
          if (errorMessage != null)
            Container(
                  padding: const EdgeInsets.all(OiselySpacing.md),
                  margin: const EdgeInsets.only(bottom: OiselySpacing.lg),
                  decoration: BoxDecoration(
                    color: OiselyColors.error.withAlpha(25),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: OiselyColors.error.withAlpha(75)),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: OiselyColors.error,
                        size: 20,
                      ),
                      const SizedBox(width: OiselySpacing.sm),
                      Expanded(
                        child: Text(
                          errorMessage!,
                          style: OiselyTypography.bodySmall.copyWith(
                            color: OiselyColors.error,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                .animate()
                .fadeIn(duration: 300.ms)
                .shakeX(hz: 3, amount: 4, duration: 400.ms),

          // Pinput
          Center(
                child: Pinput(
                  controller: otpController,
                  length: 6,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      border: Border.all(color: OiselyColors.primary, width: 2),
                      boxShadow: OiselyShapes.primaryShadow(
                        OiselyColors.primary.withAlpha(75),
                      ),
                    ),
                  ),
                  submittedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      color: OiselyColors.primary.withAlpha(25),
                      border: Border.all(color: OiselyColors.primary),
                    ),
                  ),
                  errorPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      border: Border.all(color: OiselyColors.error),
                    ),
                  ),
                  hapticFeedbackType: HapticFeedbackType.lightImpact,
                  onCompleted: onVerify,
                  cursor: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 22,
                        height: 3,
                        decoration: BoxDecoration(
                          color: OiselyColors.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .animate()
              .fadeIn(delay: 400.ms, duration: 400.ms)
              .moveY(begin: 20, end: 0, duration: 400.ms),
          const SizedBox(height: OiselySpacing.xl),

          // Verify Button
          _AnimatedSubmitButton(
                isLoading: isLoading,
                onPressed: () => onVerify(otpController.text),
                label: 'Verify & Sign In',
              )
              .animate()
              .fadeIn(delay: 500.ms, duration: 300.ms)
              .moveY(begin: 10, end: 0, duration: 300.ms),
          const SizedBox(height: OiselySpacing.lg),

          // Retry / Back
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Didn't receive the code? ",
                style: OiselyTypography.bodySmall.copyWith(
                  color: OiselyColors.onSurfaceVariant,
                ),
              ),
              GestureDetector(
                onTap: onRetry,
                child: Text(
                  'Try again',
                  style: OiselyTypography.bodySmall.copyWith(
                    color: OiselyColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ).animate().fadeIn(delay: 600.ms, duration: 300.ms),
          const SizedBox(height: OiselySpacing.md),
          TextButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.arrow_back_rounded, size: 18),
            label: const Text('Use a different email'),
            style: TextButton.styleFrom(
              foregroundColor: OiselyColors.onSurfaceVariant,
            ),
          ).animate().fadeIn(delay: 700.ms, duration: 300.ms),
        ],
      ),
    );
  }
}
