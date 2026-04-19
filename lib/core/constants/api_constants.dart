class URL {
  static const String baseUrl = 'http://47.77.206.229:83/api/v1';
  static const String login = '$baseUrl/Auth/login';
  static const String user = '$baseUrl/User/';
  static const String changePassword = '$baseUrl/User/reset-password';
  static const String updateProfile = '$baseUrl/User/edit-profile';
  static const String getAllRequestsStatusCount = '$baseUrl/Request/status-counts/all-services';
  static const String forgetPassword = '$baseUrl/Auth/ForgetPassword';
  static const String setPassword = '$baseUrl/Auth/SetPassword';
  static const String resendOtp = '$baseUrl/Auth/ResendOtp';
  static const String sendOtp = '$baseUrl/Auth/PilgrimLoginOtp';
  // static const String feedback = '$baseUrl/feedbacks/CreateFeedback';
  static const String getAllServices = '$baseUrl/Service/get-all-services';
  static const String exitPermission = '$baseUrl/HrExitPermission/exit';
  static const String getPermissionTypes = '$baseUrl/Integration/get-permission-types';
  static const String getPermissionTime = '$baseUrl/Lookup/GetPermissionTime';
  static const String getAllRequestsWithStages = '$baseUrl/Request/with-stages/paged/by-user';
  static const String getAllRequestsWithStagesByManager = '$baseUrl/Request/with-stages/paged/for-manager';
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



