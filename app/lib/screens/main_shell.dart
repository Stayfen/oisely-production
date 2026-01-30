import 'dart:io';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../design_system/core/oisely_colors.dart';
import '../providers/navigation_provider.dart';
import '../widgets/image_picker_modal.dart';
import 'home_screen.dart';
import 'settings_screen.dart';

/// Main shell widget that contains the bottom navigation and manages
/// the IndexedStack for persistent page state
class MainShell extends StatefulWidget {
  final Function(File imageFile) onImageSelected;

  const MainShell({
    super.key,
    required this.onImageSelected,
  });

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> with TickerProviderStateMixin {
  // Page controller for the IndexedStack
  late final List<Widget> _pages;
  late AnimationController _fabAnimationController;
  late Animation<double> _fabAnimation;
  bool _isFabPressed = false;

  @override
  void initState() {
    super.initState();
    _pages = [
      const HomeScreen(),
      const SettingsScreen(),
    ];

    _fabAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _fabAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(parent: _fabAnimationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _fabAnimationController.dispose();
    super.dispose();
  }

  void _onCenterButtonPressed() {
    ImagePickerModal.show(
      context: context,
      onImageSelected: (file) {
        widget.onImageSelected(file);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final navigationProvider = context.watch<NavigationProvider>();

    return Scaffold(
      backgroundColor: OiselyColors.background,
      body: IndexedStack(
        index: navigationProvider.currentIndex,
        children: _pages,
      ),
      // Animated FAB with gradient and glow
      floatingActionButton: GestureDetector(
        onTapDown: (_) {
          setState(() => _isFabPressed = true);
          _fabAnimationController.forward();
        },
        onTapUp: (_) {
          setState(() => _isFabPressed = false);
          _fabAnimationController.reverse();
          _onCenterButtonPressed();
        },
        onTapCancel: () {
          setState(() => _isFabPressed = false);
          _fabAnimationController.reverse();
        },
        child: AnimatedBuilder(
          animation: _fabAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _fabAnimation.value,
              child: child,
            );
          },
          child: Container(
            width: 68,
            height: 68,
            decoration: BoxDecoration(
              gradient: OiselyColors.primaryGradient,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: OiselyColors.primary.withAlpha(
                    _isFabPressed ? 100 : 150,
                  ),
                  blurRadius: _isFabPressed ? 20 : 16,
                  offset: const Offset(0, 6),
                  spreadRadius: _isFabPressed ? 2 : 0,
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Outer ring animation
                if (!_isFabPressed)
                  Container(
                        width: 68,
                        height: 68,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: OiselyColors.primaryLight.withAlpha(100),
                            width: 2,
                          ),
                        ),
                      )
                      .animate(onPlay: (c) => c.repeat())
                      .scale(
                        begin: const Offset(1, 1),
                        end: const Offset(1.15, 1.15),
                        duration: 1500.ms,
                        curve: Curves.easeOut,
                      )
                      .fadeOut(duration: 1500.ms),
                // Icon
                Icon(
                  Icons.add_rounded,
                  size: 32,
                  color: OiselyColors.onPrimary,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // Enhanced animated bottom navigation bar
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: const [
          Icons.home_rounded,
          Icons.settings_rounded,
        ],
        activeIndex: navigationProvider.currentIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        leftCornerRadius: 28,
        rightCornerRadius: 28,
        notchMargin: 10,
        onTap: (index) => navigationProvider.setIndex(index),
        backgroundColor: OiselyColors.surface,
        activeColor: OiselyColors.primary,
        inactiveColor: OiselyColors.grey400,
        shadow: BoxShadow(
          offset: const Offset(0, -4),
          blurRadius: 20,
          color: OiselyColors.shadow,
        ),
        iconSize: 26,
        splashColor: OiselyColors.primaryContainer,
        splashSpeedInMilliseconds: 300,
        height: 65,
      ),
    );
  }
}

/// Alternative implementation using a custom bottom navigation bar
/// This provides more control over the design
class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final VoidCallback onCenterTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.onCenterTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Container(
          height: 72,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Home tab
              _NavBarItem(
                icon: Icons.home_outlined,
                isSelected: currentIndex == 0,
                onTap: () => onTap(0),
              ),
              // Spacer for center button
              const SizedBox(width: 64),
              // Settings tab
              _NavBarItem(
                icon: Icons.settings_outlined,
                isSelected: currentIndex == 1,
                onTap: () => onTap(1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Individual navigation bar item
class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? colorScheme.primaryContainer.withAlpha(128)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          size: 28,
          color: isSelected
              ? colorScheme.primary
              : colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
