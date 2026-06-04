import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/human_resources/domain/entity/all_attendance_record.dart';

import '../../repository/repository.dart';

class GetAllMissingAttendanceUseCase
    extends UseCase<AllAttendanceRecord, AllMissingAttendanceParams> {
  final HRServicesRepository _repository;
  GetAllMissingAttendanceUseCase(this._repository);
  @override
  Future<Either<Failure, AllAttendanceRecord>> call(
      {required AllMissingAttendanceParams params}) async {
    return await _repository.getAllMissingAttendance(params: params);
  }
}

// {
// "userId":     123,
// "pageNumber": 1,
// "pageSize":   10
// }

class AllMissingAttendanceParams extends Equatable {
  final int userId;
  final int pageNumber;
  final int pageSize;

  const AllMissingAttendanceParams(
      {required this.userId, required this.pageNumber, required this.pageSize});

  Map<String, dynamic> toJson() {
    return {"userId": userId, "pageNumber": pageNumber, "pageSize": pageSize};
  }

  @override
  List<Object?> get props => [userId, pageNumber, pageSize];
}
