
import '../../Item.dart';

class ArticleRequest{
  ArticleRequest({
    this.latestTime,
    this.storiesType,
    this.pageSize,
    this.pageNum,
  });

  int latestTime;
  StoriesType storiesType;
  int pageSize=100;
  int pageNum = 1;

  Map<String, dynamic> toMap() {
    return {
      'pageSize': pageSize,
      'pageNum': pageNum,
    };
  }
}
