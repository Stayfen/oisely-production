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

/// My Pets screen showing adopted animals
class MyPetsScreen extends StatelessWidget {
  const MyPetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final adoptionProvider = context.watch<AdoptionProvider>();
    final myPets = adoptionProvider.adoptedAnimals;

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
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('❤️ ', style: TextStyle(fontSize: 20)),
                Text(
                  'My Pets',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: OiselyColors.onSurface,
                  ),
                ),
              ],
            ),
            centerTitle: true,
            actions: [
              if (myPets.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: OiselyColors.accentCoral.withAlpha(25),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${myPets.length} pets',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: OiselyColors.accentCoral,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          // Content
          if (myPets.isEmpty)
            SliverFillRemaining(
              child: _buildEmptyState(context),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.all(OiselySpacing.lg),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.75,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final pet = myPets[index];
                    return _PetCard(pet: pet, index: index)
                        .animate()
                        .fadeIn(
                          delay: Duration(milliseconds: 80 * index),
                          duration: 400.ms,
                        )
                        .scale(
                          begin: const Offset(0.9, 0.9),
                          duration: 400.ms,
                        );
                  },
                  childCount: myPets.length,
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
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    OiselyColors.accentCoral.withAlpha(30),
                    OiselyColors.accentPink.withAlpha(30),
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.favorite_outline_rounded,
                size: 64,
                color: OiselyColors.accentCoral,
              ),
            )
                .animate(onPlay: (c) => c.repeat())
                .scale(
                  begin: const Offset(1, 1),
                  end: const Offset(1.05, 1.05),
                  duration: 1.seconds,
                )
                .then()
                .scale(
                  begin: const Offset(1.05, 1.05),
                  end: const Offset(1, 1),
                  duration: 1.seconds,
                ),
            const SizedBox(height: OiselySpacing.xl),
            Text(
              'No Pets Yet',
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: OiselyColors.onSurface,
              ),
            ),
            const SizedBox(height: OiselySpacing.sm),
            Text(
              'Scan animals and tap ❤️ to add\nthem to your collection!',
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
                backgroundColor: OiselyColors.accentCoral,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              icon: const Icon(Icons.pets),
              label: const Text('Start Collecting'),
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

/// Pet card for grid display
class _PetCard extends StatelessWidget {
  final Animal pet;
  final int index;

  const _PetCard({required this.pet, required this.index});

  @override
  Widget build(BuildContext context) {
    final cardColor = OiselyColors.getCardColor(index);

    return GestureDetector(
      onTap: () {
        if (pet.adoptionInfo != null) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => AnimalDetailScreen(animal: pet),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: pet.localImagePath != null
                          ? Image.file(
                              File(pet.localImagePath!),
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => _buildPlaceholder(),
                            )
                          : _buildPlaceholder(),
                    ),
                  ),
                  // Adopted badge
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: OiselyColors.accentCoral,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: OiselyColors.accentCoral.withAlpha(100),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.favorite,
                        size: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Info
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pet.displayName,
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: OiselyColors.onSurface,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      pet.adoptionInfo?.species ?? 'Unknown',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: OiselyColors.onSurfaceVariant,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: cardColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        pet.adoptionInfo?.species ?? 'Animal',
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: cardColor,
                        ),
                      ),
                    ),
                  ],
                ),
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
          size: 48,
          color: OiselyColors.onSurfaceVariant.withAlpha(100),
        ),
      ),
    );
  }
}
