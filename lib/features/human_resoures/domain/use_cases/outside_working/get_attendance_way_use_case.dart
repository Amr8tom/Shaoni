import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/human_resoures/domain/entity/outside_working/attendance_way.dart';
import 'package:shaoni/features/human_resoures/domain/repository/repository.dart';

class GetAttendanceWayUseCase extends UseCase<List<AttendanceWay>, NoParams> {
  final HRServicesRepository _repository;

  GetAttendanceWayUseCase(this._repository);

  @override
  Future<Either<Failure, List<AttendanceWay>>> call({required NoParams params}) async {
    return await _repository.getAttendanceWay(params: params);
  }
}
