import 'package:get/get.dart';
import 'package:wheel/wheel.dart';

import '../../../../common/article_action.dart';
import '../../../../common/repo.dart';
import '../../../../models/Item.dart';
import '../../../../models/api/fav_status.dart';
import '../../../../models/api/upvote_status.dart';

class ArticleDetailController extends GetxController {
  var article = Item();

  @override
  void onInit() {
    super.onInit();
  }

  Future<Item> initArticle(int id) async {
    Item? articleWithContent = await Repo.fetchArticleDetail(id);
    if (articleWithContent != null) {
      return articleWithContent;
    }
    return new Item();
  }

  void upVote() {}

  void handleVoteImpl(UpvoteStatus upvoteStatus, String action, Item item) async {
    HttpResult result = (await ArticleAction.upvote(articleId: item.id.toString(), action: action))!;
    if (result.result == Result.error) {
      ToastUtils.showToast("点赞失败");
    } else {
      if (upvoteStatus.statusCode == "upvote") {
        article.isUpvote = 1;
        article.upvoteCount = article.upvoteCount + 1;
        update();
      }
      if (upvoteStatus.statusCode == "unupvote" && item.upvoteCount > 0) {
        article.isUpvote = 0;
        article.upvoteCount = article.upvoteCount - 1;
        update();
      }
      if (upvoteStatus.statusCode == "downvote") {
        article.isUpvote = -1;
        update();
      }
      ToastUtils.showToast(upvoteStatus.statusCode == "upvote" ? "点赞成功" : "取消点赞成功");
    }
  }

  void handleFavImpl(FavStatus favStatus, String action, Item item) async {
    if (favStatus.statusCode == "fav") {
      article.isFav = 1;
      article.favCount = article.favCount + 1;
      update();
    }
    if (favStatus.statusCode == "unfav" && item.favCount > 0) {
      article.isFav = 0;
      article.favCount = article.favCount - 1;
      update();
    }
    ToastUtils.showToast(favStatus.statusCode == "fav" ? "添加收藏成功" : "取消收藏成功");
  }
}
