class HttpResult {
  String message;
  Result result;

  HttpResult({
    required this.message,
    required this.result,
  });
}

enum Result {
  ok,
  error,
}