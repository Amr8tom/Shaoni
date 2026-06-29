part of 'ticket_booking_cubit.dart';

// ── Per-employee ticket line state ───────────────────────────────────────────

class TicketLineState extends Equatable {
  final String localId;
  final int? employeeId;
  final String employeeName;
  final DateTime? travelDate;
  final int? ticketClassId;
  final String attachmentName;
  final String attachmentBase64;

  const TicketLineState({
    required this.localId,
    this.employeeId,
    this.employeeName = '',
    this.travelDate,
    this.ticketClassId,
    this.attachmentName = '',
    this.attachmentBase64 = '',
  });

  TicketLineState copyWith({
    int? employeeId,
    String? employeeName,
    DateTime? travelDate,
    int? ticketClassId,
    String? attachmentName,
    String? attachmentBase64,
  }) {
    return TicketLineState(
      localId: localId,
      employeeId: employeeId ?? this.employeeId,
      employeeName: employeeName ?? this.employeeName,
      travelDate: travelDate ?? this.travelDate,
      ticketClassId: ticketClassId ?? this.ticketClassId,
      attachmentName: attachmentName ?? this.attachmentName,
      attachmentBase64: attachmentBase64 ?? this.attachmentBase64,
    );
  }

  @override
  List<Object?> get props => [
        localId,
        employeeId,
        employeeName,
        travelDate,
        ticketClassId,
        attachmentName,
        attachmentBase64,
      ];
}

// ── Status enum ──────────────────────────────────────────────────────────────

enum TicketBookingStatus {
  initial,
  lookupsLoading,
  lookupsLoaded,
  lookupsError,
  createLoading,
  createLoaded,
  createError,
}

extension TicketBookingStatusX on TicketBookingStatus {
  bool get isLoading =>
      this == TicketBookingStatus.lookupsLoading ||
      this == TicketBookingStatus.createLoading;
  bool get isError =>
      this == TicketBookingStatus.createError ||
      this == TicketBookingStatus.lookupsError;
  bool get isCreateLoaded => this == TicketBookingStatus.createLoaded;
  bool get isLookupsLoaded => this == TicketBookingStatus.lookupsLoaded;
}

// ── State ────────────────────────────────────────────────────────────────────

class TicketBookingState extends Equatable {
  final TicketBookingStatus status;
  final List<TicketClass> ticketClasses;
  final List<VisaEmployee> employees;
  final String selectedTicketType; // 'in' | 'out'
  final DateTime? travelDate;
  final List<TicketLineState> lines;
  final String attachmentName;
  final String attachmentBase64;
  final String? errorMessage;
  final String? requestNumber;

  const TicketBookingState({
    this.status = TicketBookingStatus.initial,
    this.ticketClasses = const [],
    this.employees = const [],
    this.selectedTicketType = '',
    this.travelDate,
    this.lines = const [],
    this.attachmentName = '',
    this.attachmentBase64 = '',
    this.errorMessage,
    this.requestNumber,
  });

  TicketBookingState copyWith({
    TicketBookingStatus? status,
    List<TicketClass>? ticketClasses,
    List<VisaEmployee>? employees,
    String? selectedTicketType,
    DateTime? travelDate,
    List<TicketLineState>? lines,
    String? attachmentName,
    String? attachmentBase64,
    String? errorMessage,
    String? requestNumber,
  }) {
    return TicketBookingState(
      status: status ?? this.status,
      ticketClasses: ticketClasses ?? this.ticketClasses,
      employees: employees ?? this.employees,
      selectedTicketType: selectedTicketType ?? this.selectedTicketType,
      travelDate: travelDate ?? this.travelDate,
      lines: lines ?? this.lines,
      attachmentName: attachmentName ?? this.attachmentName,
      attachmentBase64: attachmentBase64 ?? this.attachmentBase64,
      errorMessage: errorMessage ?? this.errorMessage,
      requestNumber: requestNumber ?? this.requestNumber,
    );
  }

  @override
  List<Object?> get props => [
        status,
        ticketClasses,
        employees,
        selectedTicketType,
        travelDate,
        lines,
        attachmentName,
        attachmentBase64,
        errorMessage,
        requestNumber,
      ];
}
