
enum ResponseStatus {
  NOT_LOGIN,
}

extension ResponseStatusExtension on ResponseStatus{
  static const statusCodes = {
    ResponseStatus.NOT_LOGIN: "904",
  };

  String get statusCode => statusCodes[this];
}