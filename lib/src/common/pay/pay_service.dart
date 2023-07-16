import 'dart:async';
import 'dart:convert';

import 'package:cruise/src/common/rest_log.dart';
import 'package:cruise/src/models/pay/pay_verify_model.dart';
import 'package:wheel/wheel.dart' show AppLogHandler, RestApiError, RestClient;

class PayService {
  static Future<int> verifyReceipt(PayVerifyModel payVerifyModel) async {
    try {
      Map jsonMap = payVerifyModel.toMap();
      final response = await RestClient.postHttp("/post/pay/v1/verifyReceipt", jsonMap);
      if (response.statusCode == 200 && response.data["statusCode"] == "200") {
        int result = response.data["result"];
        return result;
      } else {
        RestLog.logger("send verify error:" + response.toString());
        AppLogHandler.logError(RestApiError('Item failed to fetch.'),
            JsonEncoder().convert(response));
      }
    }  on Exception catch (e) {
      RestLog.logger("send verify http error" +e.toString());
    }
    return -1;
  }
}
