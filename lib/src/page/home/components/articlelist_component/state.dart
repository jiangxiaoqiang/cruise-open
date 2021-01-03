import 'package:Cruise/src/models/Item.dart';
import 'package:Cruise/src/models/request/article/article_request.dart';
import 'package:Cruise/src/page/home/components/homelistdefault_component/state.dart';
import 'package:fish_redux/fish_redux.dart';

class ArticleListState implements Cloneable<ArticleListState> {
  List<int> articleIds = new List();

  List<Item> articles;

  ArticleRequest articleRequest = new ArticleRequest(
      storiesType: StoriesType.topStories, pageNum: 1, pageSize: 10);

  @override
  ArticleListState clone() {
    return ArticleListState()
      ..articles = this.articles
      ..articleIds = this.articleIds
      ..articleRequest = this.articleRequest;
  }
}

class ArticleListConnector
    extends ConnOp<HomeListDefaultState, ArticleListState> {
  @override
  ArticleListState get(HomeListDefaultState state) {
    if (state.articleListState == null) {
      return new ArticleListState();
    }
    HomeListDefaultState homeListDefaultState = state.clone();
    ArticleListState articleListState = homeListDefaultState.articleListState;
    articleListState.articleIds.add(2236);
    List<Item> items = getStaticArticle();
    articleListState.articles = items;
    return articleListState;
  }

  List<Item> getStaticArticle() {
    List<Item> items = new List();
    Item item = new Item();
    item.id = 2236.toString();
    item.title = "dddd";
    item.favCount = 0;
    item.upvoteCount = 0;
    item.isUpvote = 1;
    item.isFav = 1;
    item.author = "dd";
    item.content = "dddd";
    item.type = StoryType.story;
    item.link = "www.baidu.com";
    item.pubTime = 2222;
    items.add(item);
    return items;
  }
}
