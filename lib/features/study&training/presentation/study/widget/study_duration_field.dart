import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/features/human_resources/presentation/attendance/widget/attendance_editable_field.dart';
import 'package:shaoni/features/study&training/presentation/controller/study/study_cubit.dart';
import 'package:shaoni/generated/l10n.dart';

class StudyDurationField extends StatefulWidget {
  const StudyDurationField({super.key});

  @override
  State<StudyDurationField> createState() => _StudyDurationFieldState();
}

class _StudyDurationFieldState extends State<StudyDurationField> {
  late final StudyCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<StudyCubit>();
    _cubit.durationController.addListener(_onDurationChanged);
  }

  void _onDurationChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _cubit.durationController.removeListener(_onDurationChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DEditableField(
      label: S.current.duration,
      hint: S.current.duration,
      icon: Icons.timer_outlined,
      iconColor: ColorRes.black,
      controller: _cubit.durationController,
      readOnly: true,
      keyboardType: TextInputType.text,
    );
  }
}
