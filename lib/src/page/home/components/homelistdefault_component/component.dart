import 'package:fish_redux/fish_redux.dart';

import './effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class HomeListDefaultComponent extends Component<HomeListDefaultState> {
  HomeListDefaultComponent()
      : super(
          reducer: buildReducer(),
          view: buildView,
          effect: buildEffect(),
          dependencies: Dependencies<HomeListDefaultState>(adapter: null, slots: <String, Dependent<HomeListDefaultState>>{}),
        );
}
