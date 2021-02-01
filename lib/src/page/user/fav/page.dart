import 'package:Cruise/src/page/home/components/homelist_component/component.dart';
import 'package:Cruise/src/page/home/components/homelist_component/state.dart';
import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class FavArticlePage extends Page<FavArticleState, Map<String, dynamic>> {
  FavArticlePage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<FavArticleState>(adapter: null, slots: <String, Dependent<FavArticleState>>{
            'homelist': FavArticleConnector() + HomeListComponent(),
          }),
          middleware: <Middleware<FavArticleState>>[],
        );
}
