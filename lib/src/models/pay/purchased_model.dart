class PurchasedModel {
  PurchasedModel({
    this.productIds
  });

  List<String>? productIds;

  Map<String, dynamic> toMap() {
    return {
      'productId': productIds,
    };
  }
}
