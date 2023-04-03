import 'package:analytics_app/src/models/analytics_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomDialogHistoryRequest extends StatelessWidget {
  final AnalyticsRequest historyRequest;
  const CustomDialogHistoryRequest({
    super.key,
    required this.historyRequest,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(historyRequest.name ?? 'No name'),
            const SizedBox(
              height: 5,
            ),
            Text(historyRequest.date, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Request:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Flexible(child: Text(historyRequest.request)),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Response:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Flexible(
              child: Text(historyRequest.response),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.copy),
        onPressed: () async {
          final scaffoldMessenger = ScaffoldMessenger.of(context);
          await Clipboard.setData(
            ClipboardData(
              text: historyRequest.toString(),
            ),
          );
          if (scaffoldMessenger.mounted) {
            scaffoldMessenger.showSnackBar(
              const SnackBar(
                content: Text('Copied to clipboard'),
              ),
            );
          }
        },
      ),
    );
  }
}
