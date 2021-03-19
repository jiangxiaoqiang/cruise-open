import 'package:cruise/src/models/Item.dart';
import 'package:cruise/src/models/api/fav_status.dart';
import 'package:cruise/src/models/api/upvote_status.dart';
import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ArticleDetailState> buildReducer() {
  return asReducer(
    <Object, Reducer<ArticleDetailState>>{
      ArticleDetailAction.clear_detail_article: _onClearDetailArticle,
      ArticleDetailAction.set_article: _onSetArticle,
      ArticleDetailAction.vote: _onVote,
      ArticleDetailAction.fav: _onFav,
    },
  );
}

ArticleDetailState _onFav(ArticleDetailState state, Action action) {
  final ArticleDetailState newState = state.clone();
  FavStatus voteType = action.payload as FavStatus;
  if (voteType == FavStatus.FAV && newState.article.isFav != 1) {
    newState.article.isFav = 1;
    newState.article.favCount = newState.article.favCount + 1;
  }
  if (voteType == FavStatus.UNFAV && newState.article.isFav != 0) {
    newState.article.isFav = 0;
    newState.article.favCount = newState.article.favCount - 1;
  }
  return newState;
}

ArticleDetailState _onVote(ArticleDetailState state, Action action) {
  final ArticleDetailState newState = state.clone();
  UpvoteStatus voteType = action.payload as UpvoteStatus;
  if (voteType == UpvoteStatus.UPVOTE && newState.article.isUpvote != 1) {
    newState.article.isUpvote = 1;
    newState.article.upvoteCount = newState.article.upvoteCount + 1;
  }
  if (voteType == UpvoteStatus.UNUPVOTE && newState.article.isUpvote != 0) {
    newState.article.isUpvote = 0;
    newState.article.upvoteCount = newState.article.upvoteCount - 1;
  }
  return newState;
}

ArticleDetailState _onClearDetailArticle(ArticleDetailState state, Action action) {
  final ArticleDetailState newState = state.clone();
  return newState;
}

ArticleDetailState _onSetArticle(ArticleDetailState state, Action action) {
  Item article = action.payload as Item;
  final ArticleDetailState newState = state.clone();
  newState.article = article;
  return newState;
}
