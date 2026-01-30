import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oisely_client/oisely_client.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../models/animal.dart';
import '../providers/adoption_provider.dart';
import '../widgets/error_dialog.dart';
import '../widgets/loading_overlay.dart';

/// Screen for performing and displaying behavior analysis
class BehaviorAnalysisScreen extends StatefulWidget {
  final Animal animal;

  const BehaviorAnalysisScreen({
    super.key,
    required this.animal,
  });

  @override
  State<BehaviorAnalysisScreen> createState() => _BehaviorAnalysisScreenState();
}

class _BehaviorAnalysisScreenState extends State<BehaviorAnalysisScreen> {
  bool _isAnalyzing = false;
  bool _isPickingVideo = false;
  File? _selectedVideo;
  BehaviorAnalysisInsight? _analysisResult;
  String? _errorMessage;
  DateTime? _lastAnalysisTime;

  @override
  void initState() {
    super.initState();
    _loadStoredAnalysis();
  }

  void _loadStoredAnalysis() {
    final adoptionProvider = context.read<AdoptionProvider>();
    final storedAnalysis = adoptionProvider.getLatestBehaviorAnalysis(
      widget.animal.id,
    );
    if (storedAnalysis != null) {
      setState(() {
        _analysisResult = storedAnalysis.insight;
        _lastAnalysisTime = storedAnalysis.timestamp;
      });
    }
  }

  Future<void> _pickVideo(ImageSource source) async {
    setState(() {
      _isPickingVideo = true;
      _errorMessage = null;
    });

    try {
      developer.log('Picking video from $source...', name: 'BehaviorAnalysis');
      final picker = ImagePicker();
      final pickedFile = await picker.pickVideo(
        source: source,
        maxDuration: const Duration(seconds: 18),
      );

      if (pickedFile != null) {
        developer.log(
          'Video picked: ${pickedFile.path}',
          name: 'BehaviorAnalysis',
        );
        final file = File(pickedFile.path);
        final fileSize = await file.length();
        developer.log(
          'Video file size: $fileSize bytes',
          name: 'BehaviorAnalysis',
        );

        // Check file size (5MB max)
        if (fileSize > 5 * 1024 * 1024) {
          setState(() {
            _errorMessage =
                'Video size exceeds 5MB limit. Please select a shorter video.';
            _isPickingVideo = false;
          });
          return;
        }

        // Check if file exists and is readable
        if (!await file.exists()) {
          setState(() {
            _errorMessage = 'Selected video file not found. Please try again.';
            _isPickingVideo = false;
          });
          return;
        }

        setState(() {
          _selectedVideo = file;
          _isPickingVideo = false;
        });

        // Automatically start analysis after picking
        await _performAnalysis();
      } else {
        developer.log('No video selected', name: 'BehaviorAnalysis');
        setState(() {
          _isPickingVideo = false;
        });
      }
    } catch (e, stackTrace) {
      developer.log(
        'Failed to pick video: $e',
        name: 'BehaviorAnalysis',
        error: e,
        stackTrace: stackTrace,
      );
      setState(() {
        _errorMessage = 'Failed to pick video: $e';
        _isPickingVideo = false;
      });
    }
  }

  void _showVideoPickerOptions() {
    final colorScheme = Theme.of(context).colorScheme;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: colorScheme.outlineVariant,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Record or Select Video',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Choose a video of ${widget.animal.species} behaving naturally (max 18 seconds)',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: colorScheme.onSurfaceVariant),
                ),
                const SizedBox(height: 24),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.videocam, color: colorScheme.primary),
                  ),
                  title: const Text('Record Video'),
                  subtitle: const Text('Capture new behavior footage'),
                  onTap: () {
                    Navigator.pop(context);
                    _pickVideo(ImageSource.camera);
                  },
                ),
                const SizedBox(height: 12),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.photo_library,
                      color: colorScheme.secondary,
                    ),
                  ),
                  title: const Text('Choose from Gallery'),
                  subtitle: const Text('Select existing video'),
                  onTap: () {
                    Navigator.pop(context);
                    _pickVideo(ImageSource.gallery);
                  },
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _performAnalysis() async {
    if (_selectedVideo == null) {
      setState(() {
        _errorMessage = 'Please select a video first';
      });
      return;
    }

    setState(() {
      _isAnalyzing = true;
      _errorMessage = null;
    });

    try {
      // Read video file and convert to base64
      developer.log('Reading video file...', name: 'BehaviorAnalysis');
      final videoBytes = await _selectedVideo!.readAsBytes();
      developer.log(
        'Video size: ${videoBytes.length} bytes',
        name: 'BehaviorAnalysis',
      );

      if (videoBytes.isEmpty) {
        throw Exception('Selected video file is empty');
      }

      final videoBase64 = base64Encode(videoBytes);
      developer.log(
        'Base64 encoded length: ${videoBase64.length}',
        name: 'BehaviorAnalysis',
      );

      developer.log(
        'Calling behavior analysis endpoint...',
        name: 'BehaviorAnalysis',
      );
      final result = await client.behaviorAnalysis
          .analyzeBehavior(videoBase64)
          .timeout(
            const Duration(seconds: 60),
            onTimeout: () {
              throw Exception(
                'Analysis timed out. The server may be busy. Please try again.',
              );
            },
          );

      developer.log(
        'Analysis completed successfully',
        name: 'BehaviorAnalysis',
      );
      developer.log('Result: ${result.toString()}', name: 'BehaviorAnalysis');

      final adoptionProvider = context.read<AdoptionProvider>();
      await adoptionProvider.saveBehaviorAnalysis(
        widget.animal.id,
        result,
      );
      developer.log('Result saved to provider', name: 'BehaviorAnalysis');

      if (mounted) {
        setState(() {
          _analysisResult = result;
          _lastAnalysisTime = DateTime.now();
          _isAnalyzing = false;
          _selectedVideo =
              null; // Clear selected video after successful analysis
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Behavior analysis completed successfully!'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.green,
          ),
        );
      }
    } on Exception catch (e, stackTrace) {
      developer.log(
        'Analysis failed: $e',
        name: 'BehaviorAnalysis',
        error: e,
        stackTrace: stackTrace,
      );
      if (mounted) {
        setState(() {
          // Provide more user-friendly error messages
          if (e.toString().contains('Video data is empty')) {
            _errorMessage =
                'The video file appears to be empty. Please select a different video.';
          } else if (e.toString().contains('timed out')) {
            _errorMessage =
                'The analysis took too long. Please try again with a shorter video.';
          } else if (e.toString().contains('unauthorized') ||
              e.toString().contains('401')) {
            _errorMessage = 'Session expired. Please log in again.';
          } else {
            _errorMessage =
                'Analysis failed: ${e.toString().replaceAll('Exception: ', '')}';
          }
          _isAnalyzing = false;
        });
      }
    }
  }

  void _showErrorDialog() {
    showErrorModal(
      context: context,
      type: ErrorType.unknown,
      customMessage: _errorMessage,
      onRetry: _selectedVideo != null ? _performAnalysis : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Behavior Analysis',
          style: GoogleFonts.inter(fontWeight: FontWeight.w600),
        ),
        elevation: 0,
        backgroundColor: colorScheme.surface,
      ),
      body: LoadingOverlayWrapper(
        isLoading: _isAnalyzing || _isPickingVideo,
        message: _isPickingVideo
            ? 'Selecting Video...'
            : 'Analyzing Behavior\nThis may take a moment...',
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Animal header
                    _buildAnimalHeader(context),
                    const SizedBox(height: 24),

                    // Analysis button or results
                    if (_analysisResult == null)
                      _buildVideoSelectionView(context)
                    else
                      _buildResultsView(context),
                  ],
                ),
              ),
            ),
          ],
        ),
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
              tag: 'animal_image_${widget.animal.id}',
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: widget.animal.localImagePath != null
                      ? DecorationImage(
                          image: FileImage(File(widget.animal.localImagePath!)),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: widget.animal.localImagePath == null
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
                    widget.animal.displayName,
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Adopted • Behavior Analysis',
                    style: TextStyle(
                      color: colorScheme.onPrimaryContainer.withAlpha(179),
                    ),
                  ),
                  if (_lastAnalysisTime != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      'Last analyzed: ${_formatDate(_lastAnalysisTime!)}',
                      style: TextStyle(
                        fontSize: 12,
                        color: colorScheme.onPrimaryContainer.withAlpha(128),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoSelectionView(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.psychology,
              size: 60,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Analyze Behavior',
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Record or upload a video of ${widget.animal.species}\'s behavior to get detailed insights about temperament, activity patterns, and care recommendations.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: colorScheme.onSurfaceVariant,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          // Video requirements
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest.withAlpha(128),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _buildRequirementRow(Icons.timer, 'Max 18 seconds'),
                const SizedBox(height: 8),
                _buildRequirementRow(Icons.data_usage, 'Max 5MB file size'),
                const SizedBox(height: 8),
                _buildRequirementRow(Icons.videocam, 'MP4 format preferred'),
              ],
            ),
          ),
          const SizedBox(height: 32),
          if (_errorMessage != null) ...[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colorScheme.errorContainer,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: colorScheme.error.withAlpha(100)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.error_outline, color: colorScheme.error),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Analysis failed',
                          style: TextStyle(
                            color: colorScheme.onErrorContainer,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _errorMessage = null;
                          });
                        },
                        icon: Icon(
                          Icons.close,
                          color: colorScheme.error,
                          size: 20,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _errorMessage!,
                    style: TextStyle(color: colorScheme.onErrorContainer),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          setState(() {
                            _errorMessage = null;
                            _selectedVideo = null;
                          });
                        },
                        icon: const Icon(Icons.clear_all, size: 18),
                        label: const Text('Clear & Start Over'),
                        style: TextButton.styleFrom(
                          foregroundColor: colorScheme.onErrorContainer,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                        ),
                      ),
                      if (_selectedVideo != null) ...[
                        const SizedBox(width: 8),
                        TextButton.icon(
                          onPressed: _performAnalysis,
                          icon: const Icon(Icons.refresh, size: 18),
                          label: const Text('Retry'),
                          style: TextButton.styleFrom(
                            foregroundColor: colorScheme.onErrorContainer,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
          if (_selectedVideo != null) ...[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.withAlpha(25),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green.withAlpha(100)),
              ),
              child: Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.green.shade700),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Video selected',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade700,
                          ),
                        ),
                        Text(
                          _selectedVideo!.path.split('/').last,
                          style: TextStyle(
                            fontSize: 12,
                            color: colorScheme.onSurfaceVariant,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _selectedVideo = null;
                      });
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: _showVideoPickerOptions,
              icon: Icon(_selectedVideo != null ? Icons.refresh : Icons.add),
              label: Text(
                _selectedVideo != null ? 'Change Video' : 'Select Video',
              ),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
          if (_selectedVideo != null) ...[
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _performAnalysis,
                icon: const Icon(Icons.play_arrow),
                label: const Text('Start Analysis'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ],
          if (_errorMessage != null && _selectedVideo != null) ...[
            const SizedBox(height: 12),
            TextButton(
              onPressed: _showErrorDialog,
              child: const Text('View Error Details'),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildRequirementRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20),
        const SizedBox(width: 12),
        Text(text),
      ],
    );
  }

  Widget _buildResultsView(BuildContext context) {
    final result = _analysisResult!;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Re-analyze button
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _showVideoPickerOptions,
                icon: const Icon(Icons.refresh),
                label: const Text('Analyze New Video'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Confidence score
        _buildConfidenceCard(context, result.analysisConfidence),
        const SizedBox(height: 20),

        // Temperament & Emotional State
        _buildSectionTitle(context, 'Temperament'),
        const SizedBox(height: 12),
        _buildTemperamentCard(context, result),
        const SizedBox(height: 20),

        // Activity Level
        _buildSectionTitle(context, 'Activity Patterns'),
        const SizedBox(height: 12),
        _buildActivityCard(context, result),
        const SizedBox(height: 20),

        // Behavior Patterns
        if (result.behaviorPatterns.isNotEmpty) ...[
          _buildSectionTitle(context, 'Behavior Patterns'),
          const SizedBox(height: 12),
          _buildBehaviorPatternsCard(context, result.behaviorPatterns),
          const SizedBox(height: 20),
        ],

        // Social Compatibility
        _buildSectionTitle(context, 'Social Compatibility'),
        const SizedBox(height: 12),
        _buildSocialCompatibilityCard(context, result),
        const SizedBox(height: 20),

        // Movement Summary
        _buildSectionTitle(context, 'Movement & Posture'),
        const SizedBox(height: 12),
        _buildMovementCard(context, result),
        const SizedBox(height: 20),

        // Vocalization
        if (result.vocalizationSummary.isNotEmpty &&
            result.vocalizationSummary != 'Unknown') ...[
          _buildSectionTitle(context, 'Vocalization'),
          const SizedBox(height: 12),
          _buildVocalizationCard(context, result),
          const SizedBox(height: 20),
        ],

        // Key Frames Timeline
        if (result.keyFrames.isNotEmpty) ...[
          _buildSectionTitle(context, 'Key Moments'),
          const SizedBox(height: 12),
          _buildKeyFramesTimeline(context, result.keyFrames),
          const SizedBox(height: 20),
        ],

        // Care Recommendations
        _buildSectionTitle(context, 'Care Recommendations'),
        const SizedBox(height: 12),
        _buildCareRecommendationsCard(context),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildConfidenceCard(BuildContext context, double confidence) {
    final colorScheme = Theme.of(context).colorScheme;
    final percentage = (confidence * 100).toInt();

    Color getColor() {
      if (confidence >= 0.8) return Colors.green;
      if (confidence >= 0.5) return Colors.orange;
      return Colors.red;
    }

    return Card(
      elevation: 0,
      color: getColor().withAlpha(25),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: getColor().withAlpha(100)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.verified, color: getColor()),
                const SizedBox(width: 8),
                Text(
                  'Analysis Confidence',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(
                    value: confidence,
                    strokeWidth: 10,
                    backgroundColor: colorScheme.surfaceContainerHighest,
                    valueColor: AlwaysStoppedAnimation<Color>(getColor()),
                  ),
                ),
                Text(
                  '$percentage%',
                  style: GoogleFonts.inter(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: getColor(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTemperamentCard(
    BuildContext context,
    BehaviorAnalysisInsight result,
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
              value: result.emotionalState,
            ),
            const Divider(height: 24),
            _buildInfoRow(
              context,
              icon: Icons.trending_up,
              label: 'Activity Level',
              value: result.activityLevel,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityCard(
    BuildContext context,
    BehaviorAnalysisInsight result,
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
              'Movement Summary',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              result.movementSummary,
              style: const TextStyle(fontSize: 16),
            ),
            if (result.movementPatterns.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                'Movement Patterns',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: result.movementPatterns
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

  Widget _buildBehaviorPatternsCard(
    BuildContext context,
    List<String> patterns,
  ) {
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
                (pattern) => ActionChip(
                  label: Text(pattern),
                  onPressed: () {},
                  avatar: const Icon(Icons.check_circle, size: 18),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget _buildSocialCompatibilityCard(
    BuildContext context,
    BehaviorAnalysisInsight result,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    // Parse emotional state for compatibility score
    final compatibilityScore = _calculateCompatibilityScore(result);

    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerHighest.withAlpha(128),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Social Compatibility Score',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: compatibilityScore,
                        backgroundColor: colorScheme.surfaceContainerHighest,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          compatibilityScore > 0.7
                              ? Colors.green
                              : compatibilityScore > 0.4
                              ? Colors.orange
                              : Colors.red,
                        ),
                        minHeight: 8,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  '${(compatibilityScore * 100).toInt()}%',
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              _getCompatibilityDescription(result),
              style: TextStyle(
                color: colorScheme.onSurfaceVariant,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMovementCard(
    BuildContext context,
    BehaviorAnalysisInsight result,
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
              icon: Icons.accessibility,
              label: 'Posture',
              value: result.postureSummary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVocalizationCard(
    BuildContext context,
    BehaviorAnalysisInsight result,
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
              result.vocalizationSummary,
              style: const TextStyle(fontSize: 16),
            ),
            if (result.vocalizationPatterns.isNotEmpty) ...[
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: result.vocalizationPatterns
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

  Widget _buildCareRecommendationsCard(BuildContext context) {
    final recommendations = _generateCareRecommendations();

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

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  double _calculateCompatibilityScore(BehaviorAnalysisInsight result) {
    // Simple algorithm based on emotional state and activity level
    var score = 0.5;

    final positiveStates = ['calm', 'relaxed', 'friendly', 'playful'];
    final negativeStates = ['aggressive', 'anxious', 'stressed', 'fearful'];

    final emotionalLower = result.emotionalState.toLowerCase();
    if (positiveStates.any((s) => emotionalLower.contains(s))) {
      score += 0.3;
    } else if (negativeStates.any((s) => emotionalLower.contains(s))) {
      score -= 0.2;
    }

    if (result.activityLevel.toLowerCase().contains('moderate')) {
      score += 0.1;
    }

    return score.clamp(0.0, 1.0);
  }

  String _getCompatibilityDescription(BehaviorAnalysisInsight result) {
    final score = _calculateCompatibilityScore(result);
    if (score > 0.8) {
      return 'This animal shows excellent social compatibility. They are likely to adapt well to new environments and interact positively with humans and other animals.';
    } else if (score > 0.5) {
      return 'This animal shows moderate social compatibility. With proper care and gradual socialization, they should adapt well to their new home.';
    } else {
      return 'This animal may need extra patience and care. Consider working with a professional trainer or behaviorist to help them adjust.';
    }
  }

  List<String> _generateCareRecommendations() {
    final result = _analysisResult;
    if (result == null) return [];

    final recommendations = <String>[];

    // Based on emotional state
    final emotionalLower = result.emotionalState.toLowerCase();
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
    final activityLower = result.activityLevel.toLowerCase();
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

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inHours < 1) return '${diff.inMinutes}m ago';
    if (diff.inDays < 1) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';

    return '${date.month}/${date.day}/${date.year}';
  }
}
