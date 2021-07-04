import 'dart:convert';

class IapProduct {
  IapProduct({
    this.productId = "",
    this.productType = 0,
  });

  String productId;
  int productType;

  factory IapProduct.fromJson(String str) => IapProduct.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory IapProduct.fromMap(Map<String, dynamic> json) => IapProduct(
    productId: json["productId"] == null ? "" : json["productId"],
    productType: json["productType"] == null ? false : json["productType"],
  );

  Map<String, dynamic> toMap() => {
    "productId": productId == null ? null : productId,
    "productType": productType == null ? null : productType
  };
}
