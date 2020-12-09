import 'package:Cruise/src/common/net/rest/rest_clinet.dart';
import 'package:Cruise/src/common/global.dart' as global;
import 'net/rest/http_result.dart';

class ArticleAction {
  static const baseUrl = global.baseUrl;

  static Future<HttpResult> fav({String articleId,String action}) async {
    final response = await RestClient.putHttp("/post/article/" + action + "/" + articleId,null);
    if (response.statusCode == 200 && response.data["statusCode"] == "200") {
      return HttpResult(message: "SMS send success", result: Result.ok);
    } else {
      return HttpResult(
          message: "Sub failed.",
          result: Result.error);
    }
  }

}
