import 'package:shaoni/features/booking_managment/domain/entity/ticket_booking/ticket_class.dart';

class TicketClassModel extends TicketClass {
  const TicketClassModel({required super.id, required super.name});

  factory TicketClassModel.fromJson(Map<String, dynamic> json) {
    return TicketClassModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
    );
  }
}
