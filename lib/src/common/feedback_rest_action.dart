import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:wheel/wheel.dart';

class FeedbackRestAction {
  final baseUrl = GlobalConfig.getBaseUrl();

  static Future<Object?> submitFeedback(String feedback) async {
    String url = "/post/user/feedback/submit";
    Map data = {
      "feedback": feedback,
      "appId": GlobalConfig.getConfig("appId")
    };
    final Response response = await RestClient.postHttp(url, data);
    if (RestClient.respSuccess(response)) {
      return "ok";
    } else {
      var data = response.data  as LinkedHashMap<String,Object>;
      return data["msg"];
    }
  }
}
