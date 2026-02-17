import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entity/request_services_Entity.dart';

part 'request_service_state.dart';

class RequestServiceCubit extends Cubit<RequestServiceState> {
  RequestServiceCubit() : super(const RequestServiceState());

  /// open specific question
  void setExpandedIndex(int? index) {
    if (index == null) {
      emit(state.copyWith(clearExpandedIndex: true));
    } else {
      emit(state.copyWith(expandedIndex: index));
    }
  }
}
