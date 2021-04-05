
enum LoginType {
  PHONE,
  WECHAT
}

extension ResponseStatusExtension on LoginType{
  static const statusCodes = {
    LoginType.PHONE: 1,
    LoginType.WECHAT: 2,
  };


  int get statusCode => statusCodes[this]!;
}