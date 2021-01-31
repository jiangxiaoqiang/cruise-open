import 'package:Cruise/src/common/global.dart' as global;
import 'package:Cruise/src/common/net/rest/rest_clinet.dart';
import 'package:Cruise/src/models/Channel.dart';
import 'package:Cruise/src/models/api/sub_status.dart';
import 'package:Cruise/src/models/request/channel/channel_request.dart';

import 'net/rest/http_result.dart';

class ChannelAction {
  static const baseUrl = global.baseUrl;

  static Future<HttpResult> sub({String channelId, SubStatus subStatus}) async {
    String url = "/post/sub/source/" + subStatus.statusCode + "/" + channelId;
    final response = await RestClient.putHttp(url, null);
    if (RestClient.respSuccess(response)) {
      return HttpResult(message: "SMS send success", result: Result.ok);
    } else {
      return HttpResult(message: "Sub failed.", result: Result.error);
    }
  }

  static Future<HttpResult> addChannel({String url}) async {
    Map body = {"subUrl": url};
    final response = await RestClient.postHttp("/post/sub/source/add", body);
    if (RestClient.respSuccess(response)) {
      return HttpResult(message: "Channel add success", result: Result.ok);
    } else {
      return HttpResult(message: "Sub failed.", result: Result.error);
    }
  }

  static Future<List<Channel>> searchChannel(ChannelRequest request) async {
    Map jsonMap = request.toMap();
    final response = await RestClient.postHttp("/post/sub/source/page", jsonMap);
    if (RestClient.respSuccess(response)) {
      var channelResult = response.data["result"];
      if (channelResult == null) {
        return null;
      }
      var channelListResult = channelResult["list"];
      List<Channel> channels = [];
      channelListResult.forEach((element) {
        Channel parsedChannel = Channel.fromMap(element);
        if (parsedChannel != null) {
          channels.add(parsedChannel);
        }
      });
      return channels;
    }
    return null;
  }
}
