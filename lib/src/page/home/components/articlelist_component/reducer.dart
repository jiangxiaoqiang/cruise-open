import 'package:cruise/src/models/Item.dart';
import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ArticleListState>? buildReducer() {
  return asReducer(
    <Object, Reducer<ArticleListState>>{
      ArticleListAction.set_articles: _onSetArticles,
      ArticleListAction.set_detail_article: _onSetDetailArticle,
      ArticleListAction.remove_articles_by_channel: _onRemoveArticlesByChannel,
    },
  );
}

ArticleListState _onSetDetailArticle(ArticleListState state, Action action) {
  ArticleListState newState = state.clone();
  Item article = (action.payload as Item);
  return newState;
}

ArticleListState _onSetArticles(ArticleListState state, Action action) {
  ArticleListState newState = state.clone();
  List<Item> articles = (action.payload as List<Item>);
  newState.articles = articles;
  return newState;
}

ArticleListState _onRemoveArticlesByChannel(ArticleListState state, Action action) {
  ArticleListState newState = state.clone();
  String channelId = (action.payload as String);
  List<Item> articleItems = List.empty(growable: true);
  if (state.articles.isNotEmpty) {
    state.articles.forEach((element) {
      if (element.subSourceId != channelId) {
        articleItems.add(element);
      }
    });
  }
  newState.articles = articleItems;
  return newState;
}
