
enum ResponseStatus {
  NOT_LOGIN,
  LOGIN_INVALID,
}

extension ResponseStatusExtension on ResponseStatus{
  static const statusCodes = {
    ResponseStatus.NOT_LOGIN: "907",
    ResponseStatus.LOGIN_INVALID: "904",
  };

  String get statusCode => statusCodes[this]!;
}