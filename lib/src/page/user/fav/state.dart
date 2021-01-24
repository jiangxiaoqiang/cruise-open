import 'package:fish_redux/fish_redux.dart';

class FavArticleState implements Cloneable<FavArticleState> {

  @override
  FavArticleState clone() {
    return FavArticleState();
  }
}

FavArticleState initState(Map<String, dynamic> args) {
  return FavArticleState();
}
