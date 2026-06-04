import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shaoni/core/local_storage/local_storage.dart';
import 'package:shaoni/core/local_storage/storage_keys.dart';
import '../../core/routing/route_names.dart';
import '../../core/routing/routes.dart';
import '../../core/service_locator/service_locator.dart';
import '../../core/theme/theme.dart';
import '../../generated/l10n.dart';
import '../language/presentation/controller/language_cubit.dart';

class ShaoniApp extends StatelessWidget {
  const ShaoniApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LanguageCubit>(
          create: (context) => serviceLocator<LanguageCubit>(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          final controller = context.read<LanguageCubit>();
          final storage = serviceLocator<LocalStorage>();
          final cachedLang = storage.getString(key: StorageKeys.lang.name) ??
              storage.cachedLanguage;
          controller.currentLanguage = Locale(cachedLang);
          return BlocBuilder<LanguageCubit, LanguageState>(
            buildWhen: (previous, current) => previous != current,
            builder: (context, state) {
              return MaterialApp(
                onGenerateRoute: RouteGenerator.generateRoute,
                initialRoute: DRoutesName.splashSRoute,
                title: "shaoni",
                debugShowCheckedModeBanner: false,
                themeMode: ThemeMode.light,
                theme: DAppTheme.lightTheme(context),
                localeListResolutionCallback: (locales, supportedLocales) {
                  return controller.currentLanguage;
                },
                supportedLocales: [
                  Locale('en'), // English
                  Locale('ar'), // Arabic
                ],
                locale: controller.currentLanguage,
                localizationsDelegates: [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
              );
            },
          );
        },
      ),
    );
  }
}
