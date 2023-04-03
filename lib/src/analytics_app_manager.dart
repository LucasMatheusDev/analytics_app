import 'package:analytics_app/src/material_app_resources.dart';
import 'package:analytics_app/src/mock_data_source.dart';
import 'package:analytics_app/src/navigator/analytics_navigator_observer.dart';
import 'package:flutter/cupertino.dart';

class AnalyticsAppManager {
  final navigatorObserver = AnalyticsNavigatorObserver();

  final navigatorKey = GlobalKey<NavigatorState>();

  final materialAppResources = MaterialAppResources();

  String? get currentPageName {
    return navigatorObserver.currentPageName;
  }

  BuildContext? get currentContext {
    final navigator = navigatorKey.currentState;
    return navigator?.overlay?.context;
  }

  List<MockDataSource> findMocksByHistory() {
    try {
      if (currentPageName != null) {
        final historyMockDataSource =
            MockDataSource.instancesReady[currentPageName!];
        if (historyMockDataSource != null) {
          return [historyMockDataSource];
        }
      }
      return [];
    } catch (e) {
      return [];
    }
  }
}
