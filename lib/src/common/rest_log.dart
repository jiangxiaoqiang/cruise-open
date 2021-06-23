import 'dart:async';
import 'dart:convert';

import 'package:cruise/src/common/config/global_config.dart' as global;
import 'package:cruise/src/models/log/rest_log_model.dart';
import 'package:wheel/wheel.dart' show AppLogHandler,RestApiError;

import 'net/rest/rest_clinet.dart';

class RestLog {

  static Future<void> logger(String restLog) async {
    RestLogModel restLogModel = RestLogModel();
    restLogModel.message = restLog;
      Map jsonMap = restLogModel.toMap();
      try {
        final response = await RestClient.postHttp( "/post/logger/v1/log", jsonMap);
        if (response.statusCode == 200 &&
            response.data["statusCode"] == "200") {
          Map channelResult = response.data["result"];
          if (channelResult != null) {
            // Pay attention: channelResult would be null sometimes
            String jsonContent = JsonEncoder().convert(channelResult);
          }
        } else {
          AppLogHandler.logError(RestApiError('Item failed to fetch.'),
              JsonEncoder().convert(response));
        }
      } on Exception catch (e) {
        print("a");
      }
      }
}
