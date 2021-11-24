import 'package:wheel/wheel.dart';

class FeedbackRestAction {
  final baseUrl = GlobalConfig.getBaseUrl();

  static Future<HttpResult> submitFeedback(String feedback) async {
    String url = "/post/user/feedback/submit";
    Map data = {
      "feedback": feedback,
      "appId": GlobalConfig.getConfig("appId")
    };
    final response = await RestClient.postHttp(url, data);
    if (RestClient.respSuccess(response)) {
      return HttpResult(message: "Feedback submit success", result: Result.ok);
    } else {
      return HttpResult(message: "Feedback submit failed.", result: Result.error);
    }
  }
}
