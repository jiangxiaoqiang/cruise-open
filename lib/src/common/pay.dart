import 'dart:async';
import 'dart:convert';

import 'package:cruise/src/common/config/global_config.dart' as global;
import 'package:cruise/src/common/rest_log.dart';
import 'package:cruise/src/models/pay/pay_verify_model.dart';
import 'package:wheel/wheel.dart' show AppLogHandler,RestClient,RestApiError;

class Pay {
  final baseUrl = global.baseUrl;

  static Future<void> verifyUserPay(PayVerifyModel payVerifyModel) async {
    try {
      Map jsonMap = payVerifyModel.toMap();
      final response = await RestClient.postHttp( global.baseUrl +
          "/post/pay/v1/success", jsonMap);
      if (response.statusCode == 200 && response.data["statusCode"] == "200") {
        Map channelResult = response.data["result"];
        if (channelResult != null) {
          // Pay attention: channelResult would be null sometimes
          String jsonContent = JsonEncoder().convert(channelResult);
        }
      } else {
        RestLog.logger("send verify error" + payVerifyModel.toString());
        AppLogHandler.logError(RestApiError('Item failed to fetch.'),
            JsonEncoder().convert(response));
      }
    }  on Exception catch (e) {
      RestLog.logger("send verify http error" +e.toString());
    }
  }
}
