import 'package:cruise/src/common/net/rest/rest_clinet.dart';
import 'package:cruise/src/common/config/global_config.dart' as global;
import 'package:cruise/src/models/Item.dart';
import 'repo.dart';
import 'net/rest/http_result.dart';

class ArticleAction {
  final baseUrl = global.baseUrl;

  static Future<HttpResult?> fav({required String articleId,required String action}) async {
    final response = await RestClient.putHttp("/post/article/" + action + "/" + articleId,null);
    if (response.statusCode == 200 && response.data["statusCode"] == "200") {
      return HttpResult(message: "SMS send success", result: Result.ok);
    }
    return null;
  }

  static Future<HttpResult?> upvote({required String articleId,required String action}) async {
    final response = await RestClient.putHttp("/post/article/" + action + "/" + articleId,null);
    if (response.statusCode == 200 && response.data["statusCode"] == "200") {
      return HttpResult(message: "SMS send success", result: Result.ok);
    }
    return null;
  }

  /// get article by ids
  static Future<List<Item>> fetchArticleByIds(List<int> ids) async {
    List<Item> articles = [];
    for (int id in ids) {
      Item article = (await Repo.fetchArticleItem(id))!;
      articles.add(article);
    }
    return articles;
  }
}
