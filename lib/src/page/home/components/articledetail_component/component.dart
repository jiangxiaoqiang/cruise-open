import 'package:Cruise/src/page/home/components/articledetail_component/effect.dart';
import 'package:fish_redux/fish_redux.dart';

import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ArticleDetailComponent extends Component<ArticleDetailState> {
  ArticleDetailComponent()
      : super(
            reducer: buildReducer(),
            view: buildView,
            effect: buildEffect(),
            dependencies: Dependencies<ArticleDetailState>(
                adapter: null,
                slots: <String, Dependent<ArticleDetailState>>{
                }),);

}
