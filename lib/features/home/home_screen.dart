import 'package:flutter/material.dart';

import '../../common/widgets/sized_boxes/sizer.dart';
import '../../core/constants/app_sizes.dart';
import 'presentation/widgets/announcement_card.dart';
import 'presentation/widgets/attendance_stats/attendance_stats_section.dart';

/// Home screen.
///
/// Composition (top → bottom):
///   1. [AttendanceStatsSection] — section header + 2×2 grid of stat
///      cards (late hours / work hours / early departure / overtime).
///   2. [AnnouncementCard]       — teal banner with the latest reminder.
///
/// All visual logic lives inside the dedicated widget files under
/// `presentation/widgets/`. This screen stays a thin composition layer
/// so it's easy to read and re-arrange.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.padding,
        vertical: AppSizes.padding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          /// localized strings come from a single place.
          AnnouncementCard.attendance(),

          ///  Attendance statistics (4 cards in a 2×2 grid)
          const AttendanceStatsSection(),

          /// make Size
          const Sizer(height: 24),

          const Sizer(height: 24),
        ],
      ),
    );
  }
}
