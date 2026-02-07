class URL {
  static const String baseUrl = 'https://api-tea.ejad-dev.com:444/api';
  static const String login = '$baseUrl/Auth/PilgrimLogin';
  static const String register = '$baseUrl/Auth/PilgrimRegister';
  static const String forgetPassword = '$baseUrl/Auth/ForgetPassword';
  static const String setPassword = '$baseUrl/Auth/SetPassword';
  static const String resendOtp = '$baseUrl/Auth/ResendOtp';
  static const String sendOtp = '$baseUrl/Auth/PilgrimLoginOtp';

  // static const String feedback = '$baseUrl/feedbacks/CreateFeedback';
  static const String updateGeneralProfile =
      '$baseUrl/GeneralProfiles/UpdateGeneralProfile';
  static const String getGeneralProfile =
      '$baseUrl/GeneralProfiles/GetGeneralProfileByUserId';
  static const String updateMedicalProfile =
      '$baseUrl/MedicalProfiles/AddPilgramMedicine';
  static const String getMedicalProfile =
      '$baseUrl/MedicalProfiles/GetMedicalProfile';
  static const String getPilgrim = '$baseUrl/pilgrims/GetPilgrim';
  static const String addProfileImage = '$baseUrl/pilgrims/AddPilgramPicture';
  // static const String getPrayerTimes =
  //     'https://api.aladhan.com/v1/timingsByAddress/';
  /// quran APIS
  static const String getPrayerTimes =
      'http://api.aladhan.com/v1/timings';

  static const String getPrayerTimes2 = '?address=Umm+Al-Qura%2C+Makkah%2C+SA';
  static const String quranByJuz = 'http://api.alquran.cloud/v1/juz/';
  static const String quranBySurah = 'http://api.alquran.cloud/v1/surah/';
  static const String quranBySurahes = 'http://api.alquran.cloud/v1/quran/quran-uthmani';
  static const String quranType = 'quran-uthmani';
  static const String allSurahes= 'http://api.alquran.cloud/v1/quran/';


  /// luggage
  static const String getLuggage = '$baseUrl/PilgrimLuggage';
  static const String addLuggage = '$baseUrl/PilgrimLuggage';

  /// arrival
  static const String getArrivalPilgrims =
      '$baseUrl/pilgrims/GetPilgrimArrival';
  static const String updateArrivalPilgrims =
      '$baseUrl/pilgrims/UpdatePilgrimArrival';

  /// groups
  static const String allGroups = '$baseUrl/groups/GetAllPilgrimGroups';
  static const String groupInfo = '$baseUrl/groups/GetGroupInfo';

  /// activities
  static const String activities = '$baseUrl/activities';
  static const String startedActivities =
      '$baseUrl/activities/GetStartedActivities';
  static const String getSupervisorActivities =
      '/api/activities/GetSupervisorCurrentActivities';
  static const String getActivityPhases =
      '$baseUrl/activities/GetPhasesByActivity/';
  static const String getActivityById = '$baseUrl/activities/GetById/';
  static const String getAllPilgrimActivities =
      '$baseUrl/activities/GetPilgrimActivity';

  /// FAQ
  static const String getFAQ = '$baseUrl/FAQs/GetFAQs';

  /// Qrcode
  static const String getQRcode = '$baseUrl/pilgrims/GetQRCode';
  static const String getResidence =
      '$baseUrl/Residences/GetAllPilgrimsResidencies?residenceType=1';

  /// pilgrims
  // static const String fetchItems = '$baseUrl/items';
  // static const String fetchItemDetails = '$baseUrl/items/details';

  /// notification
  static const String getAllNotificaion =
      '$baseUrl/notifications/GetAllUserNotifications';
  static const String getTodayNotificaion =
      '$baseUrl/notifications/GetTodayNotifications';
  static const String getCountUnreadedNotificaion =
      '$baseUrl/notifications/GetCountUnReadNotificationsForUser';
  static const String markAllNotificaion =
      '$baseUrl/notifications/MarkAllAsReadForUser';
  static const String currentEvent = '$baseUrl/activities/GetCurrentEvents';

  ///meals
  static const String getAllTodayMeals =
      '$baseUrl/meals/GetAllPilgrimTodayMeals';

  /// feedback
  static const String sendFeedback = '$baseUrl/feedbacks/CreateFeedback';
  static const String getFeedbackByActivity =
      '$baseUrl/feedbacks/ByActivity/'; //+{id}
  // https://api-tea.ejad-dev.com:444/api/feedbacks/ByActivity/5e859cb8-7918-4c32-083a-08dce325abe5
  /// groups
  static const String getAllGroups = '$baseUrl/groups/GetAllPilgrimGroups';

  /// urls for maps
  static const String searchPlace =
      'https://nominatim.openstreetmap.org/search?format=json&q=';
  static const String reverseGeocoding =
      'https://nominatim.openstreetmap.org/reverse?format=json&';

  /// requests
  static const String getRequests =
      '$baseUrl/ServiceRequests/GetAllServiceRequestByPilgramId?pilgramId=';
  static const String createRequest = '$baseUrl/ServiceRequests';

  // https://api-tea.ejad-dev.com:444/api/ServiceRequests/GetAllServiceRequestByPilgramId?pilgramId?4dd170b0-8f88-4390-9af9-00121e8ecd8d&statusId=1
  /// others
  static const String deleteAccount = '$baseUrl/users/delete-self';
  static const String privacyPolicy =
      "https://sites.google.com/view/ejaad-tea-by-eng-amr-alaa/home";
  static const String taskUniqueName = "azan-daily-update";
  static const String taskInitUniqueName = "azan-one-time-scheduler";
  static const String taskName = "azanBackgroundTask";
  static const String taskInistialName = "azanBackgroundTaskforInitialTime";
}
