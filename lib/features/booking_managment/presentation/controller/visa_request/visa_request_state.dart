part of 'visa_request_cubit.dart';

// ── Per-employee visa line state ─────────────────────────────────────────────

class VisaLineState extends Equatable {
  final VisaEmployee employee;
  final DateTime? dateFrom;
  final DateTime? dateTo;

  const VisaLineState({
    required this.employee,
    this.dateFrom,
    this.dateTo,
  });

  VisaLineState copyWith({
    DateTime? dateFrom,
    DateTime? dateTo,
  }) {
    return VisaLineState(
      employee: employee,
      dateFrom: dateFrom ?? this.dateFrom,
      dateTo: dateTo ?? this.dateTo,
    );
  }

  @override
  List<Object?> get props => [employee, dateFrom, dateTo];
}

// ── Status enum ──────────────────────────────────────────────────────────────

enum VisaRequestStatus {
  initial,
  lookupsLoading,
  lookupsLoaded,
  lookupsError,
  createLoading,
  createLoaded,
  createError,
}

extension VisaRequestStatusX on VisaRequestStatus {
  bool get isLoading =>
      this == VisaRequestStatus.lookupsLoading ||
      this == VisaRequestStatus.createLoading;
  bool get isError =>
      this == VisaRequestStatus.createError ||
      this == VisaRequestStatus.lookupsError;
  bool get isCreateLoaded => this == VisaRequestStatus.createLoaded;
  bool get isLookupsLoaded => this == VisaRequestStatus.lookupsLoaded;
}

// ── State ────────────────────────────────────────────────────────────────────

class VisaRequestState extends Equatable {
  final VisaRequestStatus status;
  final List<VisaType> visaTypes;
  final List<VisaLanguage> languages;
  final List<VisaEmployee> employees;
  final bool employeesLoading;
  final int? selectedVisaTypeId;
  final String selectedVisaTypeCode;
  final String selectedVisaTypeName;
  final int? selectedLangId;
  final String selectedLangName;
  final DateTime? dateFrom;
  final DateTime? dateTo;
  final String attachmentName;
  final String attachmentBase64;
  final List<VisaLineState> lines;
  final String searchQuery;
  final String? errorMessage;
  final String? requestNumber;

  const VisaRequestState({
    this.status = VisaRequestStatus.initial,
    this.visaTypes = const [],
    this.languages = const [],
    this.employees = const [],
    this.employeesLoading = false,
    this.selectedVisaTypeId,
    this.selectedVisaTypeCode = '',
    this.selectedVisaTypeName = '',
    this.selectedLangId,
    this.selectedLangName = '',
    this.dateFrom,
    this.dateTo,
    this.attachmentName = '',
    this.attachmentBase64 = '',
    this.lines = const [],
    this.searchQuery = '',
    this.errorMessage,
    this.requestNumber,
  });

  /// Employees filtered by the current search query.
  List<VisaEmployee> get filteredEmployees {
    if (searchQuery.trim().isEmpty) return employees;
    final query = searchQuery.toLowerCase().trim();
    return employees
        .where((e) => e.displayName.toLowerCase().contains(query))
        .toList();
  }

  bool isEmployeeSelected(int id) => lines.any((l) => l.employee.id == id);

  VisaRequestState copyWith({
    VisaRequestStatus? status,
    List<VisaType>? visaTypes,
    List<VisaLanguage>? languages,
    List<VisaEmployee>? employees,
    bool? employeesLoading,
    int? selectedVisaTypeId,
    String? selectedVisaTypeCode,
    String? selectedVisaTypeName,
    int? selectedLangId,
    String? selectedLangName,
    DateTime? dateFrom,
    DateTime? dateTo,
    String? attachmentName,
    String? attachmentBase64,
    List<VisaLineState>? lines,
    String? searchQuery,
    String? errorMessage,
    String? requestNumber,
  }) {
    return VisaRequestState(
      status: status ?? this.status,
      visaTypes: visaTypes ?? this.visaTypes,
      languages: languages ?? this.languages,
      employees: employees ?? this.employees,
      employeesLoading: employeesLoading ?? this.employeesLoading,
      selectedVisaTypeId: selectedVisaTypeId ?? this.selectedVisaTypeId,
      selectedVisaTypeCode: selectedVisaTypeCode ?? this.selectedVisaTypeCode,
      selectedVisaTypeName: selectedVisaTypeName ?? this.selectedVisaTypeName,
      selectedLangId: selectedLangId ?? this.selectedLangId,
      selectedLangName: selectedLangName ?? this.selectedLangName,
      dateFrom: dateFrom ?? this.dateFrom,
      dateTo: dateTo ?? this.dateTo,
      attachmentName: attachmentName ?? this.attachmentName,
      attachmentBase64: attachmentBase64 ?? this.attachmentBase64,
      lines: lines ?? this.lines,
      searchQuery: searchQuery ?? this.searchQuery,
      errorMessage: errorMessage ?? this.errorMessage,
      requestNumber: requestNumber ?? this.requestNumber,
    );
  }

  @override
  List<Object?> get props => [
        status,
        visaTypes,
        languages,
        employees,
        employeesLoading,
        selectedVisaTypeId,
        selectedVisaTypeCode,
        selectedVisaTypeName,
        selectedLangId,
        selectedLangName,
        dateFrom,
        dateTo,
        attachmentName,
        attachmentBase64,
        lines,
        searchQuery,
        errorMessage,
        requestNumber,
      ];
}
