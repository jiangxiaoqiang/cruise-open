import 'package:cruise/src/page/sub/subarticlelist_component/component.dart';
import 'package:cruise/src/page/sub/subarticlelist_component/state.dart';
import 'package:fish_redux/fish_redux.dart';

import './effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class SubListDefaultComponent extends Component<SubListDefaultState> {
  SubListDefaultComponent()
      : super(
          reducer: buildReducer(),
          view: buildView,
          effect: buildEffect(),
          dependencies: Dependencies<SubListDefaultState>(
              adapter: null, slots: <String, Dependent<SubListDefaultState>>{
                'articlelist': SubArticleListConnector() + SubArticleListComponent()
              }),
        );
}
