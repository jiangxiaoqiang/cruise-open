
import 'package:cruise/src/page/sub/subarticlepg_component/component.dart';
import 'package:cruise/src/page/sub/subarticlepg_component/state.dart';
import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class SubArticleListComponent extends Component<SubArticleListState> {
  SubArticleListComponent()
      : super(
            reducer: buildReducer(),
            view: buildView,
            effect: buildEffect(),
            dependencies: Dependencies<SubArticleListState>(
                adapter: null,
                slots: <String, Dependent<SubArticleListState>>{
                  'articlepg': SubArticlePgConnector() +
                      SubArticlePgComponent()
                }),);

}
