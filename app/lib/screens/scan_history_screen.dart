import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../design_system/core/oisely_colors.dart';
import '../design_system/core/oisely_shapes.dart';
import '../design_system/core/oisely_spacing.dart';
import '../models/animal.dart';
import '../providers/adoption_provider.dart';
import 'animal_detail_screen.dart';

/// Scan History screen showing all identified animals
class ScanHistoryScreen extends StatelessWidget {
  const ScanHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final adoptionProvider = context.watch<AdoptionProvider>();
    final allAnimals = [
      ...adoptionProvider.adoptedAnimals,
      ...adoptionProvider.interestingAnimals,
    ];

    return Scaffold(
      backgroundColor: OiselyColors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // App Bar
          SliverAppBar(
            floating: true,
            snap: true,
            elevation: 0,
            backgroundColor: OiselyColors.background,
            surfaceTintColor: Colors.transparent,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: OiselyColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 18,
                  color: OiselyColors.onSurface,
                ),
              ),
            ),
            title: Text(
              'Scan History',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: OiselyColors.onSurface,
              ),
            ),
            centerTitle: true,
            actions: [
              if (allAnimals.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: OiselyColors.primary.withAlpha(20),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${allAnimals.length} scans',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: OiselyColors.primary,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          // Content
          if (allAnimals.isEmpty)
            SliverFillRemaining(
              child: _buildEmptyState(context),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.all(OiselySpacing.lg),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final animal = allAnimals[index];
                    final isAdopted =
                        adoptionProvider.adoptedAnimals.contains(animal);
                    return Padding(
                      padding: const EdgeInsets.only(bottom: OiselySpacing.md),
                      child: _HistoryCard(
                        animal: animal,
                        isAdopted: isAdopted,
                        index: index,
                      )
                          .animate()
                          .fadeIn(
                            delay: Duration(milliseconds: 50 * index),
                            duration: 400.ms,
                          )
                          .moveX(begin: 20, end: 0, duration: 400.ms),
                    );
                  },
                  childCount: allAnimals.length,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(OiselySpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: OiselyColors.accentTeal.withAlpha(30),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.history_rounded,
                size: 64,
                color: OiselyColors.accentTeal,
              ),
            )
                .animate(onPlay: (c) => c.repeat())
                .shimmer(duration: 2.seconds, color: Colors.white30),
            const SizedBox(height: OiselySpacing.xl),
            Text(
              'No Scans Yet',
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: OiselyColors.onSurface,
              ),
            ),
            const SizedBox(height: OiselySpacing.sm),
            Text(
              'Start scanning animals to build\nyour collection history!',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 15,
                color: OiselyColors.onSurfaceVariant,
                height: 1.5,
              ),
            ),
            const SizedBox(height: OiselySpacing.xl),
            FilledButton.icon(
              onPressed: () => Navigator.pop(context),
              style: FilledButton.styleFrom(
                backgroundColor: OiselyColors.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              icon: const Icon(Icons.camera_alt_outlined),
              label: const Text('Start Scanning'),
            ),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 500.ms)
        .scale(begin: const Offset(0.9, 0.9), duration: 500.ms);
  }
}

/// History card for individual animal
class _HistoryCard extends StatelessWidget {
  final Animal animal;
  final bool isAdopted;
  final int index;

  const _HistoryCard({
    required this.animal,
    required this.isAdopted,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final cardColor = OiselyColors.getCardColor(index);

    return GestureDetector(
      onTap: () {
        if (animal.adoptionInfo != null) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => AnimalDetailScreen(animal: animal),
            ),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: OiselyColors.surface,
          borderRadius: BorderRadius.circular(OiselyShapes.cardRadius),
          border: Border.all(color: cardColor.withAlpha(60)),
          boxShadow: OiselyShapes.softShadow,
        ),
        child: Row(
          children: [
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(16),
              ),
              child: SizedBox(
                width: 100,
                height: 100,
                child: animal.localImagePath != null
                    ? Image.file(
                        File(animal.localImagePath!),
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _buildPlaceholder(),
                      )
                    : _buildPlaceholder(),
              ),
            ),
            // Info
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(OiselySpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            animal.displayName,
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: OiselyColors.onSurface,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (isAdopted)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: OiselyColors.accentCoral.withAlpha(25),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.favorite,
                                  size: 12,
                                  color: OiselyColors.accentCoral,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Adopted',
                                  style: GoogleFonts.inter(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: OiselyColors.accentCoral,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      animal.adoptionInfo?.species ?? 'Unknown species',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: OiselyColors.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _InfoTag(
                          icon: Icons.category_outlined,
                          label: animal.adoptionInfo?.species ?? 'Unknown',
                          color: cardColor,
                        ),
                        const SizedBox(width: 8),
                        if (animal.adoptionInfo?.breed != null)
                          _InfoTag(
                            icon: Icons.pets_outlined,
                            label: animal.adoptionInfo!.breed!,
                            color: OiselyColors.secondary,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Arrow
            Padding(
              padding: const EdgeInsets.only(right: OiselySpacing.md),
              child: Icon(
                Icons.chevron_right_rounded,
                color: OiselyColors.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: OiselyColors.surfaceVariant,
      child: Center(
        child: Icon(
          Icons.pets,
          size: 40,
          color: OiselyColors.onSurfaceVariant.withAlpha(100),
        ),
      ),
    );
  }
}

/// Small info tag widget
class _InfoTag extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _InfoTag({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
