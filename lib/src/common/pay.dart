import 'dart:async';
import 'dart:convert';

import 'package:cruise/src/common/config/global_config.dart' as global;
import 'package:cruise/src/common/log/cruise_log_handler.dart';
import 'package:cruise/src/common/net/rest/rest_clinet.dart';
import 'package:cruise/src/models/Channel.dart';

import 'log/cruise_api_error.dart';

class Pay {
  static final _itemsChannelCache = <int, Channel>{};
  final baseUrl = global.baseUrl;

  static Future<Channel?> verifyUserPay(int id) async {
    if (_itemsChannelCache.containsKey(id)) {
      return _itemsChannelCache[id];
    } else {
      final response = await RestClient.getHttp("/post/sub/source/detail/$id");
      if (response.statusCode == 200 && response.data["statusCode"] == "200") {
        Map channelResult = response.data["result"];
        if (channelResult != null) {
          // Pay attention: channelResult would be null sometimes
          String jsonContent = JsonEncoder().convert(channelResult);
          Channel parseItem = Channel.fromJson(jsonContent);
          _itemsChannelCache[id] = parseItem;
        }
      } else {
        CruiseLogHandler.logError(CruiseApiError('Item $id failed to fetch.'), JsonEncoder().convert(response));
      }
    }
    return _itemsChannelCache[id];
  }

}
