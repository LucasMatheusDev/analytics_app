import 'package:flutter/material.dart';

class AnalyticsNavigatorObserver extends NavigatorObserver {
  static String? lastRouteName;

  String? get currentPageName => lastRouteName;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);

    if (route is MaterialPageRoute) {
      lastRouteName = route.settings.name;
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);

    if (route is MaterialPageRoute) {
      lastRouteName = previousRoute?.settings.name;
    }
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);

    if (route is MaterialPageRoute) {
      lastRouteName = route.settings.name;
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);

    if (newRoute is MaterialPageRoute) {
      lastRouteName = newRoute.settings.name;
    }
  }
}
