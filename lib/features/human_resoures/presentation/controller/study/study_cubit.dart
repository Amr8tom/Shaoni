import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../../core/utils/enums/general_status.dart';

part 'study_state.dart';

class StudyCubit extends Cubit<StudyState> {
  StudyCubit() : super(const StudyState());
}
