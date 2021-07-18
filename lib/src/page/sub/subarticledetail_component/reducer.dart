import 'package:cruise/src/models/Item.dart';
import 'package:cruise/src/models/api/fav_status.dart';
import 'package:cruise/src/models/api/upvote_status.dart';
import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<SubArticleDetailState> buildReducer() {
  return asReducer(
    <Object, Reducer<SubArticleDetailState>>{
      ArticleDetailAction.clear_detail_article: _onClearDetailArticle,
      ArticleDetailAction.set_article: _onSetArticle,
      ArticleDetailAction.vote: _onVote,
      ArticleDetailAction.fav: _onFav,
      ArticleDetailAction.read: _onRead,
    },
  );
}

SubArticleDetailState _onRead(SubArticleDetailState state, Action action) {
  final SubArticleDetailState newState = state.clone();
  newState.article.readStatus = true;
  return newState;
}

SubArticleDetailState _onFav(SubArticleDetailState state, Action action) {
  final SubArticleDetailState newState = state.clone();
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

SubArticleDetailState _onVote(SubArticleDetailState state, Action action) {
  final SubArticleDetailState newState = state.clone();
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

SubArticleDetailState _onClearDetailArticle(SubArticleDetailState state, Action action) {
  final SubArticleDetailState newState = state.clone();
  return newState;
}

SubArticleDetailState _onSetArticle(SubArticleDetailState state, Action action) {
  Item article = action.payload as Item;
  final SubArticleDetailState newState = state.clone();
  newState.article = article;
  return newState;
}
