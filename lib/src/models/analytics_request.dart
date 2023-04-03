
class AnalyticsRequest {
  final String request;
  final String response;
  final String? url;
  final String? name;
  late String date;

  AnalyticsRequest({
    required this.request,
    required this.response,
    this.url,
    this.name,
  }) {
    date = _getCurrentDateFormatted();
  }

  String _getCurrentDateFormatted() {
    final now = DateTime.now();
    return '${now.day}/${now.month}/${now.year} : ${now.hour}:${now.minute}:${now.second}';
  }

  @override
  String toString() {
    return 'HistoryRequest(request: $request, response: $response, url: $url, name: $name, date: $date)';
  }

  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) {
    return other == this;
  }

  @override
  // ignore: unnecessary_overrides
  int get hashCode => super.hashCode;
}
