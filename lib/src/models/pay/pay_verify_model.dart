class PayVerifyModel {
  PayVerifyModel({
    this.productId,
    this.receipt,
    this.transactionId,
    required this.appId
  });

  String? productId;
  String? receipt;
  String? transactionId;
  String appId;

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'receipt': receipt,
      'transactionId': transactionId,
      'appId': appId
    };
  }
}
