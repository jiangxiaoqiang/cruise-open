
enum ResponseStatus {
  NOT_LOGIN,
  LOGIN_INVALID,
  ACCESS_TOKEN_EXPIRED,
  REFRESH_TOKEN_EXPIRED
}

extension ResponseStatusExtension on ResponseStatus{
  static const statusCodes = {
    ResponseStatus.NOT_LOGIN: "907",
    ResponseStatus.LOGIN_INVALID: "904",
    ResponseStatus.ACCESS_TOKEN_EXPIRED: "00100100004016",
    ResponseStatus.REFRESH_TOKEN_EXPIRED: "00100100004017"
  };

  String get statusCode => statusCodes[this]!;
}