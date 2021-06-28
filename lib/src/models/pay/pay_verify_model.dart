class PayVerifyModel {
  PayVerifyModel({
    this.productId,
    this.receipt,
    this.transactionId
  });

  String? productId;
  String? receipt;
  String? transactionId;

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'receipt': receipt,
      'transactionId': transactionId
    };
  }
}
