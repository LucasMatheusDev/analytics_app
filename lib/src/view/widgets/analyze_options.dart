import 'package:analytics_app/src/analytics_app_manager.dart';
import 'package:analytics_app/src/view/widgets/floating_analytics_options.dart';
import 'package:flutter/material.dart';

class AnalyzeOptionsWidget extends StatelessWidget {
  final AnalyticsAppManager analyticsApp;
  const AnalyzeOptionsWidget({
    super.key,
    required this.analyticsApp,
  });

  @override
  Widget build(BuildContext context) {
    final hasContext = analyticsApp.currentContext != null;
    final isVisibilityFloatingOptions = ValueNotifier<bool>(false);

    void updateIsEnableButton() {
      isVisibilityFloatingOptions.value =
          hasContext && !isVisibilityFloatingOptions.value;
    }

    return Column(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: FloatingActionButton(
            heroTag: DateTime.now().toString(),
            backgroundColor: Theme.of(context).primaryColor.withOpacity(0.5),
            onPressed: updateIsEnableButton,
            child: const Icon(Icons.arrow_drop_down_outlined, size: 40),
          ),
        ),
        const Spacer(),
        Align(
          alignment: Alignment.centerRight,
          child: ValueListenableBuilder(
            valueListenable: isVisibilityFloatingOptions,
            builder: (context, value, child) => Visibility(
              visible: value,
              child: FloatingAnalyticsOptions(
                analyticsApp: analyticsApp,
                onSelectedOption: () {
                  updateIsEnableButton();
                },
              ),
            ),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
