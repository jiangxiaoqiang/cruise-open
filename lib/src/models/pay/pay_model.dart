import 'package:in_app_purchase/in_app_purchase.dart';

class PayModel {
  PayModel(
      {required this.isAvailable,
      required this.products,
      required this.purchases,
      required this.notFoundIds,
      required this.queryProductError,
      required this.consumables,
      required this.purchasePending,
      required this.loading});

  bool isAvailable = false;
  String queryProductError='';
  List<ProductDetails> products = [];
  List<PurchaseDetails> purchases = [];
  List<String> notFoundIds = [];
  List<String> consumables = [];
  bool purchasePending = false;
  bool loading = true;

  Map<String, dynamic> toMap() {
    return {
      //'pageSize': pageSize,
      //'pageNum': pageNum,
      //'offset': offset,
      //'channelId': channelId
    };
  }
}
