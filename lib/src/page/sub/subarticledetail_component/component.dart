import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class SubArticleDetailComponent extends Component<SubArticleDetailState> {
  SubArticleDetailComponent()
      : super(
            reducer: buildReducer(),
            view: buildView,
            effect: buildEffect(),
            dependencies: Dependencies<SubArticleDetailState>(
                adapter: null,
                slots: <String, Dependent<SubArticleDetailState>>{
                }),);

}
