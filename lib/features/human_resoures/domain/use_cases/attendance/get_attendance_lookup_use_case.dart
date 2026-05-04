import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/human_resoures/domain/entity/attendance/attendance_lookup.dart';

import '../../repository/repository.dart';

class GetAttendanceLookupUseCase extends UseCase<List<AttendanceLookup>,NoParams>{
  final HRServicesRepository _repository;
    GetAttendanceLookupUseCase(this._repository);
    
  @override
  Future<Either<Failure, List<AttendanceLookup>>> call({required NoParams params}) async{
    return await _repository.getAttendanceLookup(params: NoParams());
    

  }
}