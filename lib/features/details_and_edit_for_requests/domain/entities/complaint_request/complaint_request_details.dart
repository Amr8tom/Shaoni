import 'package:equatable/equatable.dart';

import '../../../../../core/models/request_attachment.dart';

class ComplaintRequestDetails extends Equatable {
  final String? complaintType;
  final String? complaintReason;
  final String? complaintDescription;
  final String? state;
  final String? date;
  final List<RequestAttachment> attachments;

  const ComplaintRequestDetails({
    this.complaintType,
    this.complaintReason,
    this.complaintDescription,
    this.state,
    this.date,
    this.attachments = const [],
  });

  /// Coerces a value that may arrive as a plain String or as a
  /// `{id, name}` object into a display String.
  static String? _asString(dynamic value) {
    if (value == null) return null;
    if (value is String) return value;
    if (value is Map) {
      return (value['name'] ?? value['value'] ?? value['id'])?.toString();
    }
    return value.toString();
  }

  factory ComplaintRequestDetails.fromJson(Map<String, dynamic> json) {
    return ComplaintRequestDetails(
      // The details API sends the display names under *Name keys; fall back to
      // the bare keys for forward/backward compatibility.
      complaintType:
          _asString(json['complaintTypeName'] ?? json['complaintType']),
      complaintReason:
          _asString(json['complaintReasonName'] ?? json['complaintReason']),
      complaintDescription: _asString(json['complaintDescription']),
      state: _asString(json['state']),
      date: _asString(json['date']),
      attachments: RequestAttachment.listFrom(json['attachments']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'complaintTypeName': complaintType,
      'complaintReasonName': complaintReason,
      'complaintDescription': complaintDescription,
      'state': state,
      'date': date,
      'attachments': attachments.map((a) => a.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [
        complaintType,
        complaintReason,
        complaintDescription,
        state,
        date,
        attachments,
      ];
}
