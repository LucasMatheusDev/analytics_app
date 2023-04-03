import 'package:analytics_app/src/analytics_app_manager.dart';
import 'package:analytics_app/src/view/widgets/analyze_options.dart';
import 'package:flutter/material.dart';

class AnalyticsApp extends StatelessWidget {
  final bool isActivateAnalytics;
  final Widget Function(NavigatorObserver observer) materialApp;
  const AnalyticsApp({
    super.key,
    required this.materialApp,
    this.isActivateAnalytics = false,
  });

  @override
  Widget build(BuildContext context) {
    final AnalyticsAppManager analyticsApp = AnalyticsAppManager();
    if (!isActivateAnalytics) {
      return materialApp(analyticsApp.navigatorObserver);
    } else {
      final materialResources = analyticsApp.materialAppResources;
      return AnimatedBuilder(
        animation: analyticsApp.materialAppResources,
        builder: (context, child) => MaterialApp(
          key: const Key('AnalyticsApp'),
          navigatorKey: analyticsApp.navigatorKey,
          debugShowMaterialGrid: materialResources.isOpenGrid,
          showPerformanceOverlay: materialResources.isShowPerformance,
          showSemanticsDebugger: materialResources.isShowPaint,
          checkerboardRasterCacheImages: materialResources.isRepaintRainbow,
          checkerboardOffscreenLayers: materialResources.isRepaintRainbow,
          debugShowCheckedModeBanner: materialResources.isShowBanner,
          home: Stack(
            children: [
              materialApp(analyticsApp.navigatorObserver),
              AnalyzeOptionsWidget(
                analyticsApp: analyticsApp,
              ),
            ],
          ),
        ),
      );
    }
  }
}
