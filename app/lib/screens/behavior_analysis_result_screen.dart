import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oisely_client/oisely_client.dart';
import '../models/animal.dart';

/// Screen for displaying a single behavior analysis result
class BehaviorAnalysisResultScreen extends StatelessWidget {
  final Animal animal;
  final StoredBehaviorAnalysis analysis;

  const BehaviorAnalysisResultScreen({
    super.key,
    required this.animal,
    required this.analysis,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final insight = analysis.insight;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Analysis Details',
          style: GoogleFonts.inter(fontWeight: FontWeight.w600),
        ),
        elevation: 0,
        backgroundColor: colorScheme.surface,
        actions: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _getConfidenceColor(
                  insight.analysisConfidence,
                ).withAlpha(25),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: _getConfidenceColor(
                    insight.analysisConfidence,
                  ).withAlpha(100),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.verified,
                    size: 16,
                    color: _getConfidenceColor(insight.analysisConfidence),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '${(insight.analysisConfidence * 100).toInt()}%',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: _getConfidenceColor(insight.analysisConfidence),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Animal info card
                  _buildAnimalHeader(context),
                  const SizedBox(height: 24),

                  // Analysis timestamp
                  _buildTimestampCard(context),
                  const SizedBox(height: 24),

                  // Temperament
                  _buildSectionTitle(context, 'Temperament'),
                  const SizedBox(height: 12),
                  _buildTemperamentCard(context, insight),
                  const SizedBox(height: 20),

                  // Activity
                  _buildSectionTitle(context, 'Activity Patterns'),
                  const SizedBox(height: 12),
                  _buildActivityCard(context, insight),
                  const SizedBox(height: 20),

                  // Behavior Patterns
                  if (insight.behaviorPatterns.isNotEmpty) ...[
                    _buildSectionTitle(context, 'Behavior Patterns'),
                    const SizedBox(height: 12),
                    _buildBehaviorPatterns(context, insight.behaviorPatterns),
                    const SizedBox(height: 20),
                  ],

                  // Movement
                  _buildSectionTitle(context, 'Movement & Posture'),
                  const SizedBox(height: 12),
                  _buildMovementCard(context, insight),
                  const SizedBox(height: 20),

                  // Vocalization
                  if (insight.vocalizationSummary.isNotEmpty &&
                      insight.vocalizationSummary != 'Unknown') ...[
                    _buildSectionTitle(context, 'Vocalization'),
                    const SizedBox(height: 12),
                    _buildVocalizationCard(context, insight),
                    const SizedBox(height: 20),
                  ],

                  // Key Moments
                  if (insight.keyFrames.isNotEmpty) ...[
                    _buildSectionTitle(context, 'Key Moments'),
                    const SizedBox(height: 12),
                    _buildKeyFramesTimeline(context, insight.keyFrames),
                    const SizedBox(height: 20),
                  ],

                  // Recommendations
                  _buildSectionTitle(context, 'Care Recommendations'),
                  const SizedBox(height: 12),
                  _buildRecommendationsCard(context, insight),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimalHeader(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      color: colorScheme.primaryContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Hero(
              tag: 'animal_image_${animal.id}',
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: animal.localImagePath != null
                      ? DecorationImage(
                          image: FileImage(File(animal.localImagePath!)),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: animal.localImagePath == null
                    ? Icon(Icons.pets, color: colorScheme.onPrimaryContainer)
                    : null,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    animal.displayName,
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Behavior Analysis Record',
                    style: TextStyle(
                      color: colorScheme.onPrimaryContainer.withAlpha(179),
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

  Widget _buildTimestampCard(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerHighest.withAlpha(128),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.access_time, color: colorScheme.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Analysis Date',
                    style: TextStyle(
                      fontSize: 12,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatFullDate(analysis.timestamp),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
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

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildTemperamentCard(
    BuildContext context,
    BehaviorAnalysisInsight insight,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerHighest.withAlpha(128),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow(
              context,
              icon: Icons.emoji_emotions,
              label: 'Emotional State',
              value: insight.emotionalState,
            ),
            const Divider(height: 24),
            _buildInfoRow(
              context,
              icon: Icons.trending_up,
              label: 'Activity Level',
              value: insight.activityLevel,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityCard(
    BuildContext context,
    BehaviorAnalysisInsight insight,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerHighest.withAlpha(128),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              insight.movementSummary,
              style: const TextStyle(fontSize: 16),
            ),
            if (insight.movementPatterns.isNotEmpty) ...[
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: insight.movementPatterns
                    .map(
                      (pattern) => Chip(
                        label: Text(pattern),
                        backgroundColor: colorScheme.primaryContainer,
                        side: BorderSide.none,
                      ),
                    )
                    .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildBehaviorPatterns(BuildContext context, List<String> patterns) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerHighest.withAlpha(128),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: patterns
              .map(
                (pattern) => Chip(
                  label: Text(pattern),
                  avatar: const Icon(Icons.check_circle, size: 18),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget _buildMovementCard(
    BuildContext context,
    BehaviorAnalysisInsight insight,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerHighest.withAlpha(128),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: _buildInfoRow(
          context,
          icon: Icons.accessibility,
          label: 'Posture',
          value: insight.postureSummary,
        ),
      ),
    );
  }

  Widget _buildVocalizationCard(
    BuildContext context,
    BehaviorAnalysisInsight insight,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerHighest.withAlpha(128),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              insight.vocalizationSummary,
              style: const TextStyle(fontSize: 16),
            ),
            if (insight.vocalizationPatterns.isNotEmpty) ...[
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: insight.vocalizationPatterns
                    .map(
                      (pattern) => Chip(
                        label: Text(pattern),
                        avatar: const Icon(Icons.volume_up, size: 18),
                      ),
                    )
                    .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildKeyFramesTimeline(
    BuildContext context,
    List<BehaviorFrameInsight> keyFrames,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerHighest.withAlpha(128),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: keyFrames.map((frame) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 60,
                    padding: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 8,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${frame.timestampSeconds.toStringAsFixed(1)}s',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          frame.action,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        if (frame.bodyLanguage != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            frame.bodyLanguage!,
                            style: TextStyle(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildRecommendationsCard(
    BuildContext context,
    BehaviorAnalysisInsight insight,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final recommendations = _generateCareRecommendations(insight);

    return Card(
      elevation: 0,
      color: Colors.green.withAlpha(25),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.green.withAlpha(100)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.tips_and_updates, color: Colors.green.shade700),
                const SizedBox(width: 8),
                Text(
                  'Recommendations',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...recommendations.map(
              (rec) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: 20,
                      color: Colors.green.shade700,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        rec,
                        style: const TextStyle(height: 1.5),
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

  Widget _buildInfoRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: colorScheme.primary, size: 24),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _getConfidenceColor(double confidence) {
    if (confidence >= 0.8) return Colors.green;
    if (confidence >= 0.5) return Colors.orange;
    return Colors.red;
  }

  String _formatFullDate(DateTime date) {
    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    final hour = date.hour > 12
        ? date.hour - 12
        : (date.hour == 0 ? 12 : date.hour);
    final minute = date.minute.toString().padLeft(2, '0');
    final amPm = date.hour >= 12 ? 'PM' : 'AM';

    return '${months[date.month - 1]} ${date.day}, ${date.year} at $hour:$minute $amPm';
  }

  List<String> _generateCareRecommendations(BehaviorAnalysisInsight insight) {
    final recommendations = <String>[];

    // Based on emotional state
    final emotionalLower = insight.emotionalState.toLowerCase();
    if (emotionalLower.contains('anxious') ||
        emotionalLower.contains('stressed')) {
      recommendations.add(
        'Provide a quiet, safe space where the animal can retreat when feeling overwhelmed.',
      );
    }
    if (emotionalLower.contains('energetic') ||
        emotionalLower.contains('playful')) {
      recommendations.add(
        'Ensure plenty of playtime and mental stimulation activities.',
      );
    }

    // Based on activity level
    final activityLower = insight.activityLevel.toLowerCase();
    if (activityLower.contains('high')) {
      recommendations.add(
        'Schedule regular exercise sessions throughout the day.',
      );
    } else if (activityLower.contains('low')) {
      recommendations.add(
        'Monitor for signs of lethargy and consult a vet if concerned.',
      );
    }

    // General recommendations
    recommendations.add(
      'Maintain a consistent daily routine to help the animal feel secure.',
    );
    recommendations.add('Use positive reinforcement training methods.');

    return recommendations;
  }
}
