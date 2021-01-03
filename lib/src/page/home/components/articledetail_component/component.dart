import 'package:fish_redux/fish_redux.dart';

import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ArticleDetailComponent extends Component<ArticleDetailState> {
  ArticleDetailComponent()
      : super(
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<ArticleDetailState>(
                adapter: null,
                slots: <String, Dependent<ArticleDetailState>>{
                }),);

}
