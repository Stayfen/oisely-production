import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../design_system/core/oisely_colors.dart';
import '../design_system/core/oisely_shapes.dart';
import '../design_system/core/oisely_spacing.dart';

/// Privacy Policy screen with Oisely design language
class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OiselyColors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // App Bar
          SliverAppBar(
            floating: true,
            snap: true,
            pinned: true,
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
              'Privacy Policy',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: OiselyColors.onSurface,
              ),
            ),
            centerTitle: true,
          ),
          // Content
          SliverPadding(
            padding: const EdgeInsets.all(OiselySpacing.lg),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Header
                _buildHeader()
                    .animate()
                    .fadeIn(duration: 400.ms)
                    .moveY(begin: 20, end: 0, duration: 400.ms),
                const SizedBox(height: OiselySpacing.xl),

                // Last Updated
                _buildLastUpdated()
                    .animate()
                    .fadeIn(delay: 100.ms, duration: 300.ms),
                const SizedBox(height: OiselySpacing.xl),

                // Policy Sections
                ..._buildPolicySections(),

                // Footer
                const SizedBox(height: OiselySpacing.xl),
                _buildFooter()
                    .animate()
                    .fadeIn(delay: 600.ms, duration: 400.ms),
                const SizedBox(height: OiselySpacing.xxl),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(OiselySpacing.xl),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            OiselyColors.accentLavender.withAlpha(30),
            OiselyColors.tertiary.withAlpha(20),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(OiselyShapes.cardRadius),
        border: Border.all(color: OiselyColors.accentLavender.withAlpha(50)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: OiselyColors.accentLavender.withAlpha(40),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.privacy_tip_rounded,
              size: 48,
              color: OiselyColors.accentLavender,
            ),
          ),
          const SizedBox(height: OiselySpacing.lg),
          Text(
            'Your Privacy Matters',
            style: GoogleFonts.inter(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: OiselyColors.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'We are committed to protecting your\npersonal information and being transparent',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: OiselyColors.onSurfaceVariant,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLastUpdated() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: OiselySpacing.md,
        vertical: OiselySpacing.sm,
      ),
      decoration: BoxDecoration(
        color: OiselyColors.primary.withAlpha(15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.calendar_today_outlined,
            size: 16,
            color: OiselyColors.primary,
          ),
          const SizedBox(width: 8),
          Text(
            'Last Updated: January 30, 2026',
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: OiselyColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPolicySections() {
    final sections = [
      {
        'title': 'Information We Collect',
        'icon': Icons.folder_outlined,
        'color': OiselyColors.primary,
        'content': '''When you use Oisely, we may collect the following information:

• **Account Information**: Email address, display name, and profile picture when you sign in with Google or Apple.

• **Animal Photos**: Images you capture for animal identification. These are processed by our AI and stored securely.

• **Location Data**: Your approximate location when using the "Find Nearby Pet Services" feature (only with your permission).

• **Usage Data**: App interactions, feature usage patterns, and crash reports to improve our service.''',
      },
      {
        'title': 'How We Use Your Data',
        'icon': Icons.insights_outlined,
        'color': OiselyColors.secondary,
        'content': '''Your data helps us provide and improve Oisely:

• **Animal Identification**: Process photos to identify species and provide detailed information.

• **Personalization**: Remember your identified animals and preferences.

• **Location Services**: Find nearby veterinarians and pet stores when requested.

• **Service Improvement**: Analyze usage patterns to enhance features and fix issues.

• **Communication**: Send important updates about your account or the app (optional marketing emails).''',
      },
      {
        'title': 'Data Protection',
        'icon': Icons.shield_outlined,
        'color': OiselyColors.tertiary,
        'content': '''We implement robust security measures:

• **Encryption**: All data is encrypted in transit using TLS 1.3 and at rest using AES-256.

• **Secure Storage**: Your data is stored on secure cloud servers with strict access controls.

• **No Third-Party Sharing**: We never sell your personal data to advertisers or third parties.

• **Regular Audits**: Our security practices are regularly reviewed and updated.

• **Minimal Data**: We only collect what's necessary to provide our services.''',
      },
      {
        'title': 'Your Rights',
        'icon': Icons.gavel_outlined,
        'color': OiselyColors.accentCoral,
        'content': '''You have full control over your data:

• **Access**: Request a copy of all data we have about you.

• **Correction**: Update or correct any inaccurate information.

• **Deletion**: Request complete deletion of your account and data.

• **Portability**: Export your data in a standard format.

• **Opt-out**: Disable optional features like notifications anytime.

To exercise these rights, contact us at privacy@oisely.com''',
      },
      {
        'title': 'Cookies & Analytics',
        'icon': Icons.analytics_outlined,
        'color': OiselyColors.accentTeal,
        'content': '''We use minimal tracking for app improvement:

• **Analytics**: Anonymous usage statistics to understand how features are used.

• **Crash Reports**: Technical data when errors occur to help fix bugs quickly.

• **No Advertising Tracking**: We do not use advertising cookies or trackers.

• **Performance Monitoring**: Response times and app performance metrics.

You can opt out of analytics in the app settings.''',
      },
      {
        'title': 'Children\'s Privacy',
        'icon': Icons.child_care_outlined,
        'color': OiselyColors.accentLavender,
        'content': '''Protecting young users is important to us:

• Oisely is not intended for children under 13.

• We do not knowingly collect data from children under 13.

• If you believe a child has provided us with personal data, please contact us immediately.

• Parents can request deletion of any data inadvertently collected from children.''',
      },
    ];

    return sections.asMap().entries.map((entry) {
      final index = entry.key;
      final section = entry.value;
      return Padding(
        padding: const EdgeInsets.only(bottom: OiselySpacing.lg),
        child: _PolicySection(
          title: section['title'] as String,
          icon: section['icon'] as IconData,
          color: section['color'] as Color,
          content: section['content'] as String,
        )
            .animate()
            .fadeIn(
              delay: Duration(milliseconds: 200 + (index * 80)),
              duration: 400.ms,
            )
            .moveY(begin: 15, end: 0, duration: 400.ms),
      );
    }).toList();
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(OiselySpacing.lg),
      decoration: BoxDecoration(
        color: OiselyColors.surfaceVariant.withAlpha(80),
        borderRadius: BorderRadius.circular(OiselyShapes.cardRadius),
        border: Border.all(color: OiselyColors.outline.withAlpha(60)),
      ),
      child: Column(
        children: [
          Icon(
            Icons.mail_outline_rounded,
            size: 32,
            color: OiselyColors.primary,
          ),
          const SizedBox(height: OiselySpacing.md),
          Text(
            'Questions about Privacy?',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: OiselyColors.onSurface,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Contact our privacy team at\nprivacy@oisely.com',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: OiselyColors.onSurfaceVariant,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

/// Individual policy section with expandable content
class _PolicySection extends StatefulWidget {
  final String title;
  final IconData icon;
  final Color color;
  final String content;

  const _PolicySection({
    required this.title,
    required this.icon,
    required this.color,
    required this.content,
  });

  @override
  State<_PolicySection> createState() => _PolicySectionState();
}

class _PolicySectionState extends State<_PolicySection> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _isExpanded = !_isExpanded),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(OiselySpacing.md),
        decoration: BoxDecoration(
          color: _isExpanded
              ? widget.color.withAlpha(12)
              : OiselyColors.surfaceVariant.withAlpha(80),
          borderRadius: BorderRadius.circular(OiselyShapes.cardRadius),
          border: Border.all(
            color: _isExpanded
                ? widget.color.withAlpha(60)
                : OiselyColors.outline.withAlpha(60),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: widget.color.withAlpha(30),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(widget.icon, color: widget.color, size: 22),
                ),
                const SizedBox(width: OiselySpacing.md),
                Expanded(
                  child: Text(
                    widget.title,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: OiselyColors.onSurface,
                    ),
                  ),
                ),
                AnimatedRotation(
                  turns: _isExpanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: widget.color.withAlpha(20),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: widget.color,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            AnimatedCrossFade(
              firstChild: const SizedBox.shrink(),
              secondChild: Padding(
                padding: const EdgeInsets.only(top: OiselySpacing.md),
                child: _buildRichContent(widget.content),
              ),
              crossFadeState:
                  _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRichContent(String content) {
    // Simple markdown-like parsing for bold text
    final lines = content.split('\n');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: lines.map((line) {
        if (line.startsWith('•')) {
          // Bullet point
          final text = line.substring(1).trim();
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 8, right: 10),
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: widget.color,
                    shape: BoxShape.circle,
                  ),
                ),
                Expanded(
                  child: _parseTextWithBold(text),
                ),
              ],
            ),
          );
        } else if (line.isEmpty) {
          return const SizedBox(height: 8);
        } else {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _parseTextWithBold(line),
          );
        }
      }).toList(),
    );
  }

  Widget _parseTextWithBold(String text) {
    final regex = RegExp(r'\*\*(.*?)\*\*');
    final spans = <TextSpan>[];
    int lastEnd = 0;

    for (final match in regex.allMatches(text)) {
      if (match.start > lastEnd) {
        spans.add(TextSpan(text: text.substring(lastEnd, match.start)));
      }
      spans.add(TextSpan(
        text: match.group(1),
        style: const TextStyle(fontWeight: FontWeight.w600),
      ));
      lastEnd = match.end;
    }

    if (lastEnd < text.length) {
      spans.add(TextSpan(text: text.substring(lastEnd)));
    }

    return RichText(
      text: TextSpan(
        style: GoogleFonts.inter(
          fontSize: 14,
          color: OiselyColors.onSurfaceVariant,
          height: 1.6,
        ),
        children: spans.isEmpty ? [TextSpan(text: text)] : spans,
      ),
    );
  }
}
