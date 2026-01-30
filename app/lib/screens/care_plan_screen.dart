import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:table_calendar/table_calendar.dart';
import '../design_system/core/oisely_colors.dart';
import '../design_system/core/oisely_spacing.dart';
import '../models/animal.dart';
import '../providers/care_plan_provider.dart';
import '../widgets/loading_overlay.dart';

/// Screen for displaying and managing an animal's care plan
class CarePlanScreen extends StatelessWidget {
  final Animal animal;

  const CarePlanScreen({
    super.key,
    required this.animal,
  });

  @override
  Widget build(BuildContext context) {
    // Generate a hash-based ID from the animal's string ID
    final animalIdInt = animal.id.hashCode.abs();

    return ChangeNotifierProvider(
      create: (_) => CarePlanProvider(
        animalId: animal.id,
        animalIdentificationRecordId: animalIdInt,
      ),
      child: _CarePlanScreenContent(animal: animal),
    );
  }
}

class _CarePlanScreenContent extends StatefulWidget {
  final Animal animal;

  const _CarePlanScreenContent({required this.animal});

  @override
  State<_CarePlanScreenContent> createState() => _CarePlanScreenContentState();
}

class _CarePlanScreenContentState extends State<_CarePlanScreenContent>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _tabController = TabController(length: 2, vsync: this);

    // Check if we need to generate a care plan
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<CarePlanProvider>();
      if (!provider.hasCarePlan &&
          provider.generationStatus != CarePlanGenerationStatus.loading) {
        provider.generateCarePlan();
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final provider = context.watch<CarePlanProvider>();
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 360;
    final isTablet = size.width >= 600;

    return Scaffold(
      backgroundColor: OiselyColors.background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                // Header Section - Fixed height, non-scrollable
                _buildHeader(context, isSmallScreen: isSmallScreen),

                // Progress indicator for generation
                if (provider.isLoading) _buildProgressIndicator(context),

                // Error banner
                if (provider.isError && provider.error != null)
                  _buildErrorBanner(context),

                // Tab bar
                Container(
                  decoration: BoxDecoration(
                    color: OiselyColors.background,
                    border: Border(
                      bottom: BorderSide(
                        color: colorScheme.outlineVariant.withAlpha(100),
                      ),
                    ),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    labelColor: colorScheme.primary,
                    unselectedLabelColor: colorScheme.onSurfaceVariant,
                    indicatorColor: colorScheme.primary,
                    indicatorWeight: 3,
                    labelStyle: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: isSmallScreen ? 12 : 14,
                    ),
                    unselectedLabelStyle: GoogleFonts.inter(
                      fontWeight: FontWeight.w500,
                      fontSize: isSmallScreen ? 12 : 14,
                    ),
                    tabs: [
                      Tab(
                        height: isSmallScreen ? 40 : 48,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.check_circle_outline,
                              size: isSmallScreen ? 18 : 20,
                            ),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                isSmallScreen
                                    ? 'Active'
                                    : 'Active (${provider.activeTodos.length})',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Tab(
                        height: isSmallScreen ? 40 : 48,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.archive_outlined,
                              size: isSmallScreen ? 18 : 20,
                            ),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                isSmallScreen
                                    ? 'Done'
                                    : 'Completed (${provider.completedTodos.length})',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Scrollable content area
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      // Active tasks tab with calendar
                      _buildActiveTasksTab(
                        context,
                        constraints: constraints,
                        isTablet: isTablet,
                        isSmallScreen: isSmallScreen,
                      ),
                      // Completed tasks tab
                      _buildCompletedTasksTab(
                        context,
                        constraints: constraints,
                        isSmallScreen: isSmallScreen,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  Widget _buildHeader(BuildContext context, {required bool isSmallScreen}) {
    final colorScheme = Theme.of(context).colorScheme;
    final adoptionInfo = widget.animal.adoptionInfo;

    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 12 : OiselySpacing.md),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            OiselyColors.primary.withAlpha(20),
            OiselyColors.background,
          ],
        ),
      ),
      child: Row(
        children: [
          // Back button
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          const SizedBox(width: 8),

          // Animal image
          Hero(
            tag: 'animal_image_${widget.animal.id}',
            child: Container(
              width: isSmallScreen ? 44 : 56,
              height: isSmallScreen ? 44 : 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: widget.animal.localImagePath != null
                    ? DecorationImage(
                        image: FileImage(File(widget.animal.localImagePath!)),
                        fit: BoxFit.cover,
                      )
                    : null,
                color: colorScheme.primaryContainer,
              ),
              child: widget.animal.localImagePath == null
                  ? Icon(
                      Icons.pets,
                      color: colorScheme.primary,
                      size: isSmallScreen ? 24 : 28,
                    )
                  : null,
            ),
          ),
          const SizedBox(width: 12),

          // Animal info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.animal.displayName,
                  style: GoogleFonts.inter(
                    fontSize: isSmallScreen ? 16 : 18,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  adoptionInfo?.species ?? 'Unknown Species',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 12 : 14,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final provider = context.watch<CarePlanProvider>();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Generating AI care plan...',
                  style: TextStyle(
                    fontSize: 13,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              Text(
                '${(provider.generationProgress * 100).toInt()}%',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: provider.generationProgress,
              minHeight: 4,
              backgroundColor: colorScheme.surfaceContainerHighest,
              valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorBanner(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final provider = context.read<CarePlanProvider>();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.error.withAlpha(100)),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: colorScheme.error, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              provider.error ?? 'An error occurred',
              style: TextStyle(
                fontSize: 13,
                color: colorScheme.onErrorContainer,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          TextButton(
            onPressed: () => provider.retry(),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveTasksTab(
    BuildContext context, {
    required BoxConstraints constraints,
    required bool isTablet,
    required bool isSmallScreen,
  }) {
    final provider = context.watch<CarePlanProvider>();

    if (provider.isLoading && !provider.hasCarePlan) {
      return _buildShimmerLoading(context);
    }

    if (provider.isError && !provider.hasCarePlan) {
      return _buildEmptyState(
        context,
        isActive: true,
        isError: true,
      );
    }

    // Tablet layout: side-by-side calendar and list
    if (isTablet) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Calendar on the left
          SizedBox(
            width: constraints.maxWidth * 0.45,
            child: _buildCalendarSection(context, isSmallScreen: isSmallScreen),
          ),
          // Tasks list on the right
          Expanded(
            child: _buildTodosList(
              context,
              todos: provider.getTodosForDate(provider.selectedDate),
              isActive: true,
              isSmallScreen: isSmallScreen,
            ),
          ),
        ],
      );
    }

    // Mobile layout: stacked calendar and list
    return CustomScrollView(
      slivers: [
        // Calendar section
        SliverToBoxAdapter(
          child: _buildCalendarSection(context, isSmallScreen: isSmallScreen),
        ),
        // Tasks for selected date
        SliverFillRemaining(
          hasScrollBody: true,
          child: _buildTodosList(
            context,
            todos: provider.getTodosForDate(provider.selectedDate),
            isActive: true,
            isSmallScreen: isSmallScreen,
          ),
        ),
      ],
    );
  }

  Widget _buildCompletedTasksTab(
    BuildContext context, {
    required BoxConstraints constraints,
    required bool isSmallScreen,
  }) {
    final provider = context.watch<CarePlanProvider>();

    return _buildTodosList(
      context,
      todos: provider.completedTodos,
      isActive: false,
      isSmallScreen: isSmallScreen,
    );
  }

  Widget _buildCalendarSection(
    BuildContext context, {
    required bool isSmallScreen,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final provider = context.watch<CarePlanProvider>();

    return Card(
      elevation: 0,
      margin: EdgeInsets.all(isSmallScreen ? 8 : 12),
      color: colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: colorScheme.outlineVariant.withAlpha(128),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(isSmallScreen ? 8 : 12),
        child: TableCalendar(
          firstDay: DateTime.now().subtract(const Duration(days: 30)),
          lastDay: DateTime.now().add(const Duration(days: 365)),
          focusedDay: provider.focusedDate,
          selectedDayPredicate: (day) {
            return isSameDay(provider.selectedDate, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            provider.setSelectedDate(selectedDay);
            provider.setFocusedDate(focusedDay);
          },
          onPageChanged: (focusedDay) {
            provider.setFocusedDate(focusedDay);
          },
          calendarFormat: isSmallScreen
              ? CalendarFormat.twoWeeks
              : CalendarFormat.month,
          availableCalendarFormats: const {
            CalendarFormat.month: 'Month',
            CalendarFormat.twoWeeks: '2 Weeks',
            CalendarFormat.week: 'Week',
          },
          startingDayOfWeek: StartingDayOfWeek.monday,
          headerStyle: HeaderStyle(
            titleCentered: true,
            formatButtonVisible: !isSmallScreen,
            formatButtonShowsNext: false,
            titleTextStyle: GoogleFonts.inter(
              fontSize: isSmallScreen ? 14 : 16,
              fontWeight: FontWeight.w600,
            ),
            formatButtonTextStyle: TextStyle(
              fontSize: isSmallScreen ? 12 : 13,
              color: colorScheme.primary,
            ),
            formatButtonDecoration: BoxDecoration(
              border: Border.all(color: colorScheme.primary),
              borderRadius: BorderRadius.circular(12),
            ),
            leftChevronIcon: Icon(
              Icons.chevron_left,
              color: colorScheme.primary,
              size: isSmallScreen ? 24 : 28,
            ),
            rightChevronIcon: Icon(
              Icons.chevron_right,
              color: colorScheme.primary,
              size: isSmallScreen ? 24 : 28,
            ),
            headerPadding: EdgeInsets.symmetric(
              vertical: isSmallScreen ? 4 : 8,
            ),
          ),
          daysOfWeekHeight: isSmallScreen ? 28 : 32,
          rowHeight: isSmallScreen ? 36 : 44,
          calendarStyle: CalendarStyle(
            outsideDaysVisible: false,
            cellPadding: EdgeInsets.zero,
            cellMargin: const EdgeInsets.all(2),
            todayDecoration: BoxDecoration(
              color: colorScheme.primary.withAlpha(100),
              shape: BoxShape.circle,
            ),
            todayTextStyle: TextStyle(
              color: colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
              fontSize: isSmallScreen ? 12 : 14,
            ),
            selectedDecoration: BoxDecoration(
              color: colorScheme.primary,
              shape: BoxShape.circle,
            ),
            selectedTextStyle: TextStyle(
              color: colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
              fontSize: isSmallScreen ? 12 : 14,
            ),
            defaultTextStyle: TextStyle(
              fontSize: isSmallScreen ? 12 : 14,
            ),
            weekendTextStyle: TextStyle(
              fontSize: isSmallScreen ? 12 : 14,
              color: colorScheme.onSurfaceVariant,
            ),
            disabledTextStyle: TextStyle(
              fontSize: isSmallScreen ? 12 : 14,
              color: colorScheme.onSurfaceVariant.withAlpha(100),
            ),
            markerDecoration: BoxDecoration(
              color: colorScheme.primary,
              shape: BoxShape.circle,
            ),
            markersMaxCount: 1,
            markerSize: isSmallScreen ? 4 : 6,
            markersOffset: const PositionedOffset(bottom: 2),
          ),
          calendarBuilders: CalendarBuilders(
            markerBuilder: (context, date, events) {
              final hasTodos = provider.getTodosForDate(date).isNotEmpty;
              if (!hasTodos) return null;

              return Positioned(
                bottom: isSmallScreen ? 1 : 2,
                child: Container(
                  width: isSmallScreen ? 4 : 6,
                  height: isSmallScreen ? 4 : 6,
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              );
            },
            dowBuilder: (context, day) {
              final text = DateFormat.E().format(day)[0];
              return Center(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: isSmallScreen ? 11 : 12,
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTodosList(
    BuildContext context, {
    required List<dynamic> todos,
    required bool isActive,
    required bool isSmallScreen,
  }) {
    final provider = context.watch<CarePlanProvider>();

    if (todos.isEmpty) {
      return _buildEmptyState(
        context,
        isActive: isActive,
        isError: false,
        isSmallScreen: isSmallScreen,
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(isSmallScreen ? 8 : 12),
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return _buildTodoCard(
          context,
          todo: todo,
          isActive: isActive,
          isSmallScreen: isSmallScreen,
        );
      },
    );
  }

  Widget _buildTodoCard(
    BuildContext context, {
    required CarePlanTodo todo,
    required bool isActive,
    required bool isSmallScreen,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Dismissible(
        key: Key('todo_${todo.id}'),
        direction: isActive
            ? DismissDirection.endToStart
            : DismissDirection.none,
        background: Container(
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          child: const Icon(
            Icons.check_circle,
            color: Colors.white,
            size: 28,
          ),
        ),
        onDismissed: (_) {
          context.read<CarePlanProvider>().completeTodo(todo.id);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('"${todo.title}" marked as complete'),
              behavior: SnackBarBehavior.floating,
              action: SnackBarAction(
                label: 'Undo',
                onPressed: () {
                  context.read<CarePlanProvider>().toggleTodoCompletion(
                    todo.id,
                  );
                },
              ),
            ),
          );
        },
        child: Card(
          elevation: 0,
          color: _getPriorityColor(todo.priority, colorScheme),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: colorScheme.outlineVariant.withAlpha(100),
            ),
          ),
          child: InkWell(
            onTap: () => _showTodoDetails(context, todo, isSmallScreen),
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: EdgeInsets.all(isSmallScreen ? 10 : 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Checkbox
                  Transform.scale(
                    scale: isSmallScreen ? 1.0 : 1.1,
                    child: Checkbox(
                      value: todo.isCompleted,
                      onChanged: (_) {
                        context.read<CarePlanProvider>().toggleTodoCompletion(
                          todo.id,
                        );
                      },
                      activeColor: colorScheme.primary,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Badges row
                        Wrap(
                          spacing: 6,
                          runSpacing: 4,
                          children: [
                            _buildPriorityBadge(
                              context,
                              todo.priority,
                              isSmallScreen: isSmallScreen,
                            ),
                            _buildFrequencyBadge(
                              context,
                              todo.frequency,
                              isSmallScreen: isSmallScreen,
                            ),
                          ],
                        ),
                        SizedBox(height: isSmallScreen ? 6 : 8),

                        // Title
                        Text(
                          todo.title,
                          style: GoogleFonts.inter(
                            fontSize: isSmallScreen ? 14 : 15,
                            fontWeight: FontWeight.w600,
                            decoration: todo.isCompleted
                                ? TextDecoration.lineThrough
                                : null,
                            color: todo.isCompleted
                                ? colorScheme.onSurfaceVariant
                                : colorScheme.onSurface,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: isSmallScreen ? 2 : 4),

                        // Description
                        Text(
                          todo.description,
                          style: TextStyle(
                            fontSize: isSmallScreen ? 12 : 13,
                            color: colorScheme.onSurfaceVariant,
                            decoration: todo.isCompleted
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: isSmallScreen ? 6 : 8),

                        // Metadata row
                        Wrap(
                          spacing: 12,
                          runSpacing: 4,
                          children: [
                            _buildMetadataItem(
                              context,
                              icon: Icons.schedule,
                              text: '${todo.estimatedDurationMinutes} min',
                              isSmallScreen: isSmallScreen,
                            ),
                            if (todo.suggestedTimeOfDay != null)
                              _buildMetadataItem(
                                context,
                                icon: Icons.access_time,
                                text: todo.suggestedTimeOfDay!,
                                isSmallScreen: isSmallScreen,
                              ),
                            if (todo.completedAt != null)
                              _buildMetadataItem(
                                context,
                                icon: Icons.check_circle,
                                text:
                                    'Completed ${_formatDate(todo.completedAt!)}',
                                isSmallScreen: isSmallScreen,
                                color: Colors.green,
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMetadataItem(
    BuildContext context, {
    required IconData icon,
    required String text,
    required bool isSmallScreen,
    Color? color,
  }) {
    final effectiveColor =
        color ?? Theme.of(context).colorScheme.onSurfaceVariant.withAlpha(200);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: isSmallScreen ? 14 : 16,
          color: effectiveColor,
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: isSmallScreen ? 11 : 12,
            color: effectiveColor,
          ),
        ),
      ],
    );
  }

  Color _getPriorityColor(String priority, ColorScheme colorScheme) {
    switch (priority.toLowerCase()) {
      case 'high':
        return OiselyColors.errorLight;
      case 'medium':
        return OiselyColors.warningLight;
      case 'low':
        return OiselyColors.successLight;
      default:
        return colorScheme.surface;
    }
  }

  Widget _buildPriorityBadge(
    BuildContext context,
    String priority, {
    required bool isSmallScreen,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    Color badgeColor;
    IconData icon;

    switch (priority.toLowerCase()) {
      case 'high':
        badgeColor = OiselyColors.error;
        icon = Icons.priority_high;
        break;
      case 'medium':
        badgeColor = OiselyColors.warning;
        icon = Icons.remove;
        break;
      case 'low':
        badgeColor = OiselyColors.success;
        icon = Icons.arrow_downward;
        break;
      default:
        badgeColor = colorScheme.outline;
        icon = Icons.remove;
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 6 : 8,
        vertical: isSmallScreen ? 2 : 4,
      ),
      decoration: BoxDecoration(
        color: badgeColor.withAlpha(30),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: badgeColor.withAlpha(100)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: isSmallScreen ? 10 : 12, color: badgeColor),
          const SizedBox(width: 2),
          Text(
            priority.toUpperCase(),
            style: TextStyle(
              fontSize: isSmallScreen ? 9 : 10,
              fontWeight: FontWeight.bold,
              color: badgeColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFrequencyBadge(
    BuildContext context,
    String frequency, {
    required bool isSmallScreen,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    IconData icon;

    switch (frequency.toLowerCase()) {
      case 'daily':
        icon = Icons.today;
        break;
      case 'weekly':
        icon = Icons.view_week;
        break;
      case 'yearly':
        icon = Icons.calendar_today;
        break;
      default:
        icon = Icons.event;
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 6 : 8,
        vertical: isSmallScreen ? 2 : 4,
      ),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer.withAlpha(100),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: isSmallScreen ? 10 : 12, color: colorScheme.primary),
          const SizedBox(width: 2),
          Text(
            frequency.toUpperCase(),
            style: TextStyle(
              fontSize: isSmallScreen ? 9 : 10,
              fontWeight: FontWeight.bold,
              color: colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(
    BuildContext context, {
    required bool isActive,
    required bool isError,
    bool isSmallScreen = false,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isError
                  ? Icons.error_outline
                  : isActive
                  ? Icons.check_circle_outline
                  : Icons.inbox_outlined,
              size: isSmallScreen ? 56 : 72,
              color: isError ? colorScheme.error : colorScheme.outlineVariant,
            ),
            const SizedBox(height: 16),
            Text(
              isError
                  ? 'Something went wrong'
                  : isActive
                  ? 'All caught up!'
                  : 'No completed tasks yet',
              style: GoogleFonts.inter(
                fontSize: isSmallScreen ? 16 : 20,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              isError
                  ? context.read<CarePlanProvider>().error ??
                        'An error occurred'
                  : isActive
                  ? 'You have no active tasks for the selected date. Select a different date or generate a new care plan.'
                  : 'Complete tasks by checking them off or swiping them away.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isSmallScreen ? 13 : 14,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            if (isActive) ...[
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  context.read<CarePlanProvider>().generateCarePlan();
                },
                icon: const Icon(Icons.refresh, size: 18),
                label: const Text('Generate Care Plan'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerLoading(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Shimmer.fromColors(
      baseColor: colorScheme.surfaceContainerHighest,
      highlightColor: colorScheme.surface,
      child: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: 4,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            height: 100,
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
            ),
          );
        },
      ),
    );
  }

  Widget? _buildFloatingActionButton(BuildContext context) {
    final provider = context.watch<CarePlanProvider>();

    if (!provider.hasCarePlan || provider.isLoading) {
      return null;
    }

    return FloatingActionButton.extended(
      onPressed: () => _showRegenerateDialog(context),
      icon: const Icon(Icons.refresh),
      label: const Text('Regenerate'),
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
    );
  }

  void _showTodoDetails(
    BuildContext context,
    CarePlanTodo todo,
    bool isSmallScreen,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.85,
        expand: false,
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                controller: scrollController,
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Handle
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
                    const SizedBox(height: 20),

                    // Header
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _buildPriorityBadge(
                          context,
                          todo.priority,
                          isSmallScreen: isSmallScreen,
                        ),
                        _buildFrequencyBadge(
                          context,
                          todo.frequency,
                          isSmallScreen: isSmallScreen,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Title
                    Text(
                      todo.title,
                      style: GoogleFonts.inter(
                        fontSize: isSmallScreen ? 20 : 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Description
                    Text(
                      todo.description,
                      style: TextStyle(
                        fontSize: isSmallScreen ? 14 : 16,
                        color: colorScheme.onSurfaceVariant,
                        height: 1.5,
                      ),
                    ),

                    // AI Reasoning
                    if (todo.aiReasoning != null) ...[
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: colorScheme.primaryContainer.withAlpha(50),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: colorScheme.primary.withAlpha(50),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.psychology,
                                  size: 20,
                                  color: colorScheme.primary,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'AI Recommendation',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600,
                                    color: colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              todo.aiReasoning!,
                              style: TextStyle(
                                color: colorScheme.onSurfaceVariant,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],

                    const SizedBox(height: 24),

                    // Action button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          context.read<CarePlanProvider>().toggleTodoCompletion(
                            todo.id,
                          );
                        },
                        icon: Icon(
                          todo.isCompleted
                              ? Icons.check_circle_outline
                              : Icons.check_circle,
                        ),
                        label: Text(
                          todo.isCompleted
                              ? 'Mark Incomplete'
                              : 'Mark Complete',
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: todo.isCompleted
                              ? colorScheme.surfaceContainerHighest
                              : Colors.green,
                          foregroundColor: todo.isCompleted
                              ? colorScheme.onSurface
                              : Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showRegenerateDialog(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Generate New Care Plan?'),
        content: const Text(
          'This will replace your current care plan with a new AI-generated one. Your task completion history will be reset.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<CarePlanProvider>().generateCarePlan();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
            ),
            child: const Text('Generate'),
          ),
        ],
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

    return DateFormat.MMMd().format(date);
  }
}
