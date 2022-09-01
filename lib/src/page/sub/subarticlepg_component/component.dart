import 'package:fish_redux/fish_redux.dart';

import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class SubArticlePgComponent extends Component<SubArticlePgState> {
  SubArticlePgComponent()
      : super(
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<SubArticlePgState>(adapter: null, slots: <String, Dependent<SubArticlePgState>>{}),
        );
}
