import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weather/app+injection/di.dart';
import 'package:weather/presentation/hom_flow/screens/home_page.dart';
import 'package:weather/presentation/hom_flow/screens/weather_home.dart';
import 'package:weather/presentation/hom_flow/widgets/weather_setting.dart';
import 'package:weather/presentation/hom_flow/widgets/weather_widget.dart';
import 'package:weather/presentation/startup_flow/screens/splash_screen.dart';

import '../../presentation/hom_flow/widgets/weather_location.dart';
import '../blocs/application_bloc/app_bloc.dart';
import '../mediators/communication_types/AppStatus.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final sectionNavigatorKey = GlobalKey<NavigatorState>();

class RoutesPath {
  static String get splashScreen => '/';

  static String get startup => '/startup';

  static String get getStarted => '$startup/get-started';

  static String get login => '$getStarted/login';

  static String get homePage => '/weather';

  static String get location => '/location';

  static String get setting => '/setting';
}

final router = GoRouter(
  debugLogDiagnostics: true,
  navigatorKey: rootNavigatorKey,
  routes: routes,
  initialLocation: RoutesPath.splashScreen,
  refreshListenable: GoRouterRefreshStream(locator<AppBloc>().stream),
  redirect: (context, state) {
    final appState = locator<AppBloc>().state;

    // If unauthorized and not already on startup/getStarted path, redirect to getStarted
    // if (appState.appStatus == Status.unauthorized &&
    //     !state.location.startsWith(RoutesPath.startup) &&
    //     !state.location.startsWith(RoutesPath.getStarted)) {
    //   return RoutesPath.getStarted;
    // }
    return null;
  },
);

final List<RouteBase> routes = [
  GoRoute(
    parentNavigatorKey: rootNavigatorKey,
    name: "splash",
    path: "/",
    builder: (context, state) {
      return const SplashPage();
    },
  ),
  ShellRoute(
    navigatorKey: sectionNavigatorKey,
    builder: (context, state, child) {
      return HomePage(
        navigationShell: child,
      );
    },
    routes: [
      GoRoute(
        path: '/weather',
        builder: (context, state) {
          return const WeatherWidget();
        },
      ),
      GoRoute(
        path: '/location',
        builder: (context, state) {
          return const WeatherLocation();
        },
      ),
      GoRoute(
        path: '/setting',
        builder: (context, state) {
          return const WeatherSetting();
        },
      ),
    ],
  ),
];

class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription<Status> _subscription;

  GoRouterRefreshStream(Stream<AppState> stream) {
    notifyListeners();
    _subscription = stream
        .asBroadcastStream()
        .map((AppState event) => event.appStatus)
        .listen((_) => notifyListeners());
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
