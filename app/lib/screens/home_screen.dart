import 'dart:io';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oisely_client/oisely_client.dart';
import 'package:provider/provider.dart';
import '../design_system/core/oisely_colors.dart';
import '../design_system/core/oisely_shapes.dart';
import '../models/animal.dart';
import '../providers/adoption_provider.dart';
import '../providers/auth_provider.dart';
import 'animal_detail_screen.dart';
import 'nearby_services_screen.dart';
import 'sign_in_screen.dart';

/// The main home screen with horizontally scrolling animal lists
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _fabController;

  @override
  void initState() {
    super.initState();
    _fabController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _fabController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    // Refresh animation handled by RefreshIndicator
    await Future.delayed(const Duration(milliseconds: 800));
  }

  void _showLogoutBottomSheet(BuildContext context) {
    final authProvider = context.read<AuthProvider>();
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
                        const Divider(),
                        const SizedBox(height: 16),
                        _LogoutTile(
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

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final adoptionProvider = context.watch<AdoptionProvider>();

    final interestingAnimals = adoptionProvider.interestingAnimals;
    final adoptedAnimals = adoptionProvider.adoptedAnimals;

    return Scaffold(
      backgroundColor: OiselyColors.background,
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        color: OiselyColors.primary,
        backgroundColor: OiselyColors.surface,
        strokeWidth: 3,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: [
            // Animated App Bar
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Logo
                      Row(
                        children: [
                          Image.asset(
                            'assets/icons/icon.png',
                            width: 52,
                            height: 52,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Oisely',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: OiselyColors.primary,
                            ),
                          ),
                        ],
                      ),
                      // User avatar
                      GestureDetector(
                        onTap: () => _showLogoutBottomSheet(context),
                        child: _AnimatedUserAvatar(
                          imageUrl: authProvider.userProfileImageUrl,
                          displayName: authProvider.userDisplayName,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Content
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    // Welcome message with animation
                    _WelcomeSection(displayName: authProvider.userDisplayName),
                    const SizedBox(height: 20),

                    // Nearby Pet Services Card
                    _NearbyServicesCard(),
                    const SizedBox(height: 28),
                    _QuickStatsCard(
                      totalAnimals:
                          interestingAnimals.length + adoptedAnimals.length,
                      adoptedCount: adoptedAnimals.length,
                    ),
                    const SizedBox(height: 28),

                    // Interesting Animals Section
                    if (interestingAnimals.isNotEmpty) ...[
                      _AnimatedSectionHeader(
                        title: 'Interesting Animals',
                        count: interestingAnimals.length,
                        icon: Icons.explore_outlined,
                        iconColor: OiselyColors.secondary,
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: interestingAnimals.length,
                          itemBuilder: (context, index) {
                            return _AnimatedAnimalCard(
                              animal: interestingAnimals[index],
                              index: index,
                              cardColor: OiselyColors.getCardColor(index),
                              onTap: () => _navigateToDetail(
                                context,
                                interestingAnimals[index],
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 28),
                    ],

                    // Adopted Animals Section
                    if (adoptedAnimals.isNotEmpty) ...[
                      _AnimatedSectionHeader(
                        title: 'My Pets',
                        count: adoptedAnimals.length,
                        icon: Icons.favorite,
                        iconColor: OiselyColors.accentPink,
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: adoptedAnimals.length,
                          itemBuilder: (context, index) {
                            return _AnimatedAnimalCard(
                              animal: adoptedAnimals[index],
                              index: index,
                              cardColor: OiselyColors.getCardColor(index + 3),
                              onTap: () => _navigateToDetail(
                                context,
                                adoptedAnimals[index],
                              ),
                              showAdoptedBadge: true,
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 28),
                    ],

                    // Empty state when no animals
                    if (interestingAnimals.isEmpty && adoptedAnimals.isEmpty)
                      _AnimatedEmptyState(),

                    const SizedBox(height: 100), // Bottom padding for FAB
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToDetail(BuildContext context, Animal animal) {
    if (animal.adoptionInfo == null) return;

    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            AnimalDetailScreen(
              animal: animal,
            ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SharedAxisTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.scaled,
            child: child,
          );
        },
      ),
    );
  }
}

/// Welcome section with animated greeting
class _WelcomeSection extends StatelessWidget {
  final String displayName;

  const _WelcomeSection({required this.displayName});

  @override
  Widget build(BuildContext context) {
    final greeting = _getGreeting();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
              greeting,
              style: GoogleFonts.inter(
                fontSize: 16,
                color: OiselyColors.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            )
            .animate()
            .fadeIn(duration: 400.ms)
            .moveX(begin: -20, end: 0, duration: 400.ms),
        const SizedBox(height: 4),
        Text(
              displayName,
              style: GoogleFonts.inter(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: OiselyColors.onSurface,
              ),
            )
            .animate()
            .fadeIn(delay: 100.ms, duration: 400.ms)
            .moveX(begin: -20, end: 0, duration: 400.ms),
      ],
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning ☀️';
    if (hour < 17) return 'Good afternoon 🌤️';
    return 'Good evening 🌙';
  }
}

/// Nearby Pet Services Card for quick access
class _NearbyServicesCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const NearbyServicesScreen(),
          ),
        );
      },
      child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  OiselyColors.secondary.withAlpha(20),
                  OiselyColors.secondary.withAlpha(40),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(OiselyShapes.cardRadius),
              border: Border.all(
                color: OiselyColors.secondary.withAlpha(60),
                width: 1.5,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: OiselyColors.secondary.withAlpha(40),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.location_on_rounded,
                    color: OiselyColors.secondary,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Find Nearby Pet Services',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: OiselyColors.onSurface,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Vets, pet stores & more near you',
                        style: TextStyle(
                          fontSize: 13,
                          color: OiselyColors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: OiselyColors.secondary,
                  size: 24,
                ),
              ],
            ),
          )
          .animate()
          .fadeIn(duration: 400.ms)
          .slideX(begin: 0.05, end: 0, duration: 400.ms),
    );
  }
}

/// Quick stats card showing animal summary
class _QuickStatsCard extends StatelessWidget {
  final int totalAnimals;
  final int adoptedCount;

  const _QuickStatsCard({
    required this.totalAnimals,
    required this.adoptedCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                OiselyColors.primaryContainer,
                OiselyColors.cardGreen,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(OiselyShapes.cardRadius),
            boxShadow: OiselyShapes.softShadow,
          ),
          child: Row(
            children: [
              Expanded(
                child: _StatItem(
                  icon: Icons.pets,
                  value: totalAnimals.toString(),
                  label: 'Total Animals',
                  iconColor: OiselyColors.primary,
                ),
              ),
              Container(
                width: 1,
                height: 50,
                color: OiselyColors.primary.withAlpha(50),
              ),
              Expanded(
                child: _StatItem(
                  icon: Icons.favorite,
                  value: adoptedCount.toString(),
                  label: 'Adopted',
                  iconColor: OiselyColors.accentPink,
                ),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(delay: 200.ms, duration: 500.ms)
        .scale(
          begin: const Offset(0.95, 0.95),
          end: const Offset(1, 1),
          duration: 500.ms,
          curve: Curves.easeOut,
        );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color iconColor;

  const _StatItem({
    required this.icon,
    required this.value,
    required this.label,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: iconColor, size: 28),
        const SizedBox(height: 8),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: OiselyColors.onSurface,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: OiselyColors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

/// Animated section header
class _AnimatedSectionHeader extends StatelessWidget {
  final String title;
  final int count;
  final IconData icon;
  final Color iconColor;

  const _AnimatedSectionHeader({
    required this.title,
    required this.count,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
          children: [
            // Icon box
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconColor.withAlpha(30),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 12),
            // Title
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: OiselyColors.onSurface,
              ),
            ),
            const SizedBox(width: 10),
            // Count badge
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 3,
              ),
              decoration: BoxDecoration(
                color: iconColor.withAlpha(30),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '$count',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: iconColor,
                ),
              ),
            ),
          ],
        )
        .animate()
        .fadeIn(delay: 300.ms, duration: 400.ms)
        .moveX(begin: -20, end: 0, duration: 400.ms);
  }
}

/// Logout tile widget
class _LogoutTile extends StatelessWidget {
  final VoidCallback onTap;

  const _LogoutTile({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: OiselyColors.errorContainer,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: OiselyColors.error.withAlpha(30),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.logout,
                  color: OiselyColors.error,
                  size: 22,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sign Out',
                      style: TextStyle(
                        color: OiselyColors.error,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Clear session and return to login',
                      style: TextStyle(
                        color: OiselyColors.error.withAlpha(180),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: OiselyColors.error.withAlpha(150),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Animated user avatar with border glow
class _AnimatedUserAvatar extends StatelessWidget {
  final String? imageUrl;
  final String displayName;

  const _AnimatedUserAvatar({
    this.imageUrl,
    required this.displayName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: OiselyColors.primaryGradient,
        boxShadow: [
          BoxShadow(
            color: OiselyColors.primary.withAlpha(40),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(2),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: OiselyColors.surface,
        ),
        child: ClipOval(
          child: imageUrl != null
              ? Image.network(
                  imageUrl!,
                  fit: BoxFit.cover,
                  width: 32,
                  height: 32,
                  errorBuilder: (context, error, stackTrace) {
                    return _buildFallbackAvatar();
                  },
                )
              : _buildFallbackAvatar(),
        ),
      ),
    );
  }

  Widget _buildFallbackAvatar() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            OiselyColors.primary,
            OiselyColors.secondary,
          ],
        ),
      ),
      child: Center(
        child: Icon(
          Icons.person,
          color: Colors.white,
          size: 18,
        ),
      ),
    );
  }
}

/// Animated animal card with hover effects
class _AnimatedAnimalCard extends StatelessWidget {
  final Animal animal;
  final int index;
  final Color cardColor;
  final VoidCallback onTap;
  final bool showAdoptedBadge;

  const _AnimatedAnimalCard({
    required this.animal,
    required this.index,
    required this.cardColor,
    required this.onTap,
    this.showAdoptedBadge = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child:
          Container(
                width: 155,
                margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  color: OiselyColors.surface,
                  borderRadius: BorderRadius.circular(OiselyShapes.cardRadius),
                  boxShadow: OiselyShapes.mediumShadow,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(OiselyShapes.cardRadius),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Image
                      Hero(
                        tag: 'animal_image_${animal.id}',
                        child: animal.localImagePath != null
                            ? Image.file(
                                File(animal.localImagePath!),
                                fit: BoxFit.cover,
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      cardColor,
                                      cardColor.withAlpha(200),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                                child: Icon(
                                  Icons.pets,
                                  size: 56,
                                  color: OiselyColors.primary.withAlpha(100),
                                ),
                              ),
                      ),
                      // Gradient overlay
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.transparent,
                              Colors.black.withAlpha(180),
                            ],
                            stops: const [0.0, 0.4, 1.0],
                          ),
                        ),
                      ),
                      // Adopted badge
                      if (showAdoptedBadge)
                        Positioned(
                          top: 10,
                          right: 10,
                          child:
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      OiselyColors.success,
                                      OiselyColors.success.withAlpha(200),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: OiselyColors.success.withAlpha(80),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.favorite,
                                      size: 12,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      'Adopted',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ).animate().scale(
                                begin: const Offset(0, 0),
                                end: const Offset(1, 1),
                                duration: 400.ms,
                                curve: Curves.elasticOut,
                                delay: Duration(
                                  milliseconds: 300 + (index * 50),
                                ),
                              ),
                        ),
                      // Name at bottom
                      Positioned(
                        left: 14,
                        right: 14,
                        bottom: 14,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              animal.displayName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            if (animal.breed != null) ...[
                              const SizedBox(height: 2),
                              Text(
                                animal.breed!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white.withAlpha(200),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .animate()
              .fadeIn(
                delay: Duration(milliseconds: 100 * index),
                duration: 400.ms,
              )
              .moveX(
                begin: 30,
                end: 0,
                delay: Duration(milliseconds: 100 * index),
                duration: 400.ms,
                curve: Curves.easeOutCubic,
              ),
    );
  }
}

/// Animated empty state
class _AnimatedEmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
            padding: const EdgeInsets.all(40),
            margin: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  OiselyColors.primaryContainer.withAlpha(100),
                  OiselyColors.cardGreen.withAlpha(100),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(OiselyShapes.cardRadius),
              border: Border.all(
                color: OiselyColors.primary.withAlpha(50),
                width: 1.5,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: OiselyColors.primaryContainer,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.camera_alt_outlined,
                        size: 48,
                      color: OiselyColors.primary,
                    ),
                  )
                  .animate(onPlay: (c) => c.repeat())
                  .moveY(
                    begin: 0,
                    end: -10,
                    duration: 1500.ms,
                    curve: Curves.easeInOut,
                  )
                  .then()
                  .moveY(
                    begin: -10,
                    end: 0,
                    duration: 1500.ms,
                    curve: Curves.easeInOut,
                  ),
              const SizedBox(height: 24),
              Text(
                'Your Zoo Awaits! 🦁',
                style: GoogleFonts.inter(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: OiselyColors.onSurface,
                ),
              ).animate().fadeIn(delay: 200.ms, duration: 400.ms),
              const SizedBox(height: 10),
              Text(
                'Tap the + button below to identify\nyour first animal friend!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: OiselyColors.onSurfaceVariant,
                  fontSize: 15,
                  height: 1.5,
                ),
              ).animate().fadeIn(delay: 300.ms, duration: 400.ms),
              const SizedBox(height: 24),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 10,
                runSpacing: 10,
                children: [
                  _FeatureChip(icon: Icons.camera_alt, label: 'Snap'),
                  _FeatureChip(icon: Icons.psychology, label: 'Analyze'),
                  _FeatureChip(icon: Icons.favorite, label: 'Adopt'),
                ],
              ).animate().fadeIn(delay: 400.ms, duration: 400.ms),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 500.ms)
        .scale(
          begin: const Offset(0.95, 0.95),
          end: const Offset(1, 1),
          duration: 500.ms,
        ),
    );
  }
}

class _FeatureChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _FeatureChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: OiselyColors.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: OiselyShapes.softShadow,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: OiselyColors.primary),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: OiselyColors.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
