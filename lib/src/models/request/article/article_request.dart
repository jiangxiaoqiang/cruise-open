
import 'package:cruise/src/models/enumn/stories_type.dart';

import '../../Item.dart';

class ArticleRequest{
  ArticleRequest({
     this.latestTime,
    required this.storiesType,
     this.pageSize,
    required this.pageNum,
     this.offset,
     this.channelId
  });

  int? latestTime;
  StoriesType storiesType;
  int? pageSize=100;
  int pageNum = 1;
  int? offset;
  int? channelId;

  Map<String, dynamic> toMap() {
    return {
      'pageSize': pageSize,
      'pageNum': pageNum,
      'offset': offset,
      'channelId': channelId
    };
  }
}
