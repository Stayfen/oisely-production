import 'dart:io';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
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
        body: const Center(child: Text('No information available')),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App bar with hero image
          SliverAppBar(
            expandedHeight: 350,
            pinned: true,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'animal_image_${widget.animal.id}',
                child: widget.animal.localImagePath != null
                    ? Image.file(
                        File(widget.animal.localImagePath!),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      )
                    : Container(
                        color: colorScheme.primaryContainer,
                        child: Icon(
                          Icons.pets,
                          size: 100,
                          color: colorScheme.onPrimaryContainer,
                        ),
                      ),
              ),
            ),
          ),
          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                                fontSize: 32,
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
                                    fontSize: 18,
                                    fontStyle: FontStyle.italic,
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      // Confidence percentage badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: _getConfidenceColor(
                            adoptionInfo.confidence,
                            colorScheme,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${(adoptionInfo.confidence * 100).toStringAsFixed(0)}%',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: _getConfidenceTextColor(
                              adoptionInfo.confidence,
                              colorScheme,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Conditional Action Button
                  _buildActionButton(context),
                  const SizedBox(height: 16),

                  // Behavior Analysis History Card (only for adopted animals with analyses)
                  _buildBehaviorAnalysisHistoryCard(context),
                  const SizedBox(height: 24),

                  // Main info card
                  Card(
                    elevation: 0,
                    color: colorScheme.surfaceContainerHighest.withAlpha(128),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Description section
                          _buildSectionTitle(context, 'About'),
                          const SizedBox(height: 12),
                          Text(
                            adoptionInfo.breedSpecificInfo,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                  height: 1.6,
                                ),
                          ),
                          const SizedBox(height: 24),

                          // Taxonomic/Key Info Chips
                          _buildSectionTitle(context, 'Key Information'),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              _InfoChip(
                                icon: Icons.attach_money,
                                label: adoptionInfo.adoptionCost,
                              ),
                              _InfoChip(
                                icon: Icons.schedule,
                                label: adoptionInfo.dailyTimeCommitment,
                              ),
                              _InfoChip(
                                icon: Icons.favorite_outline,
                                label: adoptionInfo.averageLifespan,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Care Instructions Card
                  _buildInfoCard(
                    context,
                    icon: Icons.healing_outlined,
                    title: 'Care Instructions',
                    content: adoptionInfo.careInstructions,
                  ),
                  const SizedBox(height: 16),

                  // Dietary Requirements Card
                  _buildInfoCard(
                    context,
                    icon: Icons.restaurant_outlined,
                    title: 'Dietary Requirements',
                    content: adoptionInfo.dietaryRequirements,
                  ),
                  const SizedBox(height: 16),

                  // Living Environment Card
                  _buildInfoCard(
                    context,
                    icon: Icons.home_outlined,
                    title: 'Living Environment',
                    content: adoptionInfo.livingEnvironment,
                  ),
                  const SizedBox(height: 16),

                  // Legal Requirements Card (if available and not "Unknown")
                  if (adoptionInfo.legalRequirements != 'Unknown' &&
                      adoptionInfo.legalRequirements.isNotEmpty)
                    _buildInfoCard(
                      context,
                      icon: Icons.gavel_outlined,
                      title: 'Legal Requirements',
                      content: adoptionInfo.legalRequirements,
                    ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
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
    final colorScheme = Theme.of(context).colorScheme;
    final isAdopted = adoptionProvider.isAdopted(widget.animal.id);

    if (isAdopted) {
      // Show action buttons for adopted animals
      return Column(
        children: [
          // Behavior Analysis button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) =>
                        BehaviorAnalysisScreen(animal: widget.animal),
                  ),
                );
              },
              icon: const Icon(Icons.psychology),
              label: const Text('Behavior Analysis'),
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.tertiaryContainer,
                foregroundColor: colorScheme.onTertiaryContainer,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Create Care Plan button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _isGeneratingCarePlan
                  ? null
                  : () => _generateCarePlanAndNavigate(context),
              icon: _isGeneratingCarePlan
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.white.withAlpha(200),
                        ),
                        value: _generationProgress > 0
                            ? _generationProgress
                            : null,
                      ),
                    )
                  : const Icon(Icons.calendar_today),
              label: Text(
                _isGeneratingCarePlan
                    ? 'Generating... ${(_generationProgress * 100).toInt()}%'
                    : 'Create Care Plan',
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                disabledBackgroundColor: Colors.green.withAlpha(150),
              ),
            ),
          ),
        ],
      );
    } else {
      // Show "Adopt" button for non-adopted animals
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () async {
            await adoptionProvider.adoptAnimal(widget.animal.id);
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${widget.animal.species} has been adopted!'),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.green,
                ),
              );
            }
          },
          icon: const Icon(Icons.favorite_outline),
          label: const Text('Adopt'),
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
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

    return Card(
      elevation: 0,
      color: colorScheme.tertiaryContainer.withAlpha(100),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: colorScheme.tertiary.withAlpha(100),
        ),
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) =>
                  BehaviorAnalysisHistoryScreen(animal: widget.animal),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.history,
                    color: colorScheme.onTertiaryContainer,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Behavior Analysis History',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: colorScheme.onTertiaryContainer,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '$analysisCount ${analysisCount == 1 ? 'analysis' : 'analyses'} recorded',
                          style: TextStyle(
                            fontSize: 13,
                            color: colorScheme.onTertiaryContainer.withAlpha(
                              179,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: colorScheme.onTertiaryContainer,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Divider(height: 1),
              const SizedBox(height: 12),
              Row(
                children: [
                  // Latest analysis preview
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: _getConfidenceColor(
                        insight.analysisConfidence,
                        colorScheme,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${(insight.analysisConfidence * 100).toInt()}%',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: _getConfidenceTextColor(
                            insight.analysisConfidence,
                            colorScheme,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Latest: ${insight.emotionalState}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: colorScheme.onTertiaryContainer,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _formatDate(latestAnalysis.timestamp),
                          style: TextStyle(
                            fontSize: 12,
                            color: colorScheme.onTertiaryContainer.withAlpha(
                              179,
                            ),
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
    );
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

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String content,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      color: colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: colorScheme.outlineVariant.withAlpha(128),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: colorScheme.primary,
                ),
                const SizedBox(width: 8),
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
            const SizedBox(height: 8),
            Text(
              content,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getConfidenceColor(double confidence, ColorScheme colorScheme) {
    if (confidence >= 0.8) {
      return Colors.green.shade100;
    } else if (confidence >= 0.5) {
      return Colors.orange.shade100;
    } else {
      return Colors.red.shade100;
    }
  }

  Color _getConfidenceTextColor(double confidence, ColorScheme colorScheme) {
    if (confidence >= 0.8) {
      return Colors.green.shade800;
    } else if (confidence >= 0.5) {
      return Colors.orange.shade800;
    } else {
      return Colors.red.shade800;
    }
  }
}

/// A chip widget for displaying key information
class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Chip(
      avatar: Icon(
        icon,
        size: 18,
        color: colorScheme.onSecondaryContainer,
      ),
      label: Text(
        label,
        style: TextStyle(
          fontSize: 13,
          color: colorScheme.onSecondaryContainer,
        ),
      ),
      backgroundColor: colorScheme.secondaryContainer,
      side: BorderSide.none,
      padding: const EdgeInsets.symmetric(horizontal: 4),
    );
  }
}
