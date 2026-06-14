class URL {
  static const String baseUrl = 'http://47.77.206.229:83/api/v1';
  static const String login = '$baseUrl/Auth/login';
  static const String user = '$baseUrl/User/';
  static const String changePassword = '$baseUrl/User/reset-password';
  static const String updateProfile = '$baseUrl/User/edit-profile';
  static const String getAllRequestsStatusCount =
      '$baseUrl/Request/status-counts/all-services';
  static const String forgetPassword = '$baseUrl/Auth/ForgetPassword';
  static const String setPassword = '$baseUrl/Auth/SetPassword';
  static const String resendOtp = '$baseUrl/Auth/ResendOtp';
  static const String sendOtp = '$baseUrl/Auth/PilgrimLoginOtp';
  // static const String feedback = '$baseUrl/feedbacks/CreateFeedback';

  /// human resources
  static const String getAllServices = '$baseUrl/Service/get-all-services';
  static const String exitPermission = '$baseUrl/HrExitPermission/exit';
  static const String updateExitPermission =
      '$baseUrl/HrExitPermission/update/';
  static const String getExitPermissionEdit = '$baseUrl/HrExitPermission/edit/';
  static const String getPermissionTypes =
      '$baseUrl/Integration/get-permission-types';
  static const String getPermissionTime = '$baseUrl/Lookup/GetPermissionTime';

  /// ============================ attendance  ============================
  static const String getAttendanceRecord =
      '$baseUrl/Attendance/missing/paged/by-user';
  static const String createAttendanceRequest = '$baseUrl/Attendance/create';
  static const String updateAttendanceRequest = '$baseUrl/Attendance/update/';
  static const String getAttendanceEdit = '$baseUrl/Attendance/edit/';
  static const String getAttendanceLookUp =
      '$baseUrl/Lookup/GetAttendanceLookup';
  static const String getAttendanceForgetReason =
      '$baseUrl/Lookup/GetForgetReasons';

  /// ============================ car permission ============================
  static const String getCarColors = '$baseUrl/Lookup/GetCarColors';
  static const String getCarBrands = '$baseUrl/Lookup/GetCarBrands';
  static const String createCarPermission = '$baseUrl/CarPermission';
  static const String updateCarPermission = '$baseUrl/CarPermission/update/';
  static const String getCarPermissionEdit = '$baseUrl/CarPermission/edit/';

  /// ============================ study request ============================
  static const String getStudyTypes = '$baseUrl/Lookup/GetStudyTypes';
  static const String getStudyDestinations =
      '$baseUrl/Integration/get-study-Destinations';
  static const String createStudyRequest = '$baseUrl/StudyRequest/create';
  static const String updateStudyRequest = '$baseUrl/StudyRequest/update/';
  static const String getStudyEdit = '$baseUrl/StudyRequest/edit/';

  /// ============================ experience certificate ============================
  static const String getCertificateReasons =
      '$baseUrl/Lookup/GetCertificateReasons';
  static const String createExperienceCertificate =
      '$baseUrl/ExperienceCertificate';
  static const String updateExperienceCertificate =
      '$baseUrl/ExperienceCertificate/update/';
  static const String getExperienceCertificateEdit =
      '$baseUrl/ExperienceCertificate/edit/';

  /// ============================ id document ============================
  static const String getDepartments = '$baseUrl/Lookup/GetDepartments';
  static const String getCountries = '$baseUrl/Lookup/GetCountries';
  static const String getIDRenewalRequestTypes =
      '$baseUrl/Lookup/GetIDRenewalRequestTypes';
  // createIDDocument URL TBD by backend developer
  static const String createIDDocument = '$baseUrl/IDRenewal/create';
  static const String updateIDDocument = '$baseUrl/IDRenewal/update/';
  static const String getIDDocumentEdit = '$baseUrl/IDRenewal/edit/';

  /// ============================ start work ============================
  static const String getStartWorkTypes =
      '$baseUrl/Lookup/GetStartWorkingTypes';
  static const String getEmployees = '$baseUrl/Lookup/GetEmployees';
  static const String createStartWork = '$baseUrl/StartWorking';
  static const String updateStartWork = '$baseUrl/StartWorking/update/';
  static const String getStartWorkEdit = '$baseUrl/StartWorking/edit/';

  /// ============================ product order ============================
  static const String getProductCategories =
      '$baseUrl/Lookup/GetProductCategories';
  static const String getProductsByCategory =
      '$baseUrl/Lookup/GetOdooProductsByFilter';
  static const String createProductOrder = '$baseUrl/ProductOrder';
  static const String updateProductOrder = '$baseUrl/ProductOrder/update/';
  static const String getProductOrderEdit = '$baseUrl/ProductOrder/edit/';

  /// ============================ training request ============================
  static const String getCourses = '$baseUrl/Lookup/GetCourses';
  static const String createTrainingRequest = '$baseUrl/Training/create';
  static const String updateTrainingRequest = '$baseUrl/Training/update/';
  static const String getTrainingRequestEdit = '$baseUrl/Training/edit/';

  /// ============================ medical insurance ============================
  static const String getMedicalInsuranceClasses =
      '$baseUrl/Lookup/GetMedicalInsuranceClasses';
  static const String getEmployeeRelatives =
      '$baseUrl/Lookup/GetEmployeeRelatives/';
  static const String createMedicalInsurance = '$baseUrl/MedicalInsurance';
  static const String updateMedicalInsurance =
      '$baseUrl/MedicalInsurance/update/';
  static const String getMedicalInsuranceEdit =
      '$baseUrl/MedicalInsurance/edit/';

  /// ============================ outside working ============================
  static const String getAttendanceWayLookup =
      '$baseUrl/Lookup/GetAttendanceWayLookup';
  static const String getDepartmentTypeLookup =
      '$baseUrl/Lookup/GetDepartmentTypeLookup';
  static const String getProjectTypeLookup =
      '$baseUrl/Lookup/GetProjectTypeLookup';
  static const String syncEmployees = '$baseUrl/Integration/sync-employees';
  static const String getProjects = '$baseUrl/Projects';
  static const String createOutsideWorking = '$baseUrl/OutsideWorking/create';
  static const String updateOutsideWorking = '$baseUrl/OutsideWorking/update/';
  static const String getOutsideWorkingEdit = '$baseUrl/OutsideWorking/edit/';

  /// ============================ complaint request ============================
  static const String getComplaintTypes = '$baseUrl/Lookup/GetComplaintTypes';
  static const String getComplaintReasons =
      '$baseUrl/Lookup/GetComplaintReasons';
  static const String createComplaintRequest = '$baseUrl/ComplaintRequest';

  /// ============================ loan requests ============================
  static const String getLoanTypes = '$baseUrl/Lookup/GetLoanTypes';
  static const String createLoanRequest = '$baseUrl/LoanRequest';
  static const String editLoanRequest = '$baseUrl/LoanRequest/edit/';
  static const String updateLoanRequest = '$baseUrl/LoanRequest/update/';

  /// ============================ salary requests ============================
  static const String createSalaryRequest = '$baseUrl/Salary/create';
  static const String updateSalaryRequest = '$baseUrl/Salary/update/';
  static const String getSalaryRequestEdit = '$baseUrl/Salary/edit/';
  static const String getSalarySubTypes = '$baseUrl/Lookup/GetSalarySubTypes';
  static const String getSalaryTypes = '$baseUrl/Lookup/GetSalaryTypes';
  static const String getSalaryDocumentTypes =
      '$baseUrl/Lookup/GetSalaryDocumentTypes';
  static const String getSalaryBanks = '$baseUrl/Salary/banks/';
  static const String getLetterDestinations =
      '$baseUrl/Salary/letter-destinations';

  /// ============================ exit permmison  ============================
  // static const String getAllRequestsWithStages = '$baseUrl/Request/with-stages/paged/by-user';

  static const String getAllRequestsWithStages =
      '$baseUrl/Request/dashboard/paged/by-user';
  static const String getRequestDetailsStages = '$baseUrl/Request/';

  // 75/with-stages';
  // static const String getRequestDetailsStages = '/with-stages';
  // static const String getAllRequestsWithStagesByManager = '$baseUrl/Request/with-stages/paged/for-manager';
  static const String getAllRequestsWithStagesByManager =
      '$baseUrl/Request/dashboard/paged/for-manager';
  static const String approveRequest = '$baseUrl/Request/status/';
  static const String deleteAccount = "$baseUrl/User/delete";
  static const String getCountUnreadedNotificaion =
      '$baseUrl/getCountUnreadedNotificaion';
  static const String privacyPolicy =
      "https://sites.google.com/view/shaoni?usp=sharing";
  static const String taskUniqueName = "s-daily-update";
  static const String taskInitUniqueName = "s-one-time-scheduler";
  static const String taskName = "sBackgroundTask";
  static const String taskInistialName = "sBackgroundTaskforInitialTime";
}
