class PayVerifyModel {
  PayVerifyModel({this.orderId, this.receipt});

  String? orderId;
  String? receipt;

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'receipt': receipt
    };
  }
}
