abstract interface class SessionStorage {
  String? get token;
  String? get userId;
  String? get employeeId;
  String? get managerId;
  String? get userName;
  String? get email;
  String? get organizationName;
  String? get departmentAddress;
  String? get departmentId;
  String? get offices;
  String? get officesList;
  String? get jobNumber;
  String? get jobTitle;
  String? get registrationNumber;

  Future<void> saveToken(String value);
  Future<void> saveUserId(String value);
  Future<void> saveEmployeeId(String value);
  Future<void> saveManagerId(String value);
  Future<void> saveUserName(String value);
  Future<void> saveEmail(String value);
  Future<void> saveOrganizationName(String value);
  Future<void> saveDepartmentAddress(String value);
  Future<void> saveDepartmentId(String value);
  Future<void> saveOffices(String value);
  Future<void> saveOfficesList(String value);
  Future<void> saveJobNumber(String value);
  Future<void> saveJobTitle(String value);
  Future<void> saveRegistrationNumber(String value);

  Future<void> clearSession();
}
