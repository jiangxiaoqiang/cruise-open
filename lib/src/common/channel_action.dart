import 'package:Cruise/src/common/net/rest/rest_clinet.dart';
import 'package:Cruise/src/common/global.dart' as global;
import 'package:Cruise/src/models/api/sub_status.dart';
import 'net/rest/http_result.dart';

class ChannelAction {
  static const baseUrl = global.baseUrl;

  static Future<HttpResult> sub({String channelId,SubStatus subStatus}) async {
    String url = "/post/sub/source/" + subStatus.statusCode + "/" + channelId;
    final response = await RestClient.putHttp(url,null);
    if (RestClient.respSuccess(response)) {
      return HttpResult(message: "SMS send success", result: Result.ok);
    } else {
      return HttpResult(
          message: "Sub failed.",
          result: Result.error);
    }
  }

  static Future<HttpResult> addChannel({String url}) async {
    Map body = {
      "subUrl": url
    };
    final response = await RestClient.postHttp("/post/sub/source/add",body);
    if (RestClient.respSuccess(response)) {
      return HttpResult(message: "Channel add success", result: Result.ok);
    } else {
      return HttpResult(
          message: "Sub failed.",
          result: Result.error);
    }
  }

}
