import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/features/human_resoures/presentation/screens/attendance/widget/attendance_missing_item.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/service_locator/service_locator.dart';
import '../../../../../generated/l10n.dart';
import '../../controller/attendance/attendance_cubit.dart';

class MissingAttendanceHistoryScreen extends StatelessWidget {
  const MissingAttendanceHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<AttendanceCubit>(),
      child: Scaffold(
        backgroundColor: ColorRes.grey6,
        appBar: DAppBar(
          showBackArrow: true,
          showMenu: false,
          title: S.current.attendanceHistories,
          fontSize: AppSizes.fontSizeMd,
          actions: const [],
        ),
        body: BlocBuilder<AttendanceCubit, AttendanceState>(
          builder: (context, state) {
            return RefreshIndicator(
              color: ColorRes.primary,
              onRefresh: () => context.read<AttendanceCubit>().refresh(),
              child: AttendanceMissingItem(state: state),
            );
          },
        ),
      ),
    );
  }
}
