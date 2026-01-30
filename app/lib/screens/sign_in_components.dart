import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import '../design_system/core/oisely_colors.dart';
import '../design_system/core/oisely_spacing.dart';
import '../design_system/core/oisely_typography.dart';
import 'package:shimmer/shimmer.dart';

/// The Hero section displaying value propositions.
/// Responsive: Full width/height on mobile, Left side on desktop.
class AuthHeroSection extends StatelessWidget {
  const AuthHeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: OiselyColors.primary,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            OiselyColors.primary,
            OiselyColors.primaryDark,
          ],
        ),
      ),
      padding: const EdgeInsets.all(OiselySpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Logo / Brand
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.pets,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              const SizedBox(width: OiselySpacing.md),
              Text(
                'Oisely',
                style: GoogleFonts.inter(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: OiselySpacing.xxl),

          // Slogan
          Text(
            'The AI Guardian for\nYour Pet\'s Life',
            style: OiselyTypography.h1.copyWith(
              color: Colors.white,
              height: 1.2,
            ),
          ),
          const SizedBox(height: OiselySpacing.lg),

          // Features List
          _buildFeatureItem(
            Icons.analytics_outlined,
            'AI Behavior Analysis',
            'Understand your pet\'s needs with advanced video analysis.',
          ),
          _buildFeatureItem(
            Icons.health_and_safety_outlined,
            'Smart Care Plans',
            'Personalized routines for a healthier, happier life.',
          ),
          _buildFeatureItem(
            Icons.favorite_border,
            'Seamless Adoption',
            'Track and manage your adoption journey with ease.',
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: OiselySpacing.lg),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(width: OiselySpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: OiselyTypography.h5.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: OiselyTypography.bodyMedium.copyWith(
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
          Text(
            'Welcome Back',
            style: OiselyTypography.h2.copyWith(color: OiselyColors.onBackground),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: OiselySpacing.xs),
          Text(
            'Sign in to access your dashboard',
            style: OiselyTypography.bodyMedium.copyWith(
              color: OiselyColors.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: OiselySpacing.xxl),

          // Error Message
          if (widget.errorMessage != null)
            Container(
              padding: const EdgeInsets.all(OiselySpacing.md),
              margin: const EdgeInsets.only(bottom: OiselySpacing.lg),
              decoration: BoxDecoration(
                color: OiselyColors.error.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: OiselyColors.error.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.error_outline, color: OiselyColors.error),
                  const SizedBox(width: OiselySpacing.md),
                  Expanded(
                    child: Text(
                      widget.errorMessage!,
                      style: OiselyTypography.bodySmall.copyWith(
                        color: OiselyColors.error,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // Email Input
          Text(
            'Email Address',
            style: OiselyTypography.label.copyWith(color: OiselyColors.onSurface),
          ),
          const SizedBox(height: OiselySpacing.xs),
          TextField(
            controller: widget.emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'name@example.com',
              prefixIcon: const Icon(Icons.email_outlined),
              filled: true,
              fillColor: OiselyColors.surfaceVariant,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: OiselyColors.outline),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: OiselyColors.primary),
              ),
            ),
            onSubmitted: (_) => widget.onSendCode(),
          ),
          const SizedBox(height: OiselySpacing.xl),

          // Submit Button
          SizedBox(
            height: 50,
            child: FilledButton(
              onPressed: widget.isLoading ? null : widget.onSendCode,
              style: FilledButton.styleFrom(
                backgroundColor: OiselyColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: widget.isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Send Magic Link',
                          style: OiselyTypography.button.copyWith(fontSize: 16),
                        ),
                        const SizedBox(width: OiselySpacing.sm),
                        const Icon(Icons.arrow_forward_rounded, size: 20),
                      ],
                    ),
            ),
          ),
          const SizedBox(height: OiselySpacing.lg),
          
          Center(
            child: Text(
              'We\'ll send a magic link code to your email.',
              style: OiselyTypography.caption.copyWith(
                color: OiselyColors.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
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
      width: 56,
      height: 56,
      textStyle: OiselyTypography.h3.copyWith(
        color: OiselyColors.onSurface,
      ),
      decoration: BoxDecoration(
        color: OiselyColors.surfaceVariant,
        border: Border.all(color: OiselyColors.outline),
        borderRadius: BorderRadius.circular(12),
      ),
    );

    return Padding(
      padding: const EdgeInsets.all(OiselySpacing.xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: OiselyColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.mark_email_read_outlined,
              size: 48,
              color: OiselyColors.primary,
            ),
          ),
          const SizedBox(height: OiselySpacing.xl),
          Text(
            'Check your email',
            style: OiselyTypography.h2.copyWith(color: OiselyColors.onBackground),
            textAlign: TextAlign.center,
          ),
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
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const TextSpan(text: '. Enter it below.'),
              ],
            ),
          ),
          const SizedBox(height: OiselySpacing.xxl),

          // Error Message
          if (errorMessage != null)
            Container(
              padding: const EdgeInsets.all(OiselySpacing.md),
              margin: const EdgeInsets.only(bottom: OiselySpacing.lg),
              decoration: BoxDecoration(
                color: OiselyColors.error.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: OiselyColors.error.withOpacity(0.3)),
              ),
              child: Text(
                errorMessage!,
                style: OiselyTypography.bodySmall.copyWith(
                  color: OiselyColors.error,
                ),
                textAlign: TextAlign.center,
              ),
            ),

          // Pinput
          Center(
            child: Pinput(
              controller: otpController,
              length: 6,
              defaultPinTheme: defaultPinTheme,
              focusedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  border: Border.all(color: OiselyColors.primary),
                ),
              ),
              onCompleted: onVerify,
            ),
          ),
          const SizedBox(height: OiselySpacing.xl),

          // Verify Button
          SizedBox(
            height: 50,
            child: FilledButton(
              onPressed: isLoading ? null : () => onVerify(otpController.text),
              style: FilledButton.styleFrom(
                backgroundColor: OiselyColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      'Verify Code',
                      style: OiselyTypography.button.copyWith(fontSize: 16),
                    ),
            ),
          ),
          const SizedBox(height: OiselySpacing.lg),

          // Retry / Back
          TextButton(
            onPressed: onRetry,
            child: Text(
              'Use a different email',
              style: OiselyTypography.button.copyWith(
                color: OiselyColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
