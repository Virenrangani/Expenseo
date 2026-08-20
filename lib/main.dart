import 'package:expenseo/di/injection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'core/security/logic/security_cubit.dart';
import 'core/security/presentation/widget/security_gate.dart';
import 'core/security/presentation/widget/security_lifecycle_wrapper.dart';
import 'core/storage/shared_pref/shared_pref_service.dart';
import 'core/utils/quick_action_service.dart';
import 'features/auth/presentation/page/splash_screen.dart';
import 'firebase_options.dart';

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
      ],
      child: MaterialApp(
        title: 'Expenseo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        navigatorKey: appNavigatorKey,
        // PRODUCTION SECURITY WRAPPER
        home: const SecurityLifecycleWrapper(
          child: SecurityGate(child: AuthGate()),
        ),
      ),
    );
  }
}
