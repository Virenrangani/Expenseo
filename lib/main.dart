import 'package:expenseo/core/localization/locale_cubit.dart';
import 'package:expenseo/di/injection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'core/security/logic/security_cubit.dart';
import 'core/storage/shared_pref/shared_pref_service.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/logic/theme_cubit.dart';
import 'core/utils/quick_action_service.dart';
import 'features/auth/presentation/page/splash_screen.dart';
import 'firebase_options.dart';
import 'l10n/app_localizations.dart';

final GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await SharedPrefService.init();

  Injection().configDependency();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    QuickActionService.init();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SecurityCubit>(
          create: (context) => GetIt.I<SecurityCubit>()..init(),
        ),
        BlocProvider<LocaleCubit>(create: (context) => LocaleCubit()),
      ],
      child: BlocBuilder<LocaleCubit, Locale>(
        builder: (context, locale) {
          return BlocProvider<ThemeCubit>(
            create: (context) => GetIt.I<ThemeCubit>()..loadTheme(),
            child: BlocBuilder<ThemeCubit, ThemeMode>(
              builder: (context, themeMode) {
                return MaterialApp(
                  title: 'Expenseo',
                  debugShowCheckedModeBanner: false,
                  theme: AppTheme.lightTheme,
                  darkTheme: AppTheme.darkTheme,
                  themeMode: themeMode,
                  navigatorKey: appNavigatorKey,
                  locale: locale,
                  localizationsDelegates:
                      AppLocalizations.localizationsDelegates,
                  supportedLocales: AppLocalizations.supportedLocales,
                  home: const AuthGate(),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
