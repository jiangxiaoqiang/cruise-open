import 'package:get/get.dart';
import 'package:wheel/wheel.dart';

import '../../../../common/article_action.dart';
import '../../../../common/repo.dart';
import '../../../../models/Item.dart';
import '../../../../models/api/fav_status.dart';
import '../../../../models/api/upvote_status.dart';

class ArticleDetailController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> initArticle(int id) async {
    Item? articleWithContent = await Repo.fetchArticleDetail(id);
    if (articleWithContent != null) {
      article.value = articleWithContent;
      update();
    }
  }

  void upVote() {}

  void handleVoteImpl(UpvoteStatus upvoteStatus, String action, Item item) async {
    HttpResult result = (await ArticleAction.upvote(articleId: item.id.toString(), action: action))!;
    if (result.result == Result.error) {
      ToastUtils.showToast("点赞失败");
    } else {
      if (upvoteStatus.statusCode == "upvote") {
        article.value.isUpvote = 1;
        article.value.upvoteCount = article.value.upvoteCount + 1;
        update();
      }
      if (upvoteStatus.statusCode == "unupvote" && item.upvoteCount > 0) {
        article.value.isUpvote = 0;
        article.value.upvoteCount = article.value.upvoteCount - 1;
        update();
      }
      if (upvoteStatus.statusCode == "downvote") {
        article.value.isUpvote = -1;
        update();
      }
      ToastUtils.showToast(upvoteStatus.statusCode == "upvote" ? "点赞成功" : "取消点赞成功");
    }
  }

  void handleFavImpl(FavStatus favStatus, String action, Item item) async {
    if (favStatus.statusCode == "fav") {
      article.value.isFav = 1;
      article.value.favCount = article.value.favCount + 1;
      update();
    }
    if (favStatus.statusCode == "unfav" && item.favCount > 0) {
      article.value.isFav = 0;
      article.value.favCount = article.value.favCount - 1;
      update();
    }
    ToastUtils.showToast(favStatus.statusCode == "fav" ? "添加收藏成功" : "取消收藏成功");
  }

  var article = Item().obs;
}
