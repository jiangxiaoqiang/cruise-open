class HttpResult {
  String message;
  Result result;

  HttpResult({
    this.message,
    this.result,
  });
}

enum Result {
  ok,
  error,
}