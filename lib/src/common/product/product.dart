import 'dart:async';
import 'dart:convert';

import 'package:cruise/src/common/config/global_config.dart' as global;
import 'package:cruise/src/common/rest_log.dart';
import 'package:cruise/src/models/pay/pay_verify_model.dart';
import 'package:cruise/src/models/product/iap_product.dart';
import 'package:wheel/wheel.dart' show AppLogHandler,RestApiError;
import '../net/rest/rest_clinet.dart';

class Product {
  final baseUrl = global.baseUrl;

  static Future<IapProduct?> getPurchasedStatus(PayVerifyModel payVerifyModel) async {
    try {
      Map jsonMap = payVerifyModel.toMap();
      final response = await RestClient.postHttp("/post/product/v1/previousPurchase", jsonMap);
      if (response.statusCode == 200 && response.data["statusCode"] == "200") {
        int iapProductResult = response.data["result"];
        String iapProductJson = JsonEncoder().convert(iapProductResult);
        IapProduct parseItem = IapProduct.fromJson(iapProductJson);
        return parseItem;
      } else {
        RestLog.logger("send verify error:" + response.toString());
        AppLogHandler.logError(RestApiError('Item failed to fetch.'),
            JsonEncoder().convert(response));
      }
    }  on Exception catch (e) {
      RestLog.logger("getPurchasedStatus http error" +e.toString());
    }
    return null;
  }
}
