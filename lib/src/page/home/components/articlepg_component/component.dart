import 'package:fish_redux/fish_redux.dart';

import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ArticlePgComponent extends Component<ArticlePgState> {
  ArticlePgComponent()
      : super(
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<ArticlePgState>(adapter: null, slots: <String, Dependent<ArticlePgState>>{}),
        );
}
