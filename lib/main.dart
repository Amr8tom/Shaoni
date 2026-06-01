import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/device/device_utility.dart';
import 'core/service_locator/service_locator.dart';
import 'core/utils/helpers/bloc_oberver.dart';
import 'core/utils/helpers/permissions_services.dart';
import 'features/app/app.dart';
import 'features/language/presentation/controller/language_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await ScreenUtil.ensureScreenSize();
  await DDeviceUtils.initCacheHelper();
  await DI.execute();
  await serviceLocator<LanguageCubit>().init();
  Bloc.observer = MyBlocObserver();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  /// Remote notifications from Firebase Cloud Messaging
  await messaging.requestPermission(alert: true, badge: true, sound: true);
  /// Local notifications from flutter_local_notifications
  await PermissionsService.notifications();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  runApp(const ShaoniApp());
}
