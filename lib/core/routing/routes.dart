import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shaoni/core/routing/route_names.dart';
import 'package:shaoni/features/study&training/presentaion/study/create_study_request_form.dart';
import 'package:shaoni/features/human_resoures/presentation/start_work/create_start_work_form.dart';
import 'package:shaoni/features/human_resoures/presentation/experience_certificate/create_experience_certificate_form.dart';
import 'package:shaoni/features/human_resoures/presentation/id_document/create_id_document_form.dart';
import 'package:shaoni/features/human_resoures/presentation/medical_insurance/create_medical_insurance_form.dart';
import 'package:shaoni/features/study&training/presentaion/training_request/create_training_request_form.dart';
import 'package:shaoni/features/human_resoures/presentation/product_order/create_product_order_form.dart';
import 'package:shaoni/features/human_resoures/presentation/outside_working/create_outside_working_form.dart';
import 'package:shaoni/features/profile/profile_screen.dart';
import 'package:shaoni/features/services/presentation/screens/category_details_screen.dart';
import '../../features/auth/presentation/screen/login_screen.dart';
import '../../features/auth/presentation/screen/new_password_screen.dart';
import '../../features/auth/presentation/screen/otp_screen.dart';
import '../../features/delete_account/presentation/delete_my_account_screen.dart';
import '../../features/human_resoures/presentation/attendance/create_attendance_request_form.dart';
import '../../features/human_resoures/presentation/car_permission/create_car_permission_screen.dart';
import '../../features/human_resoures/presentation/complaint_request/create_complaint_request_screen.dart';
import '../../features/human_resoures/presentation/attendance/missing_attendance_history_screen.dart';
import '../../features/human_resoures/presentation/exit/create_exit_request_form.dart';
import '../../features/human_resoures/presentation/screens/faq_information.dart';
import '../../features/details_and_edit_for_requests/presentation/screens/request_details_screen.dart';
import '../../features/navigation/presentation/screens/navigation_menu_screen.dart';
import '../../features/notifications/presentation/notification_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/services/presentation/no_data_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../../features/terms_conditions/presentation/terms_conditions_screen.dart';

class RouteGenerator {
  /// generate Route

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      /// navigation
      case DRoutesName.navigationMenuRoute:
        return PageTransition(
          child: NavigationMenuScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );

      /// splash Screen
      case DRoutesName.splashSRoute:
        return PageTransition(
          child: const SplashScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );

      /// onboarding Screen
      case DRoutesName.onBoardingRoute:
        return PageTransition(
          child: const OnboardingScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );

      /// notification Screen
      case DRoutesName.notificationsRoute:
        return PageTransition(
          child: const NotificationScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );



      /// show  category service details Screen
      case DRoutesName.categoryDetailsRoute:
        final args = settings.arguments as Map<String, dynamic>;
        return PageTransition(
          child:  CategoryDetailsScreen(title: args['title'], services: args['services'] ?? []),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );

      /// faq information Screen
      case DRoutesName.requestCertainService:
        return PageTransition(
          child: const FAQInformation(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );

      /// show all attendance requests Screen
      case DRoutesName.missingAttendanceHistory:
        return PageTransition(
          child: const MissingAttendanceHistoryScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      ///  request create details screen (create or edit)
      case DRoutesName.requestCreateDetails:
        final args = settings.arguments as Map<String, dynamic>?;
        final int? requestId = args?['requestId'] as int?;
        return PageTransition(
          child: ExitRequestDetailsScreen(requestId: requestId),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
     /// create start work request screen
      case DRoutesName.createStartWorkRoute:
        final args = settings.arguments as Map<String, dynamic>?;
        final int? requestId = args?['requestId'] as int?;
        return PageTransition(
          child: CreateStartWorkForm(requestId: requestId),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );

     /// create / edit ID document screen
      case DRoutesName.createIDDocumentRoute:
        final args = settings.arguments as Map<String, dynamic>?;
        final int? requestId = args?['requestId'] as int?;
        return PageTransition(
          child: CreateIDDocumentForm(requestId: requestId),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );

     /// create / edit training request screen
      case DRoutesName.createTrainingRequestRoute:
        final args = settings.arguments as Map<String, dynamic>?;
        final int? requestId = args?['requestId'] as int?;
        return PageTransition(
          child: CreateTrainingRequestForm(requestId: requestId),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );

     /// create / edit product order screen
      case DRoutesName.createProductOrderRoute:
        final args = settings.arguments as Map<String, dynamic>?;
        final int? requestId = args?['requestId'] as int?;
        return PageTransition(
          child: CreateProductOrderForm(requestId: requestId),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );

     /// create / edit outside working screen
      case DRoutesName.createOutsideWorkingRoute:
        final args = settings.arguments as Map<String, dynamic>?;
        final int? requestId = args?['requestId'] as int?;
        return PageTransition(
          child: CreateOutsideWorkingForm(requestId: requestId),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );

     /// create / edit medical insurance screen
      case DRoutesName.createMedicalInsuranceRoute:
        final args = settings.arguments as Map<String, dynamic>?;
        final int? requestId = args?['requestId'] as int?;
        return PageTransition(
          child: CreateMedicalInsuranceForm(requestId: requestId),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );

     /// create / edit experience certificate screen
      case DRoutesName.createExperienceCertificateRoute:
        final args = settings.arguments as Map<String, dynamic>?;
        final int? requestId = args?['requestId'] as int?;
        return PageTransition(
          child: CreateExperienceCertificateForm(requestId: requestId),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );

     /// create study request screen
      case DRoutesName.createStudyRequestRoute:
        final args = settings.arguments as Map<String, dynamic>?;
        final int? requestId = args?['requestId'] as int?;
        return PageTransition(
          child: CreateStudyRequestForm(requestId: requestId),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );

     /// create / edit car permission request screen
      case DRoutesName.createCarPermissionRoute:
        final args = settings.arguments as Map<String, dynamic>?;
        final int? requestId = args?['requestId'] as int?;
        return PageTransition(
          child: CreateCarPermissionScreen(requestId: requestId),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );

      /// create complaint request screen
      case DRoutesName.createComplaintRequestRoute:
        return PageTransition(
          child: const CreateComplaintRequestScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );

      // /// juz screen
      // case DRoutesName.juzRoute:
      //   return PageTransition(
      //     child: const JuzScreen(),
      //     type: PageTransitionType.rightToLeft,
      //     settings: settings,
      //   );
      //   /// Page Screen
      // case DRoutesName.pageRoute:
      //   final Map<String, dynamic> args =
      //   settings.arguments as Map<String, dynamic>;
      //   return PageTransition(
      //     child: PageScreen(
      //       juz: args['juz'],
      //     ),
      //     type: PageTransitionType.rightToLeft,
      //     settings: settings,
      //   );
      // /// qibla  Screen
      // case DRoutesName.qiblaRoute:
      //   return PageTransition(
      //     child: const QiblaScreen(),
      //     type: PageTransitionType.rightToLeft,
      //     settings: settings,
      //   );
      //
      // /// Residence Location Screen
      // case DRoutesName.residenceLocationRoute:
      //   return PageTransition(
      //     child: const ResidencesScreen(),
      //     type: PageTransitionType.rightToLeft,
      //     settings: settings,
      //   );
      //
      // /// specific groups Screen
      // case DRoutesName.groupDetailsRoute:
      //   final Map<String, dynamic> args =
      //       settings.arguments as Map<String, dynamic>;
      //   return PageTransition(
      //     child: GroupDetailsScreen(
      //       title: args["title"],
      //       supervisorName: args["supervisorName"],
      //       activities: args["activities"] ?? [],
      //     ),
      //     type: PageTransitionType.rightToLeft,
      //     settings: settings,
      //   );
      //
      // /// specific groups Screen
      // case DRoutesName.activityPhasesRoute:
      //   final Map<String, dynamic> args =
      //       settings.arguments as Map<String, dynamic>;
      //   return PageTransition(
      //     child: ActivityScreen(
      //       title: args["title"],
      //       activityId: args["activityId"],
      //     ),
      //     type: PageTransitionType.rightToLeft,
      //     settings: settings,
      //   );
      //
      /// login Screen
      case DRoutesName.loginRoute:
        return PageTransition(
          child: const LoginScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      //
      // /// verify account Screen
      // case DRoutesName.verifyAccountRoute:
      //   return PageTransition(
      //     child: const VerifiedAccountScreen(),
      //     type: PageTransitionType.rightToLeft,
      //     settings: settings,
      //   );
      //
      // /// add new email Screen
      // case DRoutesName.addNewEmailRoute:
      //   return PageTransition(
      //     child: const AddNewEmailScreen(),
      //     type: PageTransitionType.rightToLeft,
      //     settings: settings,
      //   );
      //
      /// add new password Screen
      case DRoutesName.addNewPasswordRoute:
        return PageTransition(
          child: const NewPasswordScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      //
      /// OTP verification Screen
      case DRoutesName.OTPRoute:
        return PageTransition(
          child: const OtpScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );

      /// OTP verification Screen
      case DRoutesName.profileRoute:
        return PageTransition(
          child: const ProfileScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );

      /// no data
      case DRoutesName.noDataRoute:
        return PageTransition(
          child: const NoDataScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      //
      // /// request Screen
      // case DRoutesName.requestRoutes:
      //   final Map<String, dynamic> args =
      //       settings.arguments as Map<String, dynamic>;
      //   return PageTransition(
      //     child: RequestsScreen(pilgrimId: args["requestId"]),
      //     type: PageTransitionType.rightToLeft,
      //     settings: settings,
      //   );
      //
      /// order details  Screen
      case DRoutesName.requestDetailsRoute:
        return PageTransition(
          child: const RequestDetailsScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );

      // /// feedBack Screen
      // case DRoutesName.feedbackRoute:
      //   final Map<String, dynamic> args =
      //       settings.arguments as Map<String, dynamic>;
      //   return PageTransition(
      //     child: FeedbackScreen(previousActivities: args["previousActivity"]),
      //     type: PageTransitionType.rightToLeft,
      //     settings: settings,
      //   );
      //
      // /// FAQ Screen
      // case DRoutesName.FAQRoute:
      //   return PageTransition(
      //     child: const FaqScreen(),
      //     type: PageTransitionType.rightToLeft,
      //     settings: settings,
      //   );
      //
      // /// request details  Screen
      // case DRoutesName.requestDetailsRoutes:
      //   final Map<String, dynamic> args =
      //       settings.arguments as Map<String, dynamic>;
      //   return PageTransition(
      //     child: RequestDetailsScreen(
      //       title: args["title"],
      //       date: args["date"],
      //       status: args["status"],
      //       category: args["category"],
      //       description: args["description"] ?? "",
      //       supervisor_Reply: args["supervisor_Reply"] ?? "",
      //     ),
      //     type: PageTransitionType.rightToLeft,
      //     settings: settings,
      //   );
      //
      // /// new request  Screen
      // case DRoutesName.addNewRequestRoutes:
      //   return PageTransition(
      //     child: const SupportScreen(),
      //     type: PageTransitionType.rightToLeft,
      //     settings: settings,
      //   );
      //
      /// delete account Screen
      case DRoutesName.deleteAccountRoute:
        return PageTransition(
          child: const DeleteMyAccountScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );

      // // class MapLocationScreen extends StatelessWidget {
      // // final double latitude;
      // // final double longitude;
      // // final String name, type, description;
      // //
      // // const MapLocationScreen({
      // // super.key,
      // // required this.name,
      // // required this.type,
      // // required this.description,
      // // required this.latitude,
      // // required this.longitude,
      // // });
      //
      // /// map
      // case DRoutesName.mapRoute:
      //   final Map<String, dynamic> arg =
      //       settings.arguments as Map<String, dynamic>;
      //   return PageTransition(
      //     child: MapLocationScreen(
      //       name: arg['name'] ?? '',
      //       type: arg['type'] ?? '',
      //       description: arg['des'] ?? '',
      //       latitude: arg['lat'] ?? 0.0,
      //       longitude: arg['lng'] ?? 0.0,
      //       screenTitle: arg['screenTitle'],
      //     ),
      //     type: PageTransitionType.rightToLeft,
      //     settings: settings,
      //   );
      //
      /// terms and conditions Route
      case DRoutesName.termsAndConditionRoute:
        return PageTransition(
          child: TermsConditionsScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );

      /// settings Route
      case DRoutesName.settingsRoute:
        return PageTransition(
          child: const SettingsScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
  /// create / edit attendance Route
      case DRoutesName.createAttendanceRoute:
        final Map<String, dynamic> args =
            settings.arguments as Map<String, dynamic>;
        return PageTransition(
          child: CreateAttendanceRequestForm(
            attendanceID: args['attendanceID'] ?? '',
            requestId: args['requestId'] as int?,
          ),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );

      /// when no routes
      default:
        return unDefinedRoute();
    }
  }

  /// Un Defined Route
  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: Text('unImplemented screen')),
        body: Center(child: const Text('404 not found ')),
      ),
    );
  }
}
