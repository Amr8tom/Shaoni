import 'package:get_it/get_it.dart';
import 'package:shaoni/features/study&training/data/data_sources/local_data_sources.dart';
import 'package:shaoni/features/study&training/data/data_sources/remote_data_sources.dart';
import 'package:shaoni/features/study&training/data/repositories/repository.dart';
import 'package:shaoni/features/study&training/domain/repository/repository.dart';
import 'package:shaoni/features/study&training/domain/use_cases/study/create_study_use_case.dart';
import 'package:shaoni/features/study&training/domain/use_cases/study/get_study_destinations_use_case.dart';
import 'package:shaoni/features/study&training/domain/use_cases/study/get_study_types_use_case.dart';
import 'package:shaoni/features/study&training/domain/use_cases/study/update_study_use_case.dart';
import 'package:shaoni/features/study&training/domain/use_cases/training_request/create_training_request_use_case.dart';
import 'package:shaoni/features/study&training/domain/use_cases/training_request/get_courses_use_case.dart';
import 'package:shaoni/features/study&training/domain/use_cases/training_request/update_training_request_use_case.dart';
import 'package:shaoni/features/study&training/presentation/controller/study/study_cubit.dart';
import 'package:shaoni/features/study&training/presentation/controller/training_request/training_request_cubit.dart';

class StudyTrainingServiceLocator {
  static execute({required GetIt serviceLocator}) async {
    /// ── Data sources ─────────────────────────────────────────────────────────
    serviceLocator.registerLazySingleton<StudyServicesLocalDataSources>(
      () => StudyServicesLocalDataSourcesImp(),
    );
    serviceLocator.registerLazySingleton<StudyServicesRemoteDataSources>(
      () => StudyServicesRemoteDataSourcesImp(serviceLocator()),
    );

    /// ── Repository ───────────────────────────────────────────────────────────
    serviceLocator.registerLazySingleton<StudyServicesRepository>(
      () => StudyServicesRepositoryImp(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ),
    );

    /// ── Study request use cases ───────────────────────────────────────────────
    serviceLocator.registerLazySingleton<GetStudyTypesUseCase>(
      () => GetStudyTypesUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<GetStudyDestinationsUseCase>(
      () => GetStudyDestinationsUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<CreateStudyUseCase>(
      () => CreateStudyUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<UpdateStudyUseCase>(
      () => UpdateStudyUseCase(serviceLocator()),
    );
    serviceLocator.registerFactory<StudyCubit>(
      () => StudyCubit(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ),
    );

    /// ── Training request use cases ────────────────────────────────────────────
    serviceLocator.registerLazySingleton<GetCoursesUseCase>(
      () => GetCoursesUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<CreateTrainingRequestUseCase>(
      () => CreateTrainingRequestUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<UpdateTrainingRequestUseCase>(
      () => UpdateTrainingRequestUseCase(serviceLocator()),
    );
    serviceLocator.registerFactory<TrainingRequestCubit>(
      () => TrainingRequestCubit(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ),
    );
  }
}
