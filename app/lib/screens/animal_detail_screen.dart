import 'dart:io';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../design_system/core/oisely_colors.dart';
import '../design_system/core/oisely_shapes.dart';
import '../design_system/core/oisely_spacing.dart';
import '../models/animal.dart';
import '../providers/adoption_provider.dart';
import '../providers/care_plan_provider.dart';
import 'behavior_analysis_history_screen.dart';
import 'behavior_analysis_screen.dart';
import 'care_plan_screen.dart';

/// Screen that displays detailed information about an identified animal
class AnimalDetailScreen extends StatefulWidget {
  final Animal animal;

  const AnimalDetailScreen({
    super.key,
    required this.animal,
  });

  @override
  State<AnimalDetailScreen> createState() => _AnimalDetailScreenState();
}

class _AnimalDetailScreenState extends State<AnimalDetailScreen> {
  bool _isGeneratingCarePlan = false;
  double _generationProgress = 0.0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final adoptionInfo = widget.animal.adoptionInfo;

    if (adoptionInfo == null) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: OiselyColors.surfaceVariant,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.pets,
                  size: 48,
                  color: OiselyColors.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'No information available',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: OiselyColors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App bar with hero image
          SliverAppBar(
            expandedHeight: 380,
            pinned: true,
            stretch: true,
            backgroundColor: OiselyColors.primary,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(60),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: 'animal_image_${widget.animal.id}',
                    child: widget.animal.localImagePath != null
                        ? Image.file(
                            File(widget.animal.localImagePath!),
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          )
                        : Container(
                            decoration: BoxDecoration(
                              gradient: OiselyColors.primaryGradient,
                            ),
                            child: Icon(
                              Icons.pets,
                              size: 100,
                              color: Colors.white.withAlpha(150),
                            ),
                          ),
                  ),
                  // Gradient overlay for better text visibility
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    height: 150,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withAlpha(100),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Content
          SliverToBoxAdapter(
            child: Transform.translate(
              offset: const Offset(0, -24),
              child: Container(
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(28),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(OiselySpacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Handle bar
                      Center(
                        child: Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: colorScheme.outlineVariant,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      const SizedBox(height: OiselySpacing.lg),

                      // Species name and confidence badge
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      adoptionInfo.species,
                                      style: GoogleFonts.inter(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                        color: colorScheme.onSurface,
                                      ),
                                    ),
                                    if (adoptionInfo.breed != null &&
                                        adoptionInfo.breed!.isNotEmpty)
                                      Padding(
                                        padding: const EdgeInsets.only(top: 4),
                                        child: Text(
                                          adoptionInfo.breed!,
                                          style: GoogleFonts.inter(
                                            fontSize: 16,
                                            fontStyle: FontStyle.italic,
                                            color: colorScheme.onSurfaceVariant,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              )
                              .animate()
                              .fadeIn(duration: 400.ms)
                              .moveX(begin: -20, end: 0, duration: 400.ms),
                          // Confidence percentage badge
                          _ConfidenceBadge(confidence: adoptionInfo.confidence)
                              .animate()
                              .fadeIn(delay: 200.ms, duration: 400.ms)
                              .scale(
                                begin: const Offset(0.5, 0.5),
                                end: const Offset(1, 1),
                                duration: 400.ms,
                                curve: Curves.elasticOut,
                              ),
                        ],
                      ),
                      const SizedBox(height: OiselySpacing.xl),

                      // Conditional Action Button
                      _buildActionButton(context)
                          .animate()
                          .fadeIn(delay: 300.ms, duration: 400.ms)
                          .moveY(begin: 20, end: 0, duration: 400.ms),
                      const SizedBox(height: OiselySpacing.md),

                      // Behavior Analysis History Card (only for adopted animals with analyses)
                      _buildBehaviorAnalysisHistoryCard(context),
                      const SizedBox(height: OiselySpacing.xl),

                      // Main info card
                      _buildAboutCard(context, adoptionInfo)
                          .animate()
                          .fadeIn(delay: 400.ms, duration: 400.ms)
                          .moveY(begin: 20, end: 0, duration: 400.ms),
                      const SizedBox(height: OiselySpacing.md),

                      // Care Instructions Card
                      _buildInfoCard(
                        context,
                        icon: Icons.healing_outlined,
                        title: 'Care Instructions',
                        content: adoptionInfo.careInstructions,
                        accentColor: OiselyColors.accentPink,
                        delay: 500,
                      ),
                      const SizedBox(height: OiselySpacing.md),

                      // Dietary Requirements Card
                      _buildInfoCard(
                        context,
                        icon: Icons.restaurant_outlined,
                        title: 'Dietary Requirements',
                        content: adoptionInfo.dietaryRequirements,
                        accentColor: OiselyColors.secondary,
                        delay: 600,
                      ),
                      const SizedBox(height: OiselySpacing.md),

                      // Living Environment Card
                      _buildInfoCard(
                        context,
                        icon: Icons.home_outlined,
                        title: 'Living Environment',
                        content: adoptionInfo.livingEnvironment,
                        accentColor: OiselyColors.tertiary,
                        delay: 700,
                      ),
                      const SizedBox(height: OiselySpacing.md),

                      // Legal Requirements Card (if available and not "Unknown")
                      if (adoptionInfo.legalRequirements != 'Unknown' &&
                          adoptionInfo.legalRequirements.isNotEmpty)
                        _buildInfoCard(
                          context,
                          icon: Icons.gavel_outlined,
                          title: 'Legal Requirements',
                          content: adoptionInfo.legalRequirements,
                          accentColor: OiselyColors.accentLavender,
                          delay: 800,
                        ),

                      const SizedBox(height: OiselySpacing.xxl),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutCard(BuildContext context, dynamic adoptionInfo) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            OiselyColors.primary.withAlpha(15),
            OiselyColors.tertiary.withAlpha(10),
          ],
        ),
        borderRadius: BorderRadius.circular(OiselyShapes.cardRadius),
        border: Border.all(color: OiselyColors.primary.withAlpha(40)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(OiselySpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // About section header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: OiselyColors.primary.withAlpha(30),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.info_outline,
                    color: OiselyColors.primary,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'About',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
              ],
            ),
            const SizedBox(height: OiselySpacing.md),
            Text(
              adoptionInfo.breedSpecificInfo,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurfaceVariant,
                height: 1.6,
              ),
            ),
            const SizedBox(height: OiselySpacing.lg),

            // Key Info Chips
            Text(
              'Key Information',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: OiselySpacing.sm),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _InfoChip(
                  icon: Icons.attach_money,
                  label: adoptionInfo.adoptionCost,
                  color: OiselyColors.accentYellow,
                ),
                _InfoChip(
                  icon: Icons.schedule,
                  label: adoptionInfo.dailyTimeCommitment,
                  color: OiselyColors.accentCoral,
                ),
                _InfoChip(
                  icon: Icons.favorite_outline,
                  label: adoptionInfo.averageLifespan,
                  color: OiselyColors.accentPink,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _generateCarePlanAndNavigate(BuildContext context) async {
    setState(() {
      _isGeneratingCarePlan = true;
      _generationProgress = 0.0;
    });

    // Create a temporary provider to generate the care plan
    final animalIdInt = widget.animal.id.hashCode.abs();
    final provider = CarePlanProvider(
      animalId: widget.animal.id,
      animalIdentificationRecordId: animalIdInt,
    );

    // Start generation
    final generationFuture = provider.generateCarePlan();

    // Simulate progress updates
    _simulateProgress();

    // Navigate immediately while generation continues in background
    if (mounted) {
      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              CarePlanScreen(animal: widget.animal),
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

    // Wait for generation to complete
    await generationFuture;

    if (mounted) {
      setState(() {
        _isGeneratingCarePlan = false;
      });
    }
  }

  void _simulateProgress() {
    Future.delayed(const Duration(milliseconds: 200), () {
      if (!mounted || !_isGeneratingCarePlan) return;

      setState(() {
        _generationProgress = 0.2;
      });

      Future.delayed(const Duration(milliseconds: 400), () {
        if (!mounted || !_isGeneratingCarePlan) return;
        setState(() {
          _generationProgress = 0.5;
        });
      });

      Future.delayed(const Duration(milliseconds: 800), () {
        if (!mounted || !_isGeneratingCarePlan) return;
        setState(() {
          _generationProgress = 0.8;
        });
      });
    });
  }

  Widget _buildActionButton(BuildContext context) {
    final adoptionProvider = context.watch<AdoptionProvider>();
    final isAdopted = adoptionProvider.isAdopted(widget.animal.id);

    if (isAdopted) {
      // Show action buttons for adopted animals
      return Column(
        children: [
          // Behavior Analysis button
          _ActionButton(
            icon: Icons.psychology,
            label: 'Behavior Analysis',
            emoji: '🧠',
            gradient: LinearGradient(
              colors: [
                OiselyColors.tertiary,
                OiselyColors.tertiary.withAlpha(200),
              ],
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => BehaviorAnalysisScreen(animal: widget.animal),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          // Create Care Plan button
          _ActionButton(
            icon: _isGeneratingCarePlan ? null : Icons.calendar_today,
            label: _isGeneratingCarePlan
                ? 'Generating... ${(_generationProgress * 100).toInt()}%'
                : 'Create Care Plan',
            emoji: '📋',
            gradient: OiselyColors.primaryGradient,
            isLoading: _isGeneratingCarePlan,
            progress: _generationProgress,
            onPressed: _isGeneratingCarePlan
                ? null
                : () => _generateCarePlanAndNavigate(context),
          ),
        ],
      );
    } else {
      // Show "Adopt" button for non-adopted animals
      return _ActionButton(
        icon: Icons.favorite_outline,
        label: 'Adopt This Pet',
        emoji: '❤️',
        gradient: LinearGradient(
          colors: [
            OiselyColors.accentPink,
            OiselyColors.accentCoral,
          ],
        ),
        onPressed: () async {
          await adoptionProvider.adoptAnimal(widget.animal.id);
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    const Text('🎉 '),
                    Text('${widget.animal.species} has been adopted!'),
                  ],
                ),
                behavior: SnackBarBehavior.floating,
                backgroundColor: OiselyColors.success,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            );
          }
        },
      );
    }
  }

  Widget _buildBehaviorAnalysisHistoryCard(BuildContext context) {
    final adoptionProvider = context.watch<AdoptionProvider>();
    final colorScheme = Theme.of(context).colorScheme;
    final isAdopted = adoptionProvider.isAdopted(widget.animal.id);

    // Only show for adopted animals
    if (!isAdopted) return const SizedBox.shrink();

    final analyses = adoptionProvider.getBehaviorAnalyses(widget.animal.id);
    final analysisCount = analyses.length;

    // Show card if there's at least one analysis
    if (analysisCount == 0) return const SizedBox.shrink();

    final latestAnalysis = analyses.first;
    final insight = latestAnalysis.insight;

    return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                OiselyColors.tertiary.withAlpha(25),
                OiselyColors.accentLavender.withAlpha(20),
              ],
            ),
            borderRadius: BorderRadius.circular(OiselyShapes.cardRadius),
            border: Border.all(color: OiselyColors.tertiary.withAlpha(60)),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) =>
                        BehaviorAnalysisHistoryScreen(animal: widget.animal),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(OiselyShapes.cardRadius),
              child: Padding(
                padding: const EdgeInsets.all(OiselySpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: OiselyColors.tertiary.withAlpha(40),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.history,
                            color: OiselyColors.tertiary,
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Behavior Analysis History',
                                style: GoogleFonts.inter(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: colorScheme.onSurface,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '$analysisCount ${analysisCount == 1 ? 'analysis' : 'analyses'} recorded',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: OiselyColors.tertiary.withAlpha(30),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.chevron_right,
                            color: OiselyColors.tertiary,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Divider(
                      height: 1,
                      color: OiselyColors.tertiary.withAlpha(40),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        // Latest analysis preview
                        _ConfidenceBadge(
                          confidence: insight.analysisConfidence,
                          size: 44,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    '🎭 ',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  Text(
                                    insight.emotionalState,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: colorScheme.onSurface,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Text(
                                _formatDate(latestAnalysis.timestamp),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
        .animate()
        .fadeIn(delay: 350.ms, duration: 400.ms)
        .moveY(begin: 15, end: 0, duration: 400.ms);
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inHours < 1) return '${diff.inMinutes}m ago';
    if (diff.inDays < 1) return '${diff.inHours}h ago';
    if (diff.inDays == 1) return 'Yesterday';
    if (diff.inDays < 7) return '${diff.inDays}d ago';

    return '${date.month}/${date.day}/${date.year}';
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String content,
    required Color accentColor,
    int delay = 0,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(OiselyShapes.cardRadius),
            border: Border.all(color: accentColor.withAlpha(50)),
            boxShadow: [
              BoxShadow(
                color: accentColor.withAlpha(15),
                blurRadius: 15,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(OiselySpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: accentColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(icon, size: 20, color: accentColor),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      title,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  content,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        )
        .animate()
        .fadeIn(
          delay: Duration(milliseconds: delay),
          duration: 400.ms,
        )
        .moveY(begin: 15, end: 0, duration: 400.ms);
  }
}

/// Confidence badge with dynamic coloring
class _ConfidenceBadge extends StatelessWidget {
  final double confidence;
  final double size;

  const _ConfidenceBadge({
    required this.confidence,
    this.size = 56,
  });

  @override
  Widget build(BuildContext context) {
    final color = OiselyColors.getConfidenceColor(confidence);
    final percentage = (confidence * 100).toStringAsFixed(0);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withAlpha(50),
            color.withAlpha(30),
          ],
        ),
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 2),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$percentage%',
              style: GoogleFonts.inter(
                fontSize: size * 0.28,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            if (size >= 50)
              Text(
                'match',
                style: GoogleFonts.inter(
                  fontSize: size * 0.16,
                  color: color.withAlpha(200),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Action button with gradient background
class _ActionButton extends StatefulWidget {
  final IconData? icon;
  final String label;
  final String emoji;
  final Gradient gradient;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double progress;

  const _ActionButton({
    this.icon,
    required this.label,
    required this.emoji,
    required this.gradient,
    this.onPressed,
    this.isLoading = false,
    this.progress = 0,
  });

  @override
  State<_ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<_ActionButton> {
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
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          gradient: widget.gradient,
          borderRadius: BorderRadius.circular(16),
          boxShadow: _isPressed || widget.isLoading
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withAlpha(40),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        transform: Matrix4.identity()..scale(_isPressed ? 0.98 : 1.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.isLoading)
              SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: Colors.white,
                  value: widget.progress > 0 ? widget.progress : null,
                ),
              )
            else if (widget.icon != null)
              Icon(widget.icon, color: Colors.white, size: 22),
            const SizedBox(width: 10),
            Text(
              widget.label,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 8),
            Text(widget.emoji, style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}

/// A chip widget for displaying key information
class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _InfoChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.45,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: color.withAlpha(30),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withAlpha(60)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: color,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
