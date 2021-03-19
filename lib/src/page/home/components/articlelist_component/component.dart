import 'package:cruise/src/page/home/components/articlepg_component/component.dart';
import 'package:cruise/src/page/home/components/articlepg_component/state.dart';
import 'package:fish_redux/fish_redux.dart';

import './effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ArticleListComponent extends Component<ArticleListState> {
  ArticleListComponent()
      : super(
            reducer: buildReducer(),
            view: buildView,
            effect: buildEffect(),
            dependencies: Dependencies<ArticleListState>(
                adapter: null,
                slots: <String, Dependent<ArticleListState>>{
                  'articlepg': ArticlePgConnector() +
                      ArticlePgComponent()
                }),);

}
