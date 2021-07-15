import 'dart:async';
import 'dart:convert';

import 'package:cruise/src/common/config/global_config.dart' as global;
import 'package:cruise/src/common/rest_log.dart';
import 'package:cruise/src/models/product/iap_product.dart';
import 'package:wheel/wheel.dart' show AppLogHandler,RestApiError;
import '../net/rest/rest_clinet.dart';

class Product {
  final baseUrl = global.baseUrl;

  static Future<IapProduct?> getPurchasedStatus() async {
    try {
      RestLog.logger("get getPurchasedStatus" );
      final response = await RestClient.getHttp("/post/product/v1/previousPurchase");
      if (response.statusCode == 200 && response.data["statusCode"] == "200") {
        RestLog.logger("get product rern:");
        Map iapProductResult = response.data["result"];
        String iapProductJson = JsonEncoder().convert(iapProductResult);
        RestLog.logger("iapProductJson:" + iapProductJson);
        IapProduct parseItem = IapProduct.fromJson(iapProductJson);
        RestLog.logger("get product id:" + parseItem.productId);
        return parseItem;
      } else {
        RestLog.logger("send verify error:" + response.toString());
        AppLogHandler.logError(RestApiError('Item failed to fetch.'),
            JsonEncoder().convert(response));
      }
    } on Exception catch (e) {
      // only executed if error is of type Exception
      RestLog.logger("type exception http error" +e.toString());
    } catch (error){
      // executed for errors of all types other than Exception
      RestLog.logger("getPurchasedStatus http error" +error.toString());
    }
    return null;
  }
}
