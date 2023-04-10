import 'package:analytics_app/src/models/analytics_request.dart';
import 'package:analytics_app/src/models/possible_answer.dart';

abstract class MockDataSource {
  /// Last choice selected by user
  static PossibleAnswer? _selectedAnswer;

  /// History of requests made
  static List<AnalyticsRequest> historyRequests = [];

  /// Last choice selected by user
  PossibleAnswer? get returnSelected => _selectedAnswer;

  /// List of possible returns for the data source
  List<PossibleAnswer> get possibleAnswers;

  /// List of MockDataSources instances ready
  static Map<String, MockDataSource> instancesReady = {};

  /// Select an answer and save it in the static variable
  void selectAnswer(PossibleAnswer answer) {
    _selectedAnswer = answer;
  }

  /// Current page route name
  final String routeName;

  /// Friendly name for data source recognition
  final String friendlyName;

  MockDataSource({
    required this.routeName,
    required this.friendlyName,
  }) {
    assert(
      possibleAnswers.map((e) => e.id).toSet().length == possibleAnswers.length,
      'The possible answers must have unique ids',
    );
    instancesReady[routeName] = this;
  }

  /// Reset the selected answer
  void resetAnswer() {
    _selectedAnswer = null;
  }

  /// Register a request in the history
  void registerRequest({
    required String request,
    required String response,
    String? name,
    String? url,
  }) {
    historyRequests.add(AnalyticsRequest(
      request: request,
      response: response,
      name: name,
      url: url,
    ));
  }
}
