import 'package:Cruise/src/models/request/article/article_request.dart';
import 'package:fish_redux/fish_redux.dart';

class ChannelsState implements Cloneable<ChannelsState> {

  ArticleRequest type;

  @override
  ChannelsState clone() {
    return ChannelsState();
  }
}

ChannelsState initState(Map<String, dynamic> args) {
  return ChannelsState();
}
