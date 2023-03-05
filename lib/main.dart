import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';
import './config/core_theme.dart' as theme;
import 'config/app_provider.dart';
import 'features/home/pages/home.dart';
import 'features/home/pages/menu.dart';
import 'features/onboarding/pages/onboarding.dart';
import 'features/stopwatch/pages/stopwatch_dashboard.dart';
import 'features/stopwatch/provider/stopwatch_provider.dart';
import 'features/stopwatch/provider/time_service_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final timerService = TimerService();
  runApp(
    TimerServiceProvider(
      /// Declare [timer service] globaly so it can be used any where in the app
      service: timerService,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => AppProvider())],
        child: Consumer<AppProvider>(
            builder: (context, value, _) => MaterialChild(provider: value)));
  }
}

/// This is an alternative approach to handle multiple state management: [Provider] + [another state management such as Bloc]
/// A new MaterialChild class will handle to [Provider] initialization as well as the [Shared Preferences]
/// [Theme] selection is managed by [Shared Preferences]
class MaterialChild extends StatefulWidget {
  final AppProvider provider;
  const MaterialChild({Key? key, required this.provider}) : super(key: key);

  @override
  State<MaterialChild> createState() => _MaterialChildState();
}

class _MaterialChildState extends State<MaterialChild> {
  /// Using GoRouter Package to handle the [Navigation] for the whole app
  /// This approach helps when configuring routes for Flutter Web as well
  final _router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const HomePage()),
      GoRoute(
          path: '/onboarding', builder: (context, state) => const Onboarding()),
      GoRoute(path: '/menu', builder: (context, state) => const Menu()),
      GoRoute(
          path: '/homestopwatch',
          builder: (context, state) => const HomeStopWatch()),
    ],
  );

  void initAppTheme() {
    final appProviders = AppProvider.state(context);
    appProviders.init();
  }

  @override
  void initState() {
    initAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// New Material App where the another [state management] can be handled
    return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: theme.themeLight,
        darkTheme: theme.themeDark,
        themeMode: widget.provider.themeMode,

        /// Using [Responsive] package to handle the UI resize for any device
        builder: (context, child) => ResponsiveWrapper.builder(
            BouncingScrollWrapper.builder(context, child!),
            maxWidth: 1200,
            minWidth: 480,
            defaultScale: true,
            breakpoints: [
              const ResponsiveBreakpoint.resize(480, name: MOBILE),
              const ResponsiveBreakpoint.autoScale(800, name: TABLET)
            ],
            background: Container(color: const Color(0xFFF5F5F5))),
        routerConfig: _router);
  }
}
