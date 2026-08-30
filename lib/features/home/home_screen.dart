import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/widgets/sized_boxes/sizer.dart';
import '../../core/constants/app_sizes.dart';
import 'presentation/controller/home_cubit.dart';
import 'presentation/widgets/announcement_card.dart';
import 'presentation/widgets/leave_and_request_stats/leave_stats_section.dart';
import 'presentation/widgets/leave_and_request_stats/request_stats_section.dart';

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

          // /  Attendance statistics (4 cards in a 2×2 grid)
          // const AttendanceStatsSection(),

          BlocBuilder<HomeCubit, HomeState>(
            buildWhen: (previous, current) =>
                previous.annualLeaveBalance != current.annualLeaveBalance,
            builder: (context, state) {
              final balance = state.annualLeaveBalance;
              if (balance == null) return const LeaveStatsSection();
              return LeaveStatsSection(
                totalAnnualLeaves: balance.totalDays ?? 0,
                remainingLeaves: balance.remainingDays ?? 0,
                takenLeaves: balance.usedDays ?? 0,
              );
            },
          ),

          const Sizer(height: 24),

          const RequestStatsSection(),

          /// make Size
          const Sizer(height: 24),

          const Sizer(height: 100),
        ],
      ),
    );
  }
}
