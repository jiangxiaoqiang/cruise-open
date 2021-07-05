class PayVerifyModel {
  PayVerifyModel({
    this.productId,
    this.receipt,
    this.transactionId,
  });

  List<String>? productId;
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
