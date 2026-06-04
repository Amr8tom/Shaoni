import 'package:equatable/equatable.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/entities/request_with_stage.dart';

class AllRequestsWithStages extends Equatable {
  final int pageNumber;
  final int pageSize;
  final int totalCount;
  final int totalPages;
  final List<RequestWithStage> items;

  const AllRequestsWithStages({
    required this.pageNumber,
    required this.pageSize,
    required this.totalCount,
    required this.totalPages,
    required this.items,
  });

  @override
  List<Object?> get props => [
        pageNumber,
        pageSize,
        totalCount,
        totalPages,
        items,
      ];
}
