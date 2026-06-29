import 'package:shaoni/features/booking_managment/domain/entity/ticket_booking/create_ticket_booking_response.dart';

class CreateTicketBookingResponseModel extends CreateTicketBookingResponse {
  const CreateTicketBookingResponseModel({
    super.success = false,
    super.message = '',
    super.requestId,
    super.requestName = '',
  });

  factory CreateTicketBookingResponseModel.fromJson(Map<String, dynamic> json) {
    // The request name (e.g. "ETB000031") lives in data.body.name on success.
    String requestName = '';
    final data = json['data'];
    if (data is Map<String, dynamic>) {
      final body = data['body'];
      if (body is Map<String, dynamic>) {
        requestName = body['name'] as String? ?? '';
      }
    }

    return CreateTicketBookingResponseModel(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      requestId: json['requestId'] as int?,
      requestName: requestName,
    );
  }
}
