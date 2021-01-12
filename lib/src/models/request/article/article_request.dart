
import '../../Item.dart';

class ArticleRequest{
  ArticleRequest({
    this.latestTime,
    this.storiesType,
    this.pageSize,
    this.pageNum,
    this.offset,
  });

  int latestTime;
  StoriesType storiesType;
  int pageSize=100;
  int pageNum = 1;
  int offset;

  Map<String, dynamic> toMap() {
    return {
      'pageSize': pageSize,
      'pageNum': pageNum,
      'offset': offset
    };
  }
}
