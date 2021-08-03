import 'dart:async';
import 'dart:convert';
import 'package:cruise/src/common/config/global_config.dart' as global;
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:wheel/wheel.dart' show AppLogHandler, RestApiError;

import '../net/rest/rest_clinet.dart';

class Product {
  final baseUrl = global.baseUrl;

  static Future<ProductDetailsResponse> getProductInfo() async {
    try {
      final response = await RestClient.getHttp("/post/product/v1/previousPurchase");
      if (response.statusCode == 200 && response.data["statusCode"] == "200") {
        Map iapProductResult = response.data["result"];
        String iapProductJson = JsonEncoder().convert(iapProductResult);
        // ProductDetailsResponse parseItem = ProductDetailsResponse.fromJson(iapProductJson);
        return ProductDetailsResponse(notFoundIDs: [], productDetails: []);
      } else {
        AppLogHandler.logError(RestApiError('Item failed to fetch.'), JsonEncoder().convert(response));
      }
    } on Exception catch (e) {
      // only executed if error is of type Exception
      AppLogHandler.logError(RestApiError("type exception http error"), "type exception http error");
    } catch (error) {
      // executed for errors of all types other than Exception
      AppLogHandler.logError(RestApiError("http error"), "type exception http error");
    }
    return ProductDetailsResponse(notFoundIDs: [], productDetails: []);
  }
}
