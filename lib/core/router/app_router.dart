import 'package:flutter/material.dart';
import 'package:kgk/feature/onboarding/presentation/pages/dashboard_page.dart';
import 'package:kgk/feature/onboarding/presentation/pages/splash_page.dart';
import 'package:kgk/feature/products/presentation/pages/filter_result_page.dart';

// declare all the paths that we need to use in the application.
enum AppRouterPaths {
  root(path: "/"),
  splash(path: "/splash"),

  dashboard(path: "/dashboard"),

  filterResult(path: "/filterResult");

  const AppRouterPaths({required this.path});

  final String path;
}

class AppRouter {
  static Route<dynamic>? onGenerate(RouteSettings settings) {
    return _matchPath(settings.name ?? "/");
  }

  // match the path with declared path and return the Route Accordingly.
  static Route<dynamic> _matchPath(String pathString) {
    AppRouterPaths path =
        AppRouterPaths.values.firstWhere((p) => p.path == pathString);

    switch (path) {
      case (AppRouterPaths.root || AppRouterPaths.splash):
        return MaterialPageRoute(
          builder: (_) => SplashPage(),
        );

      case AppRouterPaths.dashboard:
        return MaterialPageRoute(
          builder: (_) => DashboardPage(),
        );

      case AppRouterPaths.filterResult:
        return MaterialPageRoute(
          builder: (_) => FilterResultPage(),
        );
    }
  }
}
