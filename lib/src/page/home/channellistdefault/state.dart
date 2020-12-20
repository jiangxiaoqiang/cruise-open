import 'package:Cruise/src/models/Item.dart';
import 'package:Cruise/src/models/request/article/article_request.dart';
import 'package:fish_redux/fish_redux.dart';

class ChannelListDefaultState implements Cloneable<ChannelListDefaultState> {

  StoriesType storiesType;

  ArticleRequest articleRequest;

  @override
  ChannelListDefaultState clone() {
    return ChannelListDefaultState();
  }
}

ChannelListDefaultState initState(Map<String, dynamic> args) {
  return ChannelListDefaultState();
}
