import 'package:analytics_app/src/analytics_flutter_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HistoryErrors extends StatefulWidget {
  final AnalyticsFlutterError analyticsFlutterError;
  const HistoryErrors({
    super.key,
    required this.analyticsFlutterError,
  });

  @override
  State<HistoryErrors> createState() => _HistoryErrorsState();
}

class _HistoryErrorsState extends State<HistoryErrors> {
  ErrorType filterErrorType = ErrorType.genericError;

  @override
  Widget build(BuildContext context) {
    final errors = widget.analyticsFlutterError.errors
        .where(
          (element) => filterErrorType == ErrorType.genericError
              ? true
              : element.errorType == filterErrorType,
        )
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Errors'),
        actions: [
          PopupMenuButton<ErrorType>(
            onSelected: (value) {
              setState(() {
                filterErrorType = value;
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: ErrorType.genericError,
                child: Text('All'),
              ),
              const PopupMenuItem(
                value: ErrorType.flutterError,
                child: Text('FlutterError'),
              ),
              const PopupMenuItem(
                value: ErrorType.errorWidget,
                child: Text('ErrorWidget'),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text('Errors'),
              const SizedBox(
                height: 10,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: errors.length,
                itemBuilder: (context, index) {
                  final error = errors[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 10,
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(error.details.exceptionAsString()),
                          subtitle: Text(error.details.stack.toString()),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ErrorDetailsPage(
                                  error: error,
                                ),
                              ),
                            );
                          },
                        ),
                        const Divider(
                          height: 10,
                          thickness: 1,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ErrorDetailsPage extends StatelessWidget {
  final CustomFlutterError error;
  const ErrorDetailsPage({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Error details - ${error.errorType.name}',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Stack: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Stack: ${error.details.stack.toString()}'),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Context: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Context: ${error.details.context}'),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'InformationCollector: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                error.details.informationCollector
                        ?.call()
                        .map((e) => '${e.toString()} \n')
                        .join(' ') ??
                    '',
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Library: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Library: ${error.details.library}'),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Silent: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Silent: ${error.details.silent}'),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Summary: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Summary: ${error.details.summary}'),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Exception: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Exception: ${error.details.exceptionAsString()}',
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.copy),
        onPressed: () async {
          final scaffoldMessenger = ScaffoldMessenger.of(context);
          try {
            await Clipboard.setData(
              ClipboardData(
                text: error.toString(),
              ),
            );

            scaffoldMessenger.showSnackBar(
              const SnackBar(
                content: Text('Copied to clipboard'),
              ),
            );
          } catch (e) {
            AnalyticsFlutterError.addError(
              CustomFlutterError(
                errorType: ErrorType.genericError,
                details: FlutterErrorDetails(
                  exception: e,
                  stack: StackTrace.current,
                ),
              ),
            );
            scaffoldMessenger.showSnackBar(
              const SnackBar(
                content: Text('Error copying to clipboard'),
              ),
            );
          }
        },
      ),
    );
  }
}
