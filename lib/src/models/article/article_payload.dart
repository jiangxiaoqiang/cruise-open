import '../Item.dart';
import '../request/article/article_request.dart';

class ArticlePayload {
  ArticleRequest? articleRequest;
  List<int>? articleIds;
  List<ArticleItem>? articles;
}
