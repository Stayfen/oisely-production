import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../design_system/core/oisely_colors.dart';
import '../design_system/core/oisely_shapes.dart';
import '../design_system/core/oisely_spacing.dart';
import '../providers/nearby_services_provider.dart';

class NearbyServicesScreen extends StatefulWidget {
  const NearbyServicesScreen({super.key});

  @override
  State<NearbyServicesScreen> createState() => _NearbyServicesScreenState();
}

class _NearbyServicesScreenState extends State<NearbyServicesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<NearbyServicesProvider>();
      provider.fetchNearbyServices();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NearbyServicesProvider>();

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
            toolbarHeight: 60,
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: OiselyColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.arrow_back_ios_new, size: 18),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 60, right: 20, top: 10),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            OiselyColors.secondary,
                            OiselyColors.accentTeal,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: OiselyColors.secondary.withAlpha(60),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.store_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Nearby Services',
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

          // Filter chips and radius selector
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(OiselySpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFilterSection(provider),
                  const SizedBox(height: OiselySpacing.md),
                  _buildRadiusSelector(provider),
                ],
              ),
            ),
          ),

          // Location permission denied state
          if (provider.locationPermissionDenied)
            SliverFillRemaining(
              child: _buildLocationPermissionDenied(context, provider),
            )
          // Loading state
          else if (provider.isLoading && provider.places.isEmpty)
            SliverPadding(
              padding: const EdgeInsets.all(OiselySpacing.md),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => _buildShimmerCard(),
                  childCount: 5,
                ),
              ),
            )
          // Error state
          else if (provider.error != null && provider.places.isEmpty)
            SliverFillRemaining(
              child: _buildErrorState(context, provider),
            )
          // Empty state
          else if (provider.places.isEmpty)
            SliverFillRemaining(
              child: _buildEmptyState(context, provider),
            )
          // Results list
          else
            SliverPadding(
              padding: const EdgeInsets.all(OiselySpacing.md),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index == provider.filteredPlaces.length) {
                      // Load more indicator
                      if (provider.hasMorePages) {
                        provider.loadMore();
                        return const Padding(
                          padding: EdgeInsets.all(16),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    }
                    return _PlaceCard(
                      place: provider.filteredPlaces[index],
                      index: index,
                      userPosition: provider.currentPosition,
                    );
                  },
                  childCount: provider.filteredPlaces.length + 1,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFilterSection(NearbyServicesProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'FILTER BY TYPE',
          style: GoogleFonts.inter(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: OiselyColors.onSurfaceVariant,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _FilterChip(
              label: 'All',
              icon: Icons.pets,
              isSelected: provider.selectedFilter == 'both',
              onTap: () => provider.setFilter('both'),
              color: OiselyColors.primary,
            ),
            const SizedBox(width: 8),
            _FilterChip(
              label: 'Vets',
              icon: Icons.local_hospital,
              isSelected: provider.selectedFilter == 'veterinary_care',
              onTap: () => provider.setFilter('veterinary_care'),
              color: OiselyColors.accentCoral,
            ),
            const SizedBox(width: 8),
            _FilterChip(
              label: 'Pet Stores',
              icon: Icons.store,
              isSelected: provider.selectedFilter == 'pet_store',
              onTap: () => provider.setFilter('pet_store'),
              color: OiselyColors.secondary,
            ),
          ],
        ),
      ],
    ).animate().fadeIn(duration: 300.ms).moveY(begin: 10, end: 0);
  }

  Widget _buildRadiusSelector(NearbyServicesProvider provider) {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'SEARCH RADIUS',
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: OiselyColors.onSurfaceVariant,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _RadiusChip(
                  label: '2 km',
                  value: 2000,
                  isSelected: provider.selectedRadius == 2000,
                  onTap: () => provider.setRadius(2000),
                ),
                const SizedBox(width: 8),
                _RadiusChip(
                  label: '5 km',
                  value: 5000,
                  isSelected: provider.selectedRadius == 5000,
                  onTap: () => provider.setRadius(5000),
                ),
                const SizedBox(width: 8),
                _RadiusChip(
                  label: '10 km',
                  value: 10000,
                  isSelected: provider.selectedRadius == 10000,
                  onTap: () => provider.setRadius(10000),
                ),
              ],
            ),
          ],
        )
        .animate()
        .fadeIn(delay: 100.ms, duration: 300.ms)
        .moveY(begin: 10, end: 0);
  }

  Widget _buildShimmerCard() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Shimmer.fromColors(
        baseColor: OiselyColors.surfaceVariant,
        highlightColor: OiselyColors.surface,
        child: Container(
          height: 140,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(OiselyShapes.cardRadius),
          ),
        ),
      ),
    );
  }

  Widget _buildLocationPermissionDenied(
    BuildContext context,
    NearbyServicesProvider provider,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(OiselySpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: OiselyColors.error.withAlpha(20),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.location_off_rounded,
                size: 64,
                color: OiselyColors.error,
              ),
            ),
            const SizedBox(height: OiselySpacing.lg),
            Text(
              'Location Access Required',
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: OiselyColors.onSurface,
              ),
            ),
            const SizedBox(height: OiselySpacing.sm),
            Text(
              provider.error ??
                  'We need your location to find nearby pet services.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: OiselyColors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: OiselySpacing.xl),
            FilledButton.icon(
              onPressed: () async {
                await provider.checkLocationPermission();
                if (!provider.locationPermissionDenied) {
                  provider.fetchNearbyServices(refresh: true);
                }
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
              style: FilledButton.styleFrom(
                backgroundColor: OiselyColors.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
            const SizedBox(height: OiselySpacing.sm),
            TextButton(
              onPressed: () {
                // Open app settings
                launchUrl(Uri.parse('app-settings:'));
              },
              child: Text(
                'Open Settings',
                style: GoogleFonts.inter(
                  color: OiselyColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 400.ms).scale(begin: const Offset(0.9, 0.9));
  }

  Widget _buildErrorState(
    BuildContext context,
    NearbyServicesProvider provider,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(OiselySpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: OiselyColors.accentCoral.withAlpha(20),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.cloud_off_rounded,
                size: 64,
                color: OiselyColors.accentCoral,
              ),
            ),
            const SizedBox(height: OiselySpacing.lg),
            Text(
              'Something went wrong',
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: OiselyColors.onSurface,
              ),
            ),
            const SizedBox(height: OiselySpacing.sm),
            Text(
              provider.error ?? 'Failed to load nearby services',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: OiselyColors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: OiselySpacing.xl),
            FilledButton.icon(
              onPressed: () => provider.fetchNearbyServices(refresh: true),
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
              style: FilledButton.styleFrom(
                backgroundColor: OiselyColors.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 400.ms);
  }

  Widget _buildEmptyState(
    BuildContext context,
    NearbyServicesProvider provider,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(OiselySpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: OiselyColors.accentLavender.withAlpha(30),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.search_off_rounded,
                size: 64,
                color: OiselyColors.accentLavender,
              ),
            ),
            const SizedBox(height: OiselySpacing.lg),
            Text(
              'No Services Found',
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: OiselyColors.onSurface,
              ),
            ),
            const SizedBox(height: OiselySpacing.sm),
            Text(
              'No pet services found within ${provider.selectedRadius ~/ 1000}km.\nTry increasing the search radius.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: OiselyColors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: OiselySpacing.xl),
            FilledButton.icon(
              onPressed: () => provider.setRadius(10000),
              icon: const Icon(Icons.expand),
              label: const Text('Search 10km'),
              style: FilledButton.styleFrom(
                backgroundColor: OiselyColors.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 400.ms);
  }
}

/// Filter chip widget
class _FilterChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;
  final Color color;

  const _FilterChip({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? color : OiselyColors.surfaceVariant,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? color : OiselyColors.outline.withAlpha(50),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? Colors.white : OiselyColors.onSurfaceVariant,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isSelected
                    ? Colors.white
                    : OiselyColors.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Radius chip widget
class _RadiusChip extends StatelessWidget {
  final String label;
  final int value;
  final bool isSelected;
  final VoidCallback onTap;

  const _RadiusChip({
    required this.label,
    required this.value,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? OiselyColors.primary
              : OiselyColors.surfaceVariant,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? OiselyColors.primary
                : OiselyColors.outline.withAlpha(50),
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : OiselyColors.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}

/// Place card widget
class _PlaceCard extends StatelessWidget {
  final dynamic place; // NearbyPlace from oisely_client
  final int index;
  final dynamic userPosition; // Position from geolocator

  const _PlaceCard({
    required this.place,
    required this.index,
    this.userPosition,
  });

  @override
  Widget build(BuildContext context) {
    final isVet = (place.types as List).contains('veterinary_care');
    final cardColor = isVet ? OiselyColors.accentCoral : OiselyColors.secondary;

    return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: OiselyColors.surface,
            borderRadius: BorderRadius.circular(OiselyShapes.cardRadius),
            boxShadow: OiselyShapes.mediumShadow,
            border: Border.all(color: OiselyColors.outline.withAlpha(30)),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => _showPlaceDetails(context, place, cardColor),
              borderRadius: BorderRadius.circular(OiselyShapes.cardRadius),
              child: Padding(
                padding: const EdgeInsets.all(OiselySpacing.md),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Icon/Photo
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: cardColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        isVet ? Icons.local_hospital : Icons.store,
                        color: cardColor,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: OiselySpacing.md),
                    // Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Name and type badge
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  place.name,
                                  style: GoogleFonts.inter(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: OiselyColors.onSurface,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: cardColor.withAlpha(25),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  isVet ? 'Vet' : 'Store',
                                  style: GoogleFonts.inter(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: cardColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          // Address
                          Text(
                            place.address,
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: OiselyColors.onSurfaceVariant,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          // Rating, distance, open status
                          Row(
                            children: [
                              // Rating
                              if (place.rating != null) ...[
                                Icon(
                                  Icons.star,
                                  size: 14,
                                  color: OiselyColors.accentYellow,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${place.rating}',
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: OiselyColors.onSurface,
                                  ),
                                ),
                                if (place.userRatingsTotal != null)
                                  Text(
                                    ' (${place.userRatingsTotal})',
                                    style: GoogleFonts.inter(
                                      fontSize: 11,
                                      color: OiselyColors.onSurfaceVariant,
                                    ),
                                  ),
                                const SizedBox(width: 12),
                              ],
                              // Distance
                              if (place.distance != null) ...[
                                Icon(
                                  Icons.location_on,
                                  size: 14,
                                  color: OiselyColors.primary,
                                ),
                                const SizedBox(width: 2),
                                Text(
                                  _formatDistance(place.distance),
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: OiselyColors.primary,
                                  ),
                                ),
                                const SizedBox(width: 12),
                              ],
                              // Open status
                              if (place.isOpen != null)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: place.isOpen
                                        ? OiselyColors.success.withAlpha(20)
                                        : OiselyColors.error.withAlpha(20),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    place.isOpen ? 'Open' : 'Closed',
                                    style: GoogleFonts.inter(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: place.isOpen
                                          ? OiselyColors.success
                                          : OiselyColors.error,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Navigate button
                    IconButton(
                      onPressed: () => _openDirections(place),
                      icon: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          gradient: OiselyColors.primaryGradient,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.directions,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
        .animate()
        .fadeIn(
          delay: Duration(milliseconds: 50 * index),
          duration: 300.ms,
        )
        .moveY(begin: 20, end: 0, duration: 300.ms);
  }

  String _formatDistance(double meters) {
    if (meters < 1000) {
      return '${meters.round()}m';
    }
    return '${(meters / 1000).toStringAsFixed(1)}km';
  }

  void _openDirections(dynamic place) async {
    final lat = place.latitude;
    final lng = place.longitude;

    // Try Google Maps navigation first
    final googleMapsUrl = Uri.parse(
      'google.navigation:q=$lat,$lng&mode=d',
    );

    if (await canLaunchUrl(googleMapsUrl)) {
      await launchUrl(googleMapsUrl);
    } else {
      // Fallback to Google Maps web
      final webUrl = Uri.parse(
        'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng',
      );
      await launchUrl(webUrl, mode: LaunchMode.externalApplication);
    }
  }

  void _showPlaceDetails(BuildContext context, dynamic place, Color color) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => _PlaceDetailsSheet(place: place, color: color),
    );
  }
}

/// Place details bottom sheet
class _PlaceDetailsSheet extends StatelessWidget {
  final dynamic place;
  final Color color;

  const _PlaceDetailsSheet({required this.place, required this.color});

  @override
  Widget build(BuildContext context) {
    final isVet = (place.types as List).contains('veterinary_care');

    return Container(
      decoration: BoxDecoration(
        color: OiselyColors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(top: 12),
            decoration: BoxDecoration(
              color: OiselyColors.outline,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(OiselySpacing.xl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [color, color.withAlpha(200)],
                        ),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(
                        isVet ? Icons.local_hospital : Icons.store,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            place.name,
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: OiselyColors.onSurface,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: color.withAlpha(25),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  isVet ? 'Veterinarian' : 'Pet Store',
                                  style: GoogleFonts.inter(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: color,
                                  ),
                                ),
                              ),
                              if (place.isOpen != null) ...[
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: place.isOpen
                                        ? OiselyColors.success.withAlpha(20)
                                        : OiselyColors.error.withAlpha(20),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    place.isOpen ? 'Open Now' : 'Closed',
                                    style: GoogleFonts.inter(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: place.isOpen
                                          ? OiselyColors.success
                                          : OiselyColors.error,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: OiselySpacing.lg),

                // Info cards
                Row(
                  children: [
                    // Rating
                    if (place.rating != null)
                      Expanded(
                        child: _InfoCard(
                          icon: Icons.star,
                          iconColor: OiselyColors.accentYellow,
                          label: 'Rating',
                          value: '${place.rating}',
                          subtitle: place.userRatingsTotal != null
                              ? '${place.userRatingsTotal} reviews'
                              : null,
                        ),
                      ),
                    if (place.rating != null && place.distance != null)
                      const SizedBox(width: 12),
                    // Distance
                    if (place.distance != null)
                      Expanded(
                        child: _InfoCard(
                          icon: Icons.location_on,
                          iconColor: OiselyColors.primary,
                          label: 'Distance',
                          value: _formatDistance(place.distance),
                          subtitle: 'from you',
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: OiselySpacing.md),

                // Address
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(OiselySpacing.md),
                  decoration: BoxDecoration(
                    color: OiselyColors.surfaceVariant.withAlpha(80),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.pin_drop,
                        color: OiselyColors.onSurfaceVariant,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          place.address,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: OiselyColors.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: OiselySpacing.xl),

                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close),
                        label: const Text('Close'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          side: BorderSide(color: OiselyColors.outline),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          _openDirections(place);
                        },
                        icon: const Icon(Icons.directions),
                        label: const Text('Directions'),
                        style: FilledButton.styleFrom(
                          backgroundColor: OiselyColors.primary,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).padding.bottom + 8),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDistance(double meters) {
    if (meters < 1000) {
      return '${meters.round()}m';
    }
    return '${(meters / 1000).toStringAsFixed(1)}km';
  }

  void _openDirections(dynamic place) async {
    final lat = place.latitude;
    final lng = place.longitude;

    final googleMapsUrl = Uri.parse(
      'google.navigation:q=$lat,$lng&mode=d',
    );

    if (await canLaunchUrl(googleMapsUrl)) {
      await launchUrl(googleMapsUrl);
    } else {
      final webUrl = Uri.parse(
        'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng',
      );
      await launchUrl(webUrl, mode: LaunchMode.externalApplication);
    }
  }
}

/// Info card widget
class _InfoCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;
  final String? subtitle;

  const _InfoCard({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(OiselySpacing.md),
      decoration: BoxDecoration(
        color: iconColor.withAlpha(15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: iconColor.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: iconColor),
              const SizedBox(width: 6),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: OiselyColors.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: OiselyColors.onSurface,
            ),
          ),
          if (subtitle != null)
            Text(
              subtitle!,
              style: GoogleFonts.inter(
                fontSize: 11,
                color: OiselyColors.onSurfaceVariant,
              ),
            ),
        ],
      ),
    );
  }
}
