import 'package:flutter/material.dart';

class AnalyticsFlutterError {
  static final List<CustomFlutterError> _errors = [];

  List<CustomFlutterError> get errors => _errors;

  static void addError(CustomFlutterError error) {
    _errors.add(
      error,
    );
  }

  void initListenerFlutterError() {
    FlutterError.onError = (FlutterErrorDetails details) {
      _errors.add(
        CustomFlutterError(
          errorType: ErrorType.flutterError,
          details: details,
        ),
      );
    };

    ErrorWidget.builder = (FlutterErrorDetails details) {
      _errors.add(
        CustomFlutterError(
          errorType: ErrorType.errorWidget,
          details: details,
        ),
      );
      return Container();
    };
  }
}

enum ErrorType {
  /// The error is a [FlutterError] error.
  flutterError('Flutter Error'),

  /// The error is a [GenericError] error.
  genericError('Generic Error'),

  /// The error is a [ErrorWidget] error.
  errorWidget('Flutter Error Widget'),
  ;

  final String name;

  const ErrorType(this.name);
}

class CustomFlutterError {
  final ErrorType errorType;
  final FlutterErrorDetails details;
  CustomFlutterError({
    required this.errorType,
    required this.details,
  });

  @override
  String toString() {
    return 'CustomFlutterError{errorType: $errorType, \n '
        'Stack: ${details.stack}, \n '
        'Exception: ${details.exception}, \n '
        'Library: ${details.library}, \n '
        'Context: ${details.context}, \n '
        'InformationCollector: ${details.informationCollector?.call().map((e) => '${e.toString()} \n').join(' ') ?? ''}, \n '
        'Silent: ${details.silent}, \n '
        'Summary: ${details.summary}, \n '
        '}';
  }
}
