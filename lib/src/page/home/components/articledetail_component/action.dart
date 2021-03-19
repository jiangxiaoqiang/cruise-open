import 'package:cruise/src/models/Item.dart';
import 'package:cruise/src/models/api/fav_status.dart';
import 'package:cruise/src/models/api/upvote_status.dart';
import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum ArticleDetailAction { clear_detail_article, set_article, vote, fav }

class ArticleDetailActionCreator {
  
  static Action onFav(FavStatus favStatus) {
    return Action(ArticleDetailAction.fav, payload: favStatus);
  }

  static Action onVote(UpvoteStatus voteType) {
    return Action(ArticleDetailAction.vote, payload: voteType);
  }

  static Action onClearDetailArticle() {
    return Action(ArticleDetailAction.clear_detail_article);
  }

  static Action onSetArticle(Item article) {
    return Action(ArticleDetailAction.set_article, payload: article);
  }
}
