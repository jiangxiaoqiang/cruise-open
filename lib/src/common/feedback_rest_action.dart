import 'package:cruise/src/common/config/cruise_global_config.dart' as global;
import 'package:cruise/src/common/net/rest/legacy_rest_clinet.dart';

import 'net/rest/http_result.dart';

class FeedbackRestAction {
  final baseUrl = global.baseUrl;

  static Future<HttpResult> submitFeedback(String feedback) async {
    String url = "/post/user/feedback/submit";
    Map data = {"feedback": feedback};
    final response = await LegacyRestClient.postHttp(url, data);
    if (LegacyRestClient.respSuccess(response)) {
      return HttpResult(message: "Feedback submit success", result: Result.ok);
    } else {
      return HttpResult(message: "Feedback submit failed.", result: Result.error);
    }
  }
}
