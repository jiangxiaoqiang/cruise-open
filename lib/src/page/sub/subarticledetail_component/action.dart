import 'package:cruise/src/models/Item.dart';
import 'package:cruise/src/models/api/fav_status.dart';
import 'package:cruise/src/models/api/upvote_status.dart';
import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum SubArticleDetailAction { clear_detail_article, set_article, vote, fav,read }

class SubArticleDetailActionCreator {
  
  static Action onFav(FavStatus favStatus) {
    return Action(SubArticleDetailAction.fav, payload: favStatus);
  }

  static Action onVote(UpvoteStatus voteType) {
    return Action(SubArticleDetailAction.vote, payload: voteType);
  }

  static Action onClearDetailArticle() {
    return Action(SubArticleDetailAction.clear_detail_article);
  }

  static Action onRead() {
    return const Action(SubArticleDetailAction.read);
  }

  static Action onSetArticle(Item article) {
    return Action(SubArticleDetailAction.set_article, payload: article);
  }
}
