import 'package:equatable/equatable.dart';

class ComplaintRequestDetails extends Equatable {
  final String? complaintType;
  final String? complaintReason;
  final String? complaintDescription;
  final String? state;
  final String? date;
  final List<dynamic>? attachments;

  const ComplaintRequestDetails({
    this.complaintType,
    this.complaintReason,
    this.complaintDescription,
    this.state,
    this.date,
    this.attachments,
  });

  factory ComplaintRequestDetails.fromJson(Map<String, dynamic> json) {
    return ComplaintRequestDetails(
      complaintType: json['complaintType'],
      complaintReason: json['complaintReason'],
      complaintDescription: json['complaintDescription'],
      state: json['state'],
      date: json['date'],
      attachments: json['attachments'] != null
          ? json['attachments'] as List<dynamic>
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'complaintType': complaintType,
      'complaintReason': complaintReason,
      'complaintDescription': complaintDescription,
      'state': state,
      'date': date,
      'attachments': attachments,
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
