import 'package:Cruise/src/models/Item.dart';
import 'package:Cruise/src/models/api/fav_status.dart';
import 'package:Cruise/src/models/api/upvote_status.dart';
import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum ArticleDetailAction { action, clear_detail_artcle, set_article, vote, fav }

class ArticleDetailActionCreator {
  static Action onAction() {
    return const Action(ArticleDetailAction.action);
  }

  static Action onFav(FavStatus favStatus) {
    return Action(ArticleDetailAction.fav, payload: favStatus);
  }

  static Action onVote(UpvoteStatus voteType) {
    return Action(ArticleDetailAction.vote, payload: voteType);
  }

  static Action onClearDetailArticle() {
    return Action(ArticleDetailAction.clear_detail_artcle);
  }

  static Action onSetArticle(Item article) {
    return Action(ArticleDetailAction.set_article, payload: article);
  }
}
