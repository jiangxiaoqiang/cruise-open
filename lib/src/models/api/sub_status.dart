
enum SubStatus {
  SUB,
  UNSUB,
}

extension ResponseStatusExtension on SubStatus{
  static const statusCodes = {
    SubStatus.SUB: "sub",
    SubStatus.UNSUB: "unsub",
  };

  String get statusCode => statusCodes[this];
}