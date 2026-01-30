import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../design_system/core/oisely_colors.dart';
import '../design_system/core/oisely_shapes.dart';
import '../design_system/core/oisely_spacing.dart';
import '../providers/adoption_provider.dart';
import '../providers/auth_provider.dart';
import '../providers/navigation_provider.dart';
import 'help_center_screen.dart';
import 'my_pets_screen.dart';
import 'privacy_policy_screen.dart';
import 'scan_history_screen.dart';
import 'sign_in_screen.dart';

/// Settings screen for user preferences and account management
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      backgroundColor: OiselyColors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Custom App Bar
          SliverAppBar(
            floating: true,
            snap: true,
            elevation: 0,
            backgroundColor: OiselyColors.background,
            surfaceTintColor: Colors.transparent,
            toolbarHeight: 60,
            flexibleSpace: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            OiselyColors.accentLavender,
                            OiselyColors.accentPink,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: OiselyColors.accentLavender.withAlpha(60),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.settings_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Settings',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: OiselyColors.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Content
          SliverPadding(
            padding: const EdgeInsets.all(OiselySpacing.lg),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // User profile section (Avatar + Email) - tappable
                GestureDetector(
                  onTap: () => _showProfileBottomSheet(context, authProvider),
                  child: _buildProfileSection(context, authProvider),
                )
                    .animate()
                    .fadeIn(duration: 400.ms)
                    .moveY(begin: 20, end: 0, duration: 400.ms),
                const SizedBox(height: OiselySpacing.xl),

                // Quick Actions
                _buildSectionHeader(
                  context,
                  'Quick Actions',
                  '⚡',
                ).animate().fadeIn(delay: 100.ms, duration: 300.ms),
                const SizedBox(height: OiselySpacing.sm),
                _buildQuickActionsCard(context)
                    .animate()
                    .fadeIn(delay: 150.ms, duration: 400.ms)
                    .moveY(begin: 15, end: 0, duration: 400.ms),
                const SizedBox(height: OiselySpacing.xl),

                // App Settings (Notifications)
                _buildSectionHeader(
                  context,
                  'App Settings',
                  '📱',
                ).animate().fadeIn(delay: 200.ms, duration: 300.ms),
                const SizedBox(height: OiselySpacing.sm),
                _SettingsCard(
                      children: [
                        _SwitchSettingsTile(
                          icon: Icons.notifications_outlined,
                          title: 'Notifications',
                          subtitle: 'Enable or disable push notifications',
                          value: _notificationsEnabled,
                          accentColor: OiselyColors.tertiary,
                          onChanged: (value) {
                            setState(() {
                              _notificationsEnabled = value;
                            });
                          },
                        ),
                      ],
                    )
                    .animate()
                    .fadeIn(delay: 250.ms, duration: 400.ms)
                    .moveY(begin: 15, end: 0, duration: 400.ms),
                const SizedBox(height: OiselySpacing.xl),

                // Support & About
                _buildSectionHeader(
                  context,
                  'Support & About',
                  'ℹ️',
                ).animate().fadeIn(delay: 300.ms, duration: 300.ms),
                const SizedBox(height: OiselySpacing.sm),
                _SettingsCard(
                      children: [
                        _SettingsTile(
                          icon: Icons.help_outline_rounded,
                          title: 'Help Center',
                          subtitle: 'Get help with Oisely',
                          accentColor: OiselyColors.secondary,
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const HelpCenterScreen(),
                              ),
                            );
                          },
                        ),
                        _SettingsTile(
                          icon: Icons.privacy_tip_outlined,
                          title: 'Privacy Policy',
                          accentColor: OiselyColors.accentLavender,
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const PrivacyPolicyScreen(),
                              ),
                            );
                          },
                        ),
                        _SettingsTile(
                          icon: Icons.info_outline,
                          title: 'About',
                          subtitle: 'Version 1.0.0',
                          accentColor: OiselyColors.accentTeal,
                          onTap: () {
                            _showAboutDialog(context);
                          },
                        ),
                      ],
                    )
                    .animate()
                    .fadeIn(delay: 350.ms, duration: 400.ms)
                    .moveY(begin: 15, end: 0, duration: 400.ms),
                const SizedBox(height: OiselySpacing.xxl),

                // Sign Out button
                _SignOutButton(
                      onPressed: () =>
                          _showSignOutConfirmation(context, authProvider),
                    )
                    .animate()
                    .fadeIn(delay: 400.ms, duration: 400.ms)
                    .moveY(begin: 15, end: 0, duration: 400.ms),
                const SizedBox(height: OiselySpacing.xxl),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileSection(BuildContext context, AuthProvider authProvider) {
    return Container(
      decoration: BoxDecoration(
        gradient: OiselyColors.primaryGradient,
        borderRadius: BorderRadius.circular(OiselyShapes.cardRadius),
        boxShadow: OiselyShapes.primaryShadow(OiselyColors.primary),
      ),
      child: Padding(
        padding: const EdgeInsets.all(OiselySpacing.lg),
        child: Row(
          children: [
            // Profile avatar with glow effect
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withAlpha(60),
                    blurRadius: 15,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Container(
                width: 76,
                height: 76,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                ),
                child: ClipOval(
                  child: authProvider.userProfileImageUrl != null
                      ? Image.network(
                          authProvider.userProfileImageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return _buildFallbackAvatar(context, authProvider);
                          },
                        )
                      : _buildFallbackAvatar(context, authProvider),
                ),
              ),
            ),
            const SizedBox(width: OiselySpacing.md),
            // User info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text('👋 ', style: TextStyle(fontSize: 18)),
                      Expanded(
                        child: Text(
                          authProvider.userDisplayName,
                          style: GoogleFonts.inter(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(40),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.email_outlined,
                          size: 14,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            authProvider.userEmail ?? '',
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              color: Colors.white.withAlpha(230),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFallbackAvatar(BuildContext context, AuthProvider authProvider) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            OiselyColors.secondary,
            OiselyColors.accentCoral,
          ],
        ),
      ),
      child: Center(
        child: Text(
          authProvider.userDisplayName.isNotEmpty
              ? authProvider.userDisplayName[0].toUpperCase()
              : '?',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActionsCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(OiselySpacing.md),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            OiselyColors.secondary.withAlpha(20),
            OiselyColors.accentTeal.withAlpha(15),
          ],
        ),
        borderRadius: BorderRadius.circular(OiselyShapes.cardRadius),
        border: Border.all(color: OiselyColors.secondary.withAlpha(40)),
      ),
      child: Row(
        children: [
          Expanded(
            child: _QuickActionButton(
              icon: Icons.camera_alt_outlined,
              label: 'Scan Pet',
              color: OiselyColors.secondary,
              onTap: () {
                // Navigate to home and show hint to use FAB
                context.read<NavigationProvider>().setIndex(0);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: [
                        Icon(Icons.touch_app, color: Colors.white, size: 20),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text('Tap the + button to scan a pet!'),
                        ),
                      ],
                    ),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: OiselyColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    duration: const Duration(seconds: 3),
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _QuickActionButton(
              icon: Icons.favorite_outline,
              label: 'My Pets',
              color: OiselyColors.accentCoral,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const MyPetsScreen()),
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _QuickActionButton(
              icon: Icons.history_rounded,
              label: 'History',
              color: OiselyColors.accentTeal,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const ScanHistoryScreen()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, String emoji) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 8),
          Text(
            title.toUpperCase(),
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: OiselyColors.primary,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(OiselySpacing.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 88,
                height: 88,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: OiselyShapes.primaryShadow(OiselyColors.primary),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.asset(
                    'assets/icons/icon.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ).animate().scale(
                begin: const Offset(0.5, 0.5),
                end: const Offset(1, 1),
                duration: 500.ms,
                curve: Curves.elasticOut,
              ),
              const SizedBox(height: OiselySpacing.lg),
              Text(
                'Oisely',
                style: GoogleFonts.inter(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: OiselyColors.primary,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: OiselyColors.primary.withAlpha(25),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Version 1.0.0',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: OiselyColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: OiselySpacing.lg),
              Text(
                'The AI Guardian for Your Pet\'s Life 🦁',
                style: GoogleFonts.inter(
                  fontSize: 15,
                  color: OiselyColors.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: OiselySpacing.md),
              Text(
                '© 2026 Oisely. All rights reserved.',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: OiselyColors.onSurfaceVariant.withAlpha(150),
                ),
              ),
              const SizedBox(height: OiselySpacing.lg),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.pop(context),
                  style: FilledButton.styleFrom(
                    backgroundColor: OiselyColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text('Got it!'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showProfileBottomSheet(BuildContext context, AuthProvider authProvider) {
    final adoptionProvider = context.read<AdoptionProvider>();
    final colorScheme = Theme.of(context).colorScheme;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) =>
          Container(
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(OiselyShapes.bottomSheetRadius),
                  ),
                  boxShadow: OiselyShapes.strongShadow,
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            width: 48,
                            height: 5,
                            decoration: BoxDecoration(
                              color: OiselyColors.grey300,
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                        const SizedBox(height: 28),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                gradient: OiselyColors.primaryGradient,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Icon(
                                Icons.person_outline,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Account',
                                    style: GoogleFonts.inter(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: OiselyColors.onSurface,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    authProvider.userDisplayName,
                                    style: TextStyle(
                                      color: OiselyColors.onSurfaceVariant,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        // Stats row
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: OiselyColors.surfaceVariant.withAlpha(80),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: _ProfileStat(
                                  icon: Icons.pets,
                                  label: 'Total Scans',
                                  value: '${adoptionProvider.interestingAnimals.length + adoptionProvider.adoptedAnimals.length}',
                                  color: OiselyColors.primary,
                                ),
                              ),
                              Container(
                                width: 1,
                                height: 40,
                                color: OiselyColors.outline.withAlpha(60),
                              ),
                              Expanded(
                                child: _ProfileStat(
                                  icon: Icons.favorite,
                                  label: 'Adopted',
                                  value: '${adoptionProvider.adoptedAnimals.length}',
                                  color: OiselyColors.accentCoral,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Divider(),
                        const SizedBox(height: 16),
                        // Sign out tile
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () async {
                              Navigator.pop(context);
                              await authProvider.signOut();
                              await adoptionProvider.clearAll();
                              if (mounted) {
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (_) => SignInScreen(
                                      sessionManager: authProvider.sessionManager,
                                    ),
                                  ),
                                  (route) => false,
                                );
                              }
                            },
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                              decoration: BoxDecoration(
                                color: OiselyColors.error.withAlpha(20),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: OiselyColors.error.withAlpha(40),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.logout_rounded,
                                    color: OiselyColors.error,
                                    size: 22,
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    'Sign Out',
                                    style: GoogleFonts.inter(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: OiselyColors.error,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: TextButton(
                            onPressed: () => Navigator.pop(context),
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: const Text('Cancel'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .animate()
              .fadeIn(duration: 200.ms)
              .moveY(
                begin: 50,
                end: 0,
                duration: 300.ms,
                curve: Curves.easeOut,
              ),
    );
  }

  void _showSignOutConfirmation(
    BuildContext context,
    AuthProvider authProvider,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.all(OiselySpacing.xl),
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
                Icons.logout_rounded,
                size: 40,
                color: OiselyColors.error,
              ),
            ),
            const SizedBox(height: OiselySpacing.lg),
            Text(
              'Sign Out?',
              style: GoogleFonts.inter(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: OiselySpacing.sm),
            Text(
              'Are you sure you want to sign out?\nWe\'ll miss you! 🥺',
              style: GoogleFonts.inter(
                fontSize: 15,
                color: OiselyColors.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: OiselySpacing.xl),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: BorderSide(color: OiselyColors.outline),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                      await authProvider.signOut();

                      if (context.mounted) {
                        // Reset navigation index
                        context.read<NavigationProvider>().setIndex(0);

                        // Navigate to sign in
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (_) => SignInScreen(
                              sessionManager: authProvider.sessionManager,
                            ),
                          ),
                          (route) => false,
                        );
                      }
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: OiselyColors.error,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text('Sign Out'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: OiselySpacing.lg),
          ],
        ),
      ),
    );
  }
}

/// Quick action button for settings
class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: color.withAlpha(20),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withAlpha(40)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(height: 6),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Sign out button with styled appearance
class _SignOutButton extends StatefulWidget {
  final VoidCallback onPressed;

  const _SignOutButton({required this.onPressed});

  @override
  State<_SignOutButton> createState() => _SignOutButtonState();
}

class _SignOutButtonState extends State<_SignOutButton> {
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
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: OiselyColors.error.withAlpha(_isPressed ? 30 : 20),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: OiselyColors.error.withAlpha(60)),
        ),
        transform: Matrix4.identity()..scale(_isPressed ? 0.98 : 1.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout_rounded, color: OiselyColors.error, size: 22),
            const SizedBox(width: 10),
            Text(
              'Sign Out',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: OiselyColors.error,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Card widget for grouping settings
class _SettingsCard extends StatelessWidget {
  final List<Widget> children;

  const _SettingsCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: OiselyColors.surfaceVariant.withAlpha(80),
        borderRadius: BorderRadius.circular(OiselyShapes.cardRadius),
        border: Border.all(color: OiselyColors.outline.withAlpha(60)),
      ),
      child: Column(
        children: _addDividers(context, children),
      ),
    );
  }

  List<Widget> _addDividers(BuildContext context, List<Widget> children) {
    final result = <Widget>[];
    for (int i = 0; i < children.length; i++) {
      result.add(children[i]);
      if (i < children.length - 1) {
        result.add(
          Divider(
            height: 1,
            indent: 60,
            endIndent: 16,
            color: OiselyColors.outline.withAlpha(50),
          ),
        );
      }
    }
    return result;
  }
}

/// Individual settings tile
class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final Color accentColor;

  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
    this.accentColor = OiselyColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(OiselyShapes.cardRadius),
        child: Padding(
          padding: const EdgeInsets.all(OiselySpacing.md),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: accentColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: accentColor, size: 22),
              ),
              const SizedBox(width: OiselySpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: OiselyColors.onSurface,
                      ),
                    ),
                    if (subtitle != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          subtitle!,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: OiselyColors.onSurfaceVariant,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              if (onTap != null)
                Container(
                  padding: const EdgeInsets.all(6),
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

/// Switch settings tile for toggle options
class _SwitchSettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color accentColor;

  const _SwitchSettingsTile({
    required this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
    this.subtitle,
    this.accentColor = OiselyColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onChanged(!value),
        borderRadius: BorderRadius.circular(OiselyShapes.cardRadius),
        child: Padding(
          padding: const EdgeInsets.all(OiselySpacing.md),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: accentColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: accentColor, size: 22),
              ),
              const SizedBox(width: OiselySpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: OiselyColors.onSurface,
                      ),
                    ),
                    if (subtitle != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          subtitle!,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: OiselyColors.onSurfaceVariant,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Switch(
                value: value,
                onChanged: onChanged,
                activeColor: accentColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
/// Profile stat widget for bottom sheet
class _ProfileStat extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _ProfileStat({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 6),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: OiselyColors.onSurface,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            color: OiselyColors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}