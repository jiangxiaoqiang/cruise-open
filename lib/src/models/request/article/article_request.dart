
import '../../Item.dart';

class ArticleRequest{
  ArticleRequest({
    this.latestTime,
    this.storiesType,
    this.pageSize,
  });

  int latestTime;
  StoriesType storiesType;
  int pageSize=20;
}
