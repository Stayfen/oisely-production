import 'dart:io';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

class _MainShellState extends State<MainShell> {
  // Page controller for the IndexedStack
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const HomeScreen(),
      const SettingsScreen(),
    ];
  }

  void _onCenterButtonPressed() {
    ImagePickerModal.show(
      context: context,
      onImageSelected: (file) {
        // Pass the selected file to the parent for processing
        widget.onImageSelected(file);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final navigationProvider = context.watch<NavigationProvider>();
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      // Use IndexedStack to maintain state of pages
      body: IndexedStack(
        index: navigationProvider.currentIndex,
        children: _pages,
      ),
      // Floating action button in the center
      floatingActionButton: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              colorScheme.primary,
              colorScheme.primaryContainer,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: colorScheme.primary.withAlpha(128),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: _onCenterButtonPressed,
            customBorder: const CircleBorder(),
            child: Icon(
              Icons.add,
              size: 32,
              color: colorScheme.onPrimary,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // Animated bottom navigation bar
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: const [
          Icons.home_outlined,
          Icons.settings_outlined,
        ],
        activeIndex: navigationProvider.currentIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        leftCornerRadius: 24,
        rightCornerRadius: 24,
        notchMargin: 8,
        onTap: (index) => navigationProvider.setIndex(index),
        backgroundColor: colorScheme.surface,
        activeColor: colorScheme.primary,
        inactiveColor: colorScheme.onSurfaceVariant,
        shadow: BoxShadow(
          offset: const Offset(0, -4),
          blurRadius: 12,
          color: Colors.black.withAlpha(25),
        ),
        iconSize: 28,
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
