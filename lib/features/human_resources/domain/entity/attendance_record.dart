import 'package:equatable/equatable.dart';

/// Domain entity representing a single attendance record for a given day.
///
/// Mirrors the card layout in the attendance screen:
///   - Header   → [employeeName] + [gregorianDate]
///   - Check-in → [checkInTime] + [hijriDate] + [isCheckedIn]
///   - Check-out → [checkOutTime] + [isCheckedOut]
///   - Out mode  → [outMode] (e.g. "في الموعد", "تأخير", or null when unknown)
///
/// All "missing data" flags are intentionally nullable strings so the UI
/// can render localized placeholders ("غير متاح", "-") without polluting
/// the entity with presentation logic.
class AttendanceRecord extends Equatable {
  final String id;
  final String employeeId;
  final String odooId;
  final String employeeName;

  /// Display name returned by the API — e.g. `من 03:00:00 ص`.
  /// Shown as the "سجل البصمة" / fingerprint-record value on the form.
  final String? displayName;

  /// Gregorian date in `yyyy-MM-dd` format (matches API response).
  final String gregorianDate;

  /// Hijri date already-formatted for display, e.g. `١ رجب ١٤٤٧`.
  final String hijriDate;

  /// Hijri date for the check-out moment — may be empty / null when the
  /// user hasn't checked out yet.
  final String? hijriCheckOutDisplay;

  /// Mode used when the check-in was registered (e.g. `manual`, `system`).
  final String? inMode;

  /// `07:30 ص` style — null when the user hasn't checked in yet.
  final String? checkInTime;
  final bool isCheckedIn;

  /// `04:15 م` style — null when the user hasn't checked out yet.
  final String? checkOutTime;
  final bool isCheckedOut;

  /// Free-text label for how the user left (e.g. permission, end-of-day).
  /// Null when not yet determined.
  final String? outMode;

  const AttendanceRecord({
    required this.id,
    required this.odooId,
    required this.employeeId,
    required this.employeeName,
    required this.gregorianDate,
    required this.hijriDate,
    required this.checkInTime,
    required this.isCheckedIn,
    required this.checkOutTime,
    required this.isCheckedOut,
    required this.outMode,
    this.displayName,
    this.hijriCheckOutDisplay,
    this.inMode,
  });

  @override
  List<Object?> get props => [
        id,
        odooId,
        employeeName,
        gregorianDate,
        hijriDate,
        checkInTime,
        isCheckedIn,
        checkOutTime,
        isCheckedOut,
        outMode,
      ];
}
