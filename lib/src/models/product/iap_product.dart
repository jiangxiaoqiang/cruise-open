import 'dart:convert';

class IapProduct {
  IapProduct({
    this.productId = ""
  });

  String productId;

  factory IapProduct.fromJson(String str) => IapProduct.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory IapProduct.fromMap(Map<String, dynamic> json) => IapProduct(
    productId: json["productId"] == null ? "" : json["productId"]
  );

  Map<String, dynamic> toMap() => {
    "productId": productId == null ? null : productId
  };
}
