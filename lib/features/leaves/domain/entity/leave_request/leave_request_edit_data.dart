import 'package:equatable/equatable.dart';

class LeaveRequestEditAttachment extends Equatable {
  final int? id;
  final String name;
  final String url;

  const LeaveRequestEditAttachment({
    this.id,
    this.name = '',
    this.url = '',
  });

  @override
  List<Object?> get props => [id, name, url];
}

/// The editable snapshot of an existing hr.leave request, used to prefill the
/// form in edit mode. Source: GET /Request/{id}/with-stages → extraData.leaveRequest
class LeaveRequestEditData extends Equatable {
  final String holidayType;
  final int? holidayStatusId;
  final int? alternativeEmployeeId;
  final String validationType;
  final String requestDateFrom;
  final String requestDateTo;
  final bool requestUnitHours;
  final bool requestUnitHalf;
  final String sequenceNumber;
  final List<LeaveRequestEditAttachment> attachments;

  const LeaveRequestEditData({
    this.holidayType = 'employee',
    this.holidayStatusId,
    this.alternativeEmployeeId,
    this.validationType = '',
    this.requestDateFrom = '',
    this.requestDateTo = '',
    this.requestUnitHours = false,
    this.requestUnitHalf = false,
    this.sequenceNumber = '',
    this.attachments = const [],
  });

  @override
  List<Object?> get props => [
        holidayType,
        holidayStatusId,
        alternativeEmployeeId,
        validationType,
        requestDateFrom,
        requestDateTo,
        requestUnitHours,
        requestUnitHalf,
        sequenceNumber,
        attachments,
      ];
}
