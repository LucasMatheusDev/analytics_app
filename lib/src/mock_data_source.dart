import 'package:analytics_app/src/models/analytics_request.dart';
import 'package:analytics_app/src/models/possible_answer.dart';

abstract class MockDataSource {
  static PossibleAnswer? selectedAnswer;

  static List<AnalyticsRequest> historyRequests = [];

  PossibleAnswer? get returnSelected => selectedAnswer;

  List<PossibleAnswer> get possibleAnswers;

  static Map<String, MockDataSource> instancesReady = {};

  void selectAnswer(PossibleAnswer answer) {
    selectedAnswer = answer;
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
    selectedAnswer = null;
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
