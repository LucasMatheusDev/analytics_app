import 'package:analytics_app/src/models/analytics_request.dart';
import 'package:analytics_app/src/view/widgets/history_request_details_page.dart';
import 'package:flutter/material.dart';

class AnalyticsRequestPage extends StatelessWidget {
  final List<AnalyticsRequest> requests;
  const AnalyticsRequestPage({
    super.key,
    required this.requests,
  });

  @override
  Widget build(BuildContext context) {
    if (requests.isNotEmpty) {
      requests.sort((a, b) => b.date.compareTo(a.date));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('History Requests - Total ${requests.length}'),
      ),
      body: requests.isNotEmpty
          ? ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: requests.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      tileColor: index % 2 == 0
                          ? Theme.of(context).primaryColor.withOpacity(0.2)
                          : Theme.of(context)
                              .secondaryHeaderColor
                              .withOpacity(0.2),
                      title: Text(
                        '${requests[index].name ?? 'No name'} - index :${index + 1}',
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            requests[index].url ?? 'No url',
                          ),
                          Text(
                            requests[index].date,
                          ),
                        ],
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    CustomDialogHistoryRequest(
                              historyRequest: requests[index],
                            ),
                          ),
                        );
                      },
                    ),
                    const Divider(
                      height: 1,
                      thickness: 2,
                    )
                  ],
                );
              },
            )
          : const Center(
              child: Text('No history requests'),
            ),
    );
  }
}
