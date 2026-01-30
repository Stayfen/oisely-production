import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import '../design_system/core/oisely_colors.dart';
import '../design_system/core/oisely_shapes.dart';
import '../design_system/core/oisely_spacing.dart';
import '../design_system/core/oisely_typography.dart';

/// Professional Hero section with glassmorphism and modern design.
/// Responsive: Full width/height on mobile, Left side on desktop.
class AuthHeroSection extends StatelessWidget {
  const AuthHeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0D3B2E), // Deep forest
            Color(0xFF145A32), // Forest green
            Color(0xFF1E8449), // Primary dark
            Color(0xFF178F89), // Teal accent
          ],
          stops: [0.0, 0.3, 0.7, 1.0],
        ),
      ),
      child: Stack(
        children: [
          // Animated gradient orbs
          Positioned(
            top: -100,
            right: -60,
            child: _GlowingOrb(
              size: 280,
              color: OiselyColors.primary.withAlpha(40),
              delay: 0,
            ),
          ),
          Positioned(
            bottom: -120,
            left: -80,
            child: _GlowingOrb(
              size: 320,
              color: OiselyColors.secondary.withAlpha(30),
              delay: 500,
            ),
          ),
          Positioned(
            top: 150,
            left: -40,
            child: _GlowingOrb(
              size: 150,
              color: OiselyColors.tertiary.withAlpha(25),
              delay: 1000,
            ),
          ),
          // Subtle grid pattern overlay
          Positioned.fill(
            child: CustomPaint(
              painter: _GridPatternPainter(),
            ),
          ),
          // Main content
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(isDesktop ? 48.0 : 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo with glassmorphism
                  _buildLogo(),
                  SizedBox(height: isDesktop ? 56 : 40),
                  // Tagline
                  _buildTagline(isDesktop),
                  SizedBox(height: isDesktop ? 48 : 32),
                  // Feature cards
                  _buildFeatureCards(isDesktop),
                  if (!isDesktop) const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Row(
      children: [
        // Glass container with logo
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withAlpha(30),
                    Colors.white.withAlpha(10),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withAlpha(40),
                  width: 1.5,
                ),
              ),
              child: Image.asset(
                'assets/icons/icon.png',
                width: 36,
                height: 36,
              ),
            ),
          ),
        )
            .animate()
            .scale(
              begin: const Offset(0.5, 0.5),
              end: const Offset(1, 1),
              duration: 600.ms,
              curve: Curves.elasticOut,
            )
            .fadeIn(duration: 400.ms),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Oisely',
              style: GoogleFonts.inter(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: -0.5,
              ),
            ),
            Text(
              'Pet Intelligence',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.white.withAlpha(180),
                letterSpacing: 1.5,
              ),
            ),
          ],
        )
            .animate()
            .fadeIn(delay: 200.ms, duration: 400.ms)
            .moveX(begin: -15, end: 0, duration: 400.ms),
      ],
    );
  }

  Widget _buildTagline(bool isDesktop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Pet\'s',
          style: GoogleFonts.inter(
            fontSize: isDesktop ? 44 : 32,
            fontWeight: FontWeight.w300,
            color: Colors.white.withAlpha(230),
            height: 1.1,
            letterSpacing: -1,
          ),
        )
            .animate()
            .fadeIn(delay: 300.ms, duration: 500.ms)
            .moveY(begin: 20, end: 0, duration: 500.ms),
        const SizedBox(height: 4),
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [
              Colors.white,
              Color(0xFF5DADE2),
              Color(0xFF20B2AA),
            ],
          ).createShader(bounds),
          child: Text(
            'AI Guardian',
            style: GoogleFonts.inter(
              fontSize: isDesktop ? 52 : 38,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              height: 1.1,
              letterSpacing: -1.5,
            ),
          ),
        )
            .animate()
            .fadeIn(delay: 400.ms, duration: 500.ms)
            .moveY(begin: 20, end: 0, duration: 500.ms),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(15),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.white.withAlpha(20)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: OiselyColors.primary,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: OiselyColors.primary.withAlpha(150),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'Powered by Advanced AI',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withAlpha(200),
                ),
              ),
            ],
          ),
        )
            .animate()
            .fadeIn(delay: 500.ms, duration: 400.ms)
            .scale(begin: const Offset(0.9, 0.9), duration: 400.ms),
      ],
    );
  }

  Widget _buildFeatureCards(bool isDesktop) {
    final features = [
      _FeatureData(
        icon: Icons.camera_enhance_rounded,
        title: 'Instant ID',
        description: 'Identify any animal with AI',
        gradient: [const Color(0xFF5DADE2), const Color(0xFF3498DB)],
        delay: 600,
      ),
      _FeatureData(
        icon: Icons.psychology_rounded,
        title: 'Behavior',
        description: 'Understand emotions',
        gradient: [const Color(0xFFFF6B9D), const Color(0xFFE91E63)],
        delay: 700,
      ),
      _FeatureData(
        icon: Icons.auto_awesome_rounded,
        title: 'Smart Care',
        description: 'Personalized routines',
        gradient: [const Color(0xFF20B2AA), const Color(0xFF178F89)],
        delay: 800,
      ),
    ];

    if (isDesktop) {
      return Column(
        children: features.map((f) => _FeatureCard(data: f)).toList(),
      );
    } else {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: features
              .map((f) => Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: _FeatureCardCompact(data: f),
                  ))
              .toList(),
        ),
      );
    }
  }
}

class _FeatureData {
  final IconData icon;
  final String title;
  final String description;
  final List<Color> gradient;
  final int delay;

  const _FeatureData({
    required this.icon,
    required this.title,
    required this.description,
    required this.gradient,
    required this.delay,
  });
}

class _GlowingOrb extends StatelessWidget {
  final double size;
  final Color color;
  final int delay;

  const _GlowingOrb({
    required this.size,
    required this.color,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color, color.withAlpha(0)],
          stops: const [0.0, 1.0],
        ),
      ),
    )
        .animate(onPlay: (c) => c.repeat(reverse: true))
        .scale(
          begin: const Offset(1, 1),
          end: const Offset(1.15, 1.15),
          duration: 4000.ms,
          delay: Duration(milliseconds: delay),
          curve: Curves.easeInOut,
        )
        .fadeIn(duration: 1000.ms);
  }
}

class _GridPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withAlpha(8)
      ..strokeWidth = 0.5;

    const spacing = 40.0;
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _FeatureCard extends StatelessWidget {
  final _FeatureData data;

  const _FeatureCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withAlpha(15),
                  Colors.white.withAlpha(5),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.white.withAlpha(20),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: data.gradient),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: data.gradient.first.withAlpha(80),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(data.icon, color: Colors.white, size: 22),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.title,
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        data.description,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: Colors.white.withAlpha(180),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14,
                  color: Colors.white.withAlpha(100),
                ),
              ],
            ),
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(
          delay: Duration(milliseconds: data.delay),
          duration: 400.ms,
        )
        .moveX(begin: -25, end: 0, duration: 400.ms);
  }
}

class _FeatureCardCompact extends StatelessWidget {
  final _FeatureData data;

  const _FeatureCardCompact({required this.data});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          width: 130,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withAlpha(15),
                Colors.white.withAlpha(5),
              ],
            ),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.white.withAlpha(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: data.gradient),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(data.icon, color: Colors.white, size: 18),
              ),
              const SizedBox(height: 10),
              Text(
                data.title,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                data.description,
                style: GoogleFonts.inter(
                  fontSize: 10,
                  color: Colors.white.withAlpha(180),
                ),
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(
          delay: Duration(milliseconds: data.delay),
          duration: 400.ms,
        )
        .moveY(begin: 15, end: 0, duration: 400.ms);
  }
}

// Legacy support - kept for backward compatibility
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

/// Modern, professional email input form.
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
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Welcome header with logo
          Center(
            child: Column(
              children: [
                // Animated logo container
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        OiselyColors.primary.withAlpha(20),
                        OiselyColors.secondary.withAlpha(15),
                      ],
                    ),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: OiselyColors.primary.withAlpha(30),
                      width: 2,
                    ),
                  ),
                  child: Image.asset(
                    'assets/icons/icon.png',
                    width: 56,
                    height: 56,
                  ),
                )
                    .animate()
                    .scale(
                      begin: const Offset(0.7, 0.7),
                      end: const Offset(1, 1),
                      duration: 500.ms,
                      curve: Curves.easeOutBack,
                    )
                    .fadeIn(duration: 400.ms),
                const SizedBox(height: 28),
                // Welcome text
                Text(
                  'Welcome back',
                  style: GoogleFonts.inter(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: OiselyColors.onBackground,
                    letterSpacing: -0.5,
                  ),
                )
                    .animate()
                    .fadeIn(delay: 150.ms, duration: 400.ms)
                    .moveY(begin: 10, end: 0, duration: 400.ms),
                const SizedBox(height: 8),
                Text(
                  'Sign in to continue to your dashboard',
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    color: OiselyColors.onSurfaceVariant,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                )
                    .animate()
                    .fadeIn(delay: 250.ms, duration: 400.ms),
              ],
            ),
          ),
          const SizedBox(height: 40),

          // Error Message with refined styling
          if (widget.errorMessage != null)
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                color: OiselyColors.error.withAlpha(12),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: OiselyColors.error.withAlpha(40)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: OiselyColors.error.withAlpha(25),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.error_outline_rounded,
                      color: OiselyColors.error,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      widget.errorMessage!,
                      style: GoogleFonts.inter(
                        fontSize: 13,
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

          // Email input section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Email address',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: OiselyColors.onSurface,
                  letterSpacing: 0.2,
                ),
              ),
              const SizedBox(height: 10),
              Focus(
                onFocusChange: (focused) => setState(() => _isFocused = focused),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: _isFocused
                        ? [
                            BoxShadow(
                              color: OiselyColors.primary.withAlpha(25),
                              blurRadius: 20,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : [],
                  ),
                  child: TextField(
                    controller: widget.emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: OiselyColors.onSurface,
                    ),
                    decoration: InputDecoration(
                      hintText: 'name@example.com',
                      hintStyle: GoogleFonts.inter(
                        fontSize: 15,
                        color: OiselyColors.onSurfaceVariant.withAlpha(150),
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Icon(
                          Icons.mail_outline_rounded,
                          color: _isFocused
                              ? OiselyColors.primary
                              : OiselyColors.onSurfaceVariant,
                          size: 22,
                        ),
                      ),
                      filled: true,
                      fillColor: OiselyColors.surfaceVariant.withAlpha(80),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(
                          color: OiselyColors.outline.withAlpha(60),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
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
                  ),
                ),
              ),
            ],
          )
              .animate()
              .fadeIn(delay: 350.ms, duration: 400.ms)
              .moveY(begin: 15, end: 0, duration: 400.ms),
          const SizedBox(height: 28),

          // Submit Button
          _ModernSubmitButton(
            isLoading: widget.isLoading,
            onPressed: widget.onSendCode,
            label: 'Continue with Email',
            icon: Icons.arrow_forward_rounded,
          )
              .animate()
              .fadeIn(delay: 450.ms, duration: 400.ms)
              .moveY(begin: 15, end: 0, duration: 400.ms),
          const SizedBox(height: 24),

          // Security note
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: OiselyColors.surfaceVariant.withAlpha(60),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.lock_outline_rounded,
                    size: 14,
                    color: OiselyColors.onSurfaceVariant.withAlpha(180),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Secure magic link authentication',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: OiselyColors.onSurfaceVariant.withAlpha(180),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          )
              .animate()
              .fadeIn(delay: 550.ms, duration: 400.ms),
          const SizedBox(height: 40),

          // Social sign-in divider (visual only - no backend change)
          Row(
            children: [
              Expanded(child: Divider(color: OiselyColors.outline.withAlpha(60))),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'or continue with',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: OiselyColors.onSurfaceVariant.withAlpha(150),
                  ),
                ),
              ),
              Expanded(child: Divider(color: OiselyColors.outline.withAlpha(60))),
            ],
          )
              .animate()
              .fadeIn(delay: 650.ms, duration: 400.ms),
          const SizedBox(height: 20),

          // Social buttons placeholder
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _SocialButton(
                icon: Icons.g_mobiledata_rounded,
                label: 'Google',
                delay: 700,
              ),
              const SizedBox(width: 12),
              _SocialButton(
                icon: Icons.apple_rounded,
                label: 'Apple',
                delay: 750,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ModernSubmitButton extends StatefulWidget {
  final bool isLoading;
  final VoidCallback onPressed;
  final String label;
  final IconData icon;

  const _ModernSubmitButton({
    required this.isLoading,
    required this.onPressed,
    required this.label,
    required this.icon,
  });

  @override
  State<_ModernSubmitButton> createState() => _ModernSubmitButtonState();
}

class _ModernSubmitButtonState extends State<_ModernSubmitButton>
    with SingleTickerProviderStateMixin {
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
                    OiselyColors.primary.withAlpha(150),
                    OiselyColors.primaryDark.withAlpha(150),
                  ],
                )
              : const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    OiselyColors.primary,
                    OiselyColors.primaryDark,
                  ],
                ),
          borderRadius: BorderRadius.circular(14),
          boxShadow: _isPressed || widget.isLoading
              ? []
              : [
                  BoxShadow(
                    color: OiselyColors.primary.withAlpha(60),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
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
                      width: 20,
                      height: 20,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Text(
                      'Sending link...',
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
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
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(30),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        widget.icon,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final int delay;

  const _SocialButton({
    required this.icon,
    required this.label,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$label sign-in coming soon!'),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: BoxDecoration(
            color: OiselyColors.surfaceVariant.withAlpha(60),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: OiselyColors.outline.withAlpha(40),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 22,
                color: OiselyColors.onSurface,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: OiselyColors.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(delay: Duration(milliseconds: delay), duration: 300.ms)
        .scale(begin: const Offset(0.95, 0.95), duration: 300.ms);
  }
}
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
