import 'package:analytics_app/src/analytics_app_manager.dart';
import 'package:analytics_app/src/mock_data_source.dart';
import 'package:analytics_app/src/view/widgets/custom_analytics_dialog.dart';
import 'package:analytics_app/src/view/widgets/custom_answer_dialog.dart';
import 'package:analytics_app/src/view/widgets/history_errors.dart';
import 'package:analytics_app/src/view/widgets/history_request_page.dart';
import 'package:flutter/material.dart';

class FloatingAnalyticsOptions extends StatelessWidget {
  final AnalyticsAppManager analyticsApp;
  final void Function()? onSelectedOption;
  const FloatingAnalyticsOptions({
    super.key,
    required this.analyticsApp,
    this.onSelectedOption,
  });

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    final minimumSize = MediaQuery.of(context).size.shortestSide;
    return Align(
      alignment: Alignment.centerRight,
      child: Material(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.all(5),
          constraints: BoxConstraints(
            maxWidth: 60,
            maxHeight: minimumSize * 0.5,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.8),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Scrollable(
            controller: scrollController,
            axisDirection: AxisDirection.down,
            viewportBuilder: (context, offset) {
              return SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      padding: const EdgeInsets.all(0),
                      icon: const Icon(Icons.analytics),
                      onPressed: () async {
                        onSelectedOption?.call();
                        await showDialog(
                          context: analyticsApp.currentContext!,
                          builder: (context) => CustomAnalyticsDialog(
                            materialAppResources:
                                analyticsApp.materialAppResources,
                          ),
                        );
                      },
                    ),
                    IconButton(
                      padding: const EdgeInsets.all(0),
                      icon: const Icon(Icons.data_object_outlined),
                      onPressed: () async {
                        final List<MockDataSource?> dataSources =
                            analyticsApp.findMocksByHistory();
                        onSelectedOption?.call();
                        await showDialog(
                          context: analyticsApp.currentContext!,
                          builder: (context) {
                            if (dataSources.isEmpty ||
                                dataSources.first == null) {
                              return const AlertDialog(
                                title: Text('No data sources'),
                              );
                            } else {
                              return CustomAnswerDialog(
                                onSelected: (a) => analyticsApp
                                    .materialAppResources
                                    .forceSetSate(),
                                dataSources: [
                                  ...dataSources.whereType<MockDataSource>()
                                ],
                              );
                            }
                          },
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.history),
                      padding: const EdgeInsets.all(0),
                      onPressed: () {
                        onSelectedOption?.call();
                        Navigator.push(
                          analyticsApp.currentContext!,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    AnalyticsRequestPage(
                              requests: MockDataSource.historyRequests,
                            ),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.bug_report),
                      padding: const EdgeInsets.all(0),
                      onPressed: () {
                        onSelectedOption?.call();
                        Navigator.push(
                          analyticsApp.currentContext!,
                          PageRouteBuilder(
                            pageBuilder: (__, _, ___) => HistoryErrors(
                              analyticsFlutterError:
                                  analyticsApp.analyticsFlutterError,
                            ),
                          ),
                        );
                      },
                    ),
                    // IconButton(
                    //   padding: const EdgeInsets.all(0),
                    //   onPressed: () {},
                    //   icon: const Icon(Icons.ads_click_outlined),
                    // ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
