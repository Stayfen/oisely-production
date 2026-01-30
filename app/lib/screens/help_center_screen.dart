import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../design_system/core/oisely_colors.dart';
import '../design_system/core/oisely_shapes.dart';
import '../design_system/core/oisely_spacing.dart';

/// Help Center screen with FAQs and support options
class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

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
              'Help Center',
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
                // Header illustration
                _buildHeader()
                    .animate()
                    .fadeIn(duration: 400.ms)
                    .moveY(begin: 20, end: 0, duration: 400.ms),
                const SizedBox(height: OiselySpacing.xl),

                // Contact Support Card
                _buildContactCard(context)
                    .animate()
                    .fadeIn(delay: 100.ms, duration: 400.ms)
                    .moveY(begin: 15, end: 0, duration: 400.ms),
                const SizedBox(height: OiselySpacing.xl),

                // FAQ Section
                _buildSectionHeader('Frequently Asked Questions', '❓')
                    .animate()
                    .fadeIn(delay: 150.ms, duration: 300.ms),
                const SizedBox(height: OiselySpacing.md),
                ..._buildFAQItems(),
                const SizedBox(height: OiselySpacing.xl),

                // Quick Links
                _buildSectionHeader('Quick Links', '🔗')
                    .animate()
                    .fadeIn(delay: 400.ms, duration: 300.ms),
                const SizedBox(height: OiselySpacing.md),
                _buildQuickLinksCard(context)
                    .animate()
                    .fadeIn(delay: 450.ms, duration: 400.ms)
                    .moveY(begin: 15, end: 0, duration: 400.ms),
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
            OiselyColors.secondary.withAlpha(30),
            OiselyColors.tertiary.withAlpha(20),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(OiselyShapes.cardRadius),
        border: Border.all(color: OiselyColors.secondary.withAlpha(40)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: OiselyColors.secondary.withAlpha(40),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.support_agent_rounded,
              size: 48,
              color: OiselyColors.secondary,
            ),
          ),
          const SizedBox(height: OiselySpacing.lg),
          Text(
            'How can we help you?',
            style: GoogleFonts.inter(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: OiselyColors.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Find answers to common questions or\nget in touch with our support team',
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

  Widget _buildContactCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(OiselySpacing.lg),
      decoration: BoxDecoration(
        gradient: OiselyColors.primaryGradient,
        borderRadius: BorderRadius.circular(OiselyShapes.cardRadius),
        boxShadow: OiselyShapes.primaryShadow(OiselyColors.primary),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(40),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.email_outlined,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(width: OiselySpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Contact Support',
                  style: GoogleFonts.inter(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'support@oisely.com',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: Colors.white.withAlpha(200),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => _launchEmail(),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.send_rounded,
                color: OiselyColors.primary,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, String emoji) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 8),
          Text(
            title.toUpperCase(),
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: OiselyColors.primary,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildFAQItems() {
    final faqs = [
      {
        'question': 'How do I identify an animal?',
        'answer':
            'Simply tap the + button on the home screen, take a photo of the animal, and our AI will analyze it to provide detailed information about the species.',
        'icon': Icons.camera_alt_outlined,
        'color': OiselyColors.primary,
      },
      {
        'question': 'Can I save my scanned animals?',
        'answer':
            'Yes! All scanned animals are automatically saved to your collection. You can view them in the "My Pets" section anytime.',
        'icon': Icons.favorite_outline,
        'color': OiselyColors.accentCoral,
      },
      {
        'question': 'How accurate is the AI identification?',
        'answer':
            'Our AI is trained on millions of animal images and achieves over 95% accuracy for common species. For best results, ensure good lighting and a clear view of the animal.',
        'icon': Icons.psychology_outlined,
        'color': OiselyColors.tertiary,
      },
      {
        'question': 'Is my data secure?',
        'answer':
            'Absolutely! We use industry-standard encryption to protect your data. Your photos and personal information are never shared with third parties.',
        'icon': Icons.security_outlined,
        'color': OiselyColors.secondary,
      },
      {
        'question': 'How do I find nearby pet services?',
        'answer':
            'Tap the "Find Nearby Pet Services" card on the home screen. You can filter by vets, pet stores, or both, and adjust the search radius.',
        'icon': Icons.location_on_outlined,
        'color': OiselyColors.accentTeal,
      },
    ];

    return faqs.asMap().entries.map((entry) {
      final index = entry.key;
      final faq = entry.value;
      return Padding(
        padding: const EdgeInsets.only(bottom: OiselySpacing.md),
        child: _FAQItem(
          question: faq['question'] as String,
          answer: faq['answer'] as String,
          icon: faq['icon'] as IconData,
          accentColor: faq['color'] as Color,
        )
            .animate()
            .fadeIn(delay: Duration(milliseconds: 200 + (index * 50)), duration: 400.ms)
            .moveY(begin: 15, end: 0, duration: 400.ms),
      );
    }).toList();
  }

  Widget _buildQuickLinksCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(OiselySpacing.md),
      decoration: BoxDecoration(
        color: OiselyColors.surfaceVariant.withAlpha(80),
        borderRadius: BorderRadius.circular(OiselyShapes.cardRadius),
        border: Border.all(color: OiselyColors.outline.withAlpha(60)),
      ),
      child: Column(
        children: [
          _QuickLinkTile(
            icon: Icons.article_outlined,
            title: 'User Guide',
            subtitle: 'Learn how to use Oisely',
            color: OiselyColors.primary,
            onTap: () => _showComingSoon(context, 'User Guide'),
          ),
          Divider(
            height: 1,
            indent: 56,
            color: OiselyColors.outline.withAlpha(40),
          ),
          _QuickLinkTile(
            icon: Icons.bug_report_outlined,
            title: 'Report a Bug',
            subtitle: 'Help us improve the app',
            color: OiselyColors.error,
            onTap: () => _launchEmail(subject: 'Bug Report'),
          ),
          Divider(
            height: 1,
            indent: 56,
            color: OiselyColors.outline.withAlpha(40),
          ),
          _QuickLinkTile(
            icon: Icons.lightbulb_outline,
            title: 'Feature Request',
            subtitle: 'Suggest new features',
            color: OiselyColors.secondary,
            onTap: () => _launchEmail(subject: 'Feature Request'),
          ),
        ],
      ),
    );
  }

  void _showComingSoon(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature coming soon!'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: OiselyColors.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Future<void> _launchEmail({String subject = 'Support Request'}) async {
    final uri = Uri(
      scheme: 'mailto',
      path: 'support@oisely.com',
      queryParameters: {'subject': 'Oisely - $subject'},
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}

/// Expandable FAQ Item
class _FAQItem extends StatefulWidget {
  final String question;
  final String answer;
  final IconData icon;
  final Color accentColor;

  const _FAQItem({
    required this.question,
    required this.answer,
    required this.icon,
    required this.accentColor,
  });

  @override
  State<_FAQItem> createState() => _FAQItemState();
}

class _FAQItemState extends State<_FAQItem> {
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
              ? widget.accentColor.withAlpha(15)
              : OiselyColors.surfaceVariant.withAlpha(80),
          borderRadius: BorderRadius.circular(OiselyShapes.cardRadius),
          border: Border.all(
            color: _isExpanded
                ? widget.accentColor.withAlpha(60)
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
                    color: widget.accentColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(widget.icon, color: widget.accentColor, size: 20),
                ),
                const SizedBox(width: OiselySpacing.md),
                Expanded(
                  child: Text(
                    widget.question,
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: OiselyColors.onSurface,
                    ),
                  ),
                ),
                AnimatedRotation(
                  turns: _isExpanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 300),
                  child: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: widget.accentColor,
                  ),
                ),
              ],
            ),
            AnimatedCrossFade(
              firstChild: const SizedBox.shrink(),
              secondChild: Padding(
                padding: const EdgeInsets.only(top: OiselySpacing.md),
                child: Text(
                  widget.answer,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: OiselyColors.onSurfaceVariant,
                    height: 1.6,
                  ),
                ),
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
}

/// Quick link tile
class _QuickLinkTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _QuickLinkTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: OiselySpacing.sm,
            vertical: OiselySpacing.md,
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withAlpha(25),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: OiselySpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: OiselyColors.onSurface,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: OiselyColors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: OiselyColors.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
